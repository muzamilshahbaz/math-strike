import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/errors/result.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/core/utils/calendar_day.dart';
import 'package:math_strike/features/rewards/domain/entities/daily_reward.dart';
import 'package:math_strike/features/rewards/domain/entities/reward.dart';
import 'package:math_strike/features/rewards/domain/entities/wallet.dart';
import 'package:math_strike/features/rewards/presentation/controllers/daily_reward_controller.dart';
import 'package:math_strike/features/rewards/presentation/controllers/wallet_controller.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_app.dart';

void main() {
  late InMemoryLocalDatabase database;
  late FakeClock clock;

  setUp(() {
    database = InMemoryLocalDatabase();
    clock = FakeClock(DateTime(2026, 10, 9, 14));
  });

  KeyValueStore rewardsStore() => database.store(StorageBox.rewards);

  test('claiming credits the wallet and persists both', () async {
    final container = createTestContainer(
      database: database,
      overrides: [clock.override],
    );
    expect(container.read(dailyRewardControllerProvider).canClaim, isTrue);

    final result = await container
        .read(dailyRewardControllerProvider.notifier)
        .claim();

    expect(result.valueOrNull?.reward, const Reward(coins: 50));
    expect(container.read(walletControllerProvider).coins, 50);
    expect(container.read(dailyRewardControllerProvider).canClaim, isFalse);
    expect(
      Wallet.fromJson(rewardsStore().readJson(RewardsKeys.wallet)!).coins,
      50,
    );
    expect(
      DailyRewardRecord.fromJson(
        rewardsStore().readJson(RewardsKeys.dailyReward)!,
      ).lastClaimDay,
      const CalendarDay(2026, 10, 9),
    );
  });

  test('a second claim on the same day fails and grants nothing', () async {
    final container = createTestContainer(
      database: database,
      overrides: [clock.override],
    );
    final controller = container.read(dailyRewardControllerProvider.notifier);

    await controller.claim();
    final again = await controller.claim();

    expect(again, isA<Err<DailyRewardClaim>>());
    expect(container.read(walletControllerProvider).coins, 50);
  });

  test('concurrent claims (double tap) grant the reward once', () async {
    final container = createTestContainer(
      database: database,
      overrides: [clock.override],
    );
    final controller = container.read(dailyRewardControllerProvider.notifier);

    final results = await Future.wait([controller.claim(), controller.claim()]);

    expect(results.where((r) => r.isSuccess), hasLength(1));
    expect(container.read(walletControllerProvider).coins, 50);
  });

  test(
    'the next day continues the streak, even if the app stayed open',
    () async {
      final container = createTestContainer(
        database: database,
        overrides: [clock.override],
      );
      final controller = container.read(dailyRewardControllerProvider.notifier);
      await controller.claim();

      clock.advance(const Duration(days: 1));
      // claim() re-reads the clock itself.
      final result = await controller.claim();

      expect(result.valueOrNull?.cycleDay, 2);
      expect(container.read(walletControllerProvider).coins, 50 + 75);
      expect(container.read(dailyRewardControllerProvider).streak, 2);
    },
  );

  test('current day rolls over at midnight', () async {
    final container = createTestContainer(
      database: database,
      overrides: [clock.override],
    );
    await container.read(dailyRewardControllerProvider.notifier).claim();
    expect(container.read(dailyRewardControllerProvider).canClaim, isFalse);

    clock.now = DateTime(2026, 10, 10, 0, 0, 5);
    container.read(currentDayProvider.notifier).refresh();

    expect(container.read(currentDayProvider), const CalendarDay(2026, 10, 10));
    expect(container.read(dailyRewardControllerProvider).canClaim, isTrue);
  });

  test('reloads after local data is replaced (restore)', () async {
    final container = createTestContainer(
      database: database,
      overrides: [clock.override],
    );
    expect(container.read(walletControllerProvider).coins, 0);

    await rewardsStore().writeJson(
      RewardsKeys.wallet,
      const Wallet(coins: 900, xp: 300).toJson(),
    );
    await rewardsStore().writeJson(
      RewardsKeys.dailyReward,
      const DailyRewardRecord(
        lastClaimDay: CalendarDay(2026, 10, 9),
        streak: 3,
      ).toJson(),
    );
    container.read(localDataEpochProvider.notifier).bump();

    expect(container.read(walletControllerProvider).coins, 900);
    expect(container.read(dailyRewardControllerProvider).canClaim, isFalse);
    expect(container.read(dailyRewardControllerProvider).streak, 3);
  });

  test('unreadable reward data falls back to empty defaults', () async {
    await rewardsStore().write(RewardsKeys.wallet, '{not json');
    await rewardsStore().write(RewardsKeys.dailyReward, '{"lastClaimDay": 4}');
    final container = createTestContainer(
      database: database,
      overrides: [clock.override],
    );

    expect(container.read(walletControllerProvider), const Wallet());
    expect(container.read(dailyRewardControllerProvider).canClaim, isTrue);
  });

  test('wallet credit persists rewards from gameplay', () async {
    final container = createTestContainer(database: database);

    await container
        .read(walletControllerProvider.notifier)
        .credit(const Reward(coins: 30, xp: 120));

    expect(container.read(walletControllerProvider).level.level, 2);
    expect(
      Wallet.fromJson(rewardsStore().readJson(RewardsKeys.wallet)!),
      const Wallet(coins: 30, xp: 120),
    );
  });
}

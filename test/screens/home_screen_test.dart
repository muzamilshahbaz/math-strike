import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/core/utils/calendar_day.dart';
import 'package:math_strike/features/rewards/domain/entities/daily_reward.dart';
import 'package:math_strike/features/rewards/domain/entities/wallet.dart';
import 'package:math_strike/features/rewards/presentation/controllers/wallet_controller.dart';
import 'package:math_strike/features/rewards/presentation/widgets/daily_reward_sheet.dart';
import 'package:math_strike/features/statistics/domain/entities/game_session_summary.dart';
import 'package:math_strike/features/statistics/domain/entities/player_statistics.dart';
import 'package:math_strike/routing/app_routes.dart';
import 'package:math_strike/screens/home/widgets/player_header.dart';

import '../helpers/fake_clock.dart';
import '../helpers/test_app.dart';

void main() {
  late InMemoryLocalDatabase database;
  late FakeClock clock;

  setUp(() {
    database = InMemoryLocalDatabase();
    clock = FakeClock(DateTime(2026, 10, 9, 18, 30));
  });

  Future<void> pumpHome(
    WidgetTester tester, {
    Size size = const Size(400, 860),
  }) => tester.pumpMathStrikeApp(
    database: database,
    size: size,
    overrides: [clock.override],
  );

  Future<void> seedWallet(Wallet wallet) => database
      .store(StorageBox.rewards)
      .writeJson(RewardsKeys.wallet, wallet.toJson());

  group('Dashboard', () {
    testWidgets('greets the player and shows level, XP and balances', (
      tester,
    ) async {
      await seedWallet(const Wallet(coins: 1250, diamonds: 4, xp: 300));
      await pumpHome(tester);

      expect(find.text('Good evening'), findsOneWidget);
      expect(find.text(testProfile.name), findsOneWidget);
      expect(find.text('LV 3'), findsOneWidget);
      expect(find.text('Rookie'), findsOneWidget);
      expect(find.text('50 / 200 XP'), findsOneWidget);
      expect(find.bySemanticsLabel('1,250 coins'), findsOneWidget);
      expect(find.bySemanticsLabel('4 diamonds'), findsOneWidget);
    });

    testWidgets("shows today's statistics", (tester) async {
      await database
          .store(StorageBox.statistics)
          .writeJson(
            StatisticsKeys.player,
            const PlayerStatistics()
                .record(
                  GameSessionSummary(
                    endedAt: DateTime(2026, 10, 9, 17),
                    duration: const Duration(minutes: 5),
                    questionsAnswered: 20,
                    correctAnswers: 17,
                  ),
                  const CalendarDay(2026, 10, 9),
                )
                .toJson(),
          );
      await pumpHome(tester);
      await tester.scrollUntilVisible(find.text("Today's stats"), 200);

      expect(find.bySemanticsLabel('Questions answered: 20'), findsOneWidget);
      expect(find.bySemanticsLabel('Accuracy: 85%'), findsOneWidget);
      expect(find.bySemanticsLabel('Time played: 5m'), findsOneWidget);
    });

    testWidgets('See progress switches to the Progress tab', (tester) async {
      await pumpHome(tester);

      await tester.scrollUntilVisible(find.text('See progress'), 200);
      await tester.tap(find.text('See progress'));
      await tester.pumpAndSettle();

      expect(tester.currentLocation, AppRoutes.progress);
      expect(find.text('No games yet'), findsOneWidget);
    });

    testWidgets('wide windows use two columns', (tester) async {
      await pumpHome(tester, size: const Size(1440, 900));

      final header = tester.getTopLeft(find.byType(PlayerHeader));
      final reward = tester.getTopLeft(find.text('Day 1 reward is ready!'));
      expect(reward.dx, greaterThan(header.dx + 300));
      expect((reward.dy - header.dy).abs(), lessThan(60));
    });

    testWidgets('lays out without overflow at 200% text', (tester) async {
      await seedWallet(const Wallet(coins: 123456, diamonds: 789, xp: 5000));
      await tester.pumpMathStrikeAppAtSplash(
        database: database,
        size: const Size(400, 860),
        overrides: [clock.override],
      );
      await tester.pumpAndSettle();
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Quick play'), findsOneWidget);
    });
  });

  group('Daily reward', () {
    testWidgets('claiming from the sheet credits the wallet', (tester) async {
      await pumpHome(tester);
      expect(find.text('Day 1 reward is ready!'), findsOneWidget);

      await tester.tap(find.text('Claim'));
      await tester.pumpAndSettle();
      expect(find.byType(DailyRewardSheet), findsOneWidget);
      // Covers the navigation bar rather than opening inside the tab.
      final sheet = tester.element(find.byType(DailyRewardSheet));
      expect(
        Navigator.of(sheet),
        same(Navigator.of(sheet, rootNavigator: true)),
      );
      expect(
        find.bySemanticsLabel('Day 1, 50 coins, ready to claim'),
        findsOneWidget,
      );

      await tester.tap(find.text('Claim day 1 reward'));
      await tester.pumpAndSettle();

      expect(find.text('Reward claimed!'), findsOneWidget);
      expect(tester.appContainer.read(walletControllerProvider).coins, 50);

      await tester.tap(find.text('Awesome!'));
      await tester.pumpAndSettle();

      expect(find.byType(DailyRewardSheet), findsNothing);
      expect(find.text('Daily reward collected'), findsOneWidget);
      expect(find.text('Next reward in 5h 30m'), findsOneWidget);
      expect(find.bySemanticsLabel('50 coins'), findsWidgets);
    });

    testWidgets('a collected reward shows tomorrow and a countdown', (
      tester,
    ) async {
      await database
          .store(StorageBox.rewards)
          .writeJson(
            RewardsKeys.dailyReward,
            const DailyRewardRecord(
              lastClaimDay: CalendarDay(2026, 10, 9),
              streak: 3,
              longestStreak: 3,
              totalClaims: 3,
            ).toJson(),
          );
      await pumpHome(tester);

      expect(find.text('3-day streak'), findsOneWidget);
      await tester.tap(find.text('Daily reward collected'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Come back tomorrow for day 4'), findsOne);
      expect(
        find.bySemanticsLabel('Day 3, 100 coins, 25 XP, claimed'),
        findsOne,
      );
      expect(find.text('Next reward in 5h 30m'), findsWidgets);
    });

    testWidgets('missing a day explains that the streak restarted', (
      tester,
    ) async {
      await database
          .store(StorageBox.rewards)
          .writeJson(
            RewardsKeys.dailyReward,
            const DailyRewardRecord(
              lastClaimDay: CalendarDay(2026, 10, 6),
              streak: 5,
            ).toJson(),
          );
      await pumpHome(tester);

      await tester.tap(find.text('Claim'));
      await tester.pumpAndSettle();

      expect(find.textContaining('streak starts again'), findsOneWidget);
      expect(find.text('Claim day 1 reward'), findsOneWidget);
    });

    testWidgets('the Home tab is badged until the reward is claimed', (
      tester,
    ) async {
      await pumpHome(tester);
      Badge homeBadge() => tester.widget<Badge>(find.byType(Badge).first);
      expect(homeBadge().isLabelVisible, isTrue);

      await tester.tap(find.text('Claim'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Claim day 1 reward'));
      await tester.pumpAndSettle();

      expect(homeBadge().isLabelVisible, isFalse);
    });
  });

  test('greetingFor follows the time of day', () {
    expect(greetingFor(DateTime(2026, 1, 1, 7)), 'Good morning');
    expect(greetingFor(DateTime(2026, 1, 1, 13)), 'Good afternoon');
    expect(greetingFor(DateTime(2026, 1, 1, 19)), 'Good evening');
    expect(greetingFor(DateTime(2026, 1, 1, 2)), 'Hello');
  });
}

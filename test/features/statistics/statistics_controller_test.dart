import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/statistics/domain/entities/game_session_summary.dart';
import 'package:math_strike/features/statistics/domain/entities/player_statistics.dart';
import 'package:math_strike/features/statistics/presentation/controllers/statistics_controller.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_app.dart';

void main() {
  final game = GameSessionSummary(
    endedAt: DateTime(2026, 10, 9, 15),
    duration: const Duration(minutes: 3),
    questionsAnswered: 12,
    correctAnswers: 9,
  );

  test('recordSession saves and publishes the new totals', () async {
    final database = InMemoryLocalDatabase();
    final container = createTestContainer(
      database: database,
      overrides: [FakeClock(DateTime(2026, 10, 9, 20)).override],
    );

    await container
        .read(statisticsControllerProvider.notifier)
        .recordSession(game);

    expect(
      container
          .read(periodTotalsProvider(StatisticsPeriod.today))
          .questionsAnswered,
      12,
    );
    expect(
      container.read(activityHistoryProvider(7)).last.$2.correctAnswers,
      9,
    );
    final saved = PlayerStatistics.fromJson(
      database.store(StorageBox.statistics).readJson(StatisticsKeys.player)!,
    );
    expect(saved.overall.gamesPlayed, 1);
  });

  test('games count towards the day they ended on', () async {
    final container = createTestContainer(
      overrides: [FakeClock(DateTime(2026, 10, 10, 9)).override],
    );

    await container
        .read(statisticsControllerProvider.notifier)
        .recordSession(game);

    expect(
      container.read(periodTotalsProvider(StatisticsPeriod.today)).isEmpty,
      isTrue,
    );
    expect(
      container
          .read(periodTotalsProvider(StatisticsPeriod.week))
          .questionsAnswered,
      12,
    );
  });

  test('unreadable statistics start fresh; restores reload', () async {
    final database = InMemoryLocalDatabase();
    await database
        .store(StorageBox.statistics)
        .write(StatisticsKeys.player, '[]');
    final container = createTestContainer(database: database);
    expect(container.read(statisticsControllerProvider).hasPlayed, isFalse);

    await database
        .store(StorageBox.statistics)
        .writeJson(
          StatisticsKeys.player,
          const PlayerStatistics(bestStreak: 12).toJson(),
        );
    container.read(localDataEpochProvider.notifier).bump();

    expect(container.read(statisticsControllerProvider).bestStreak, 12);
  });
}

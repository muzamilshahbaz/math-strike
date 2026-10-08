import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/core/utils/calendar_day.dart';
import 'package:math_strike/features/statistics/domain/entities/game_session_summary.dart';
import 'package:math_strike/features/statistics/domain/entities/player_statistics.dart';
import 'package:math_strike/features/statistics/presentation/widgets/activity_chart.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_app.dart';

void main() {
  const today = CalendarDay(2026, 10, 9);

  GameSessionSummary game(int questions, int correct) => GameSessionSummary(
    endedAt: DateTime(2026, 10, 9, 12),
    duration: const Duration(minutes: 2),
    questionsAnswered: questions,
    correctAnswers: correct,
    totalReactionTime: Duration(seconds: questions * 2),
    bestStreak: 7,
    highestCombo: 4,
  );

  Future<void> pumpProgress(
    WidgetTester tester, {
    PlayerStatistics? statistics,
  }) async {
    final database = InMemoryLocalDatabase();
    if (statistics != null) {
      await database
          .store(StorageBox.statistics)
          .writeJson(StatisticsKeys.player, statistics.toJson());
    }
    await tester.pumpMathStrikeApp(
      database: database,
      overrides: [FakeClock(DateTime(2026, 10, 9, 20)).override],
    );
    await tester.tap(find.text('Progress').last);
    await tester.pumpAndSettle();
  }

  testWidgets('invites new players to play', (tester) async {
    await pumpProgress(tester);

    expect(find.text('No games yet'), findsOneWidget);
    expect(find.bySemanticsLabel('Accuracy: —'), findsOneWidget);
  });

  testWidgets('summarises the selected period', (tester) async {
    await pumpProgress(
      tester,
      statistics: const PlayerStatistics()
          .record(game(10, 9), today)
          .record(game(30, 15), today.addDays(-10))
          .record(game(60, 60), today.addDays(-40)),
    );

    expect(find.text('No games yet'), findsNothing);
    // Default: last 7 days.
    expect(find.bySemanticsLabel('Questions answered: 10'), findsOneWidget);
    expect(find.bySemanticsLabel('Accuracy: 90%'), findsOneWidget);
    expect(find.bySemanticsLabel('Average reaction: 2.0s'), findsOneWidget);

    await tester.tap(find.text('30 days'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Questions answered: 40'), findsOneWidget);
    expect(find.bySemanticsLabel('Mistakes: 16'), findsOneWidget);
    expect(
      tester.widget<ActivityChart>(find.byType(ActivityChart)).history,
      hasLength(30),
    );

    await tester.tap(find.text('All time'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Questions answered: 100'), findsOneWidget);
    expect(find.bySemanticsLabel('Games played: 3'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('All-time bests'), 200);
    expect(find.bySemanticsLabel('Best answer streak: 7'), findsOneWidget);
    expect(find.bySemanticsLabel('Highest combo: ×4'), findsOneWidget);
  });

  testWidgets('the activity chart is described for screen readers', (
    tester,
  ) async {
    await pumpProgress(
      tester,
      statistics: const PlayerStatistics()
          .record(game(10, 9), today)
          .record(game(5, 5), today.addDays(-2)),
    );

    expect(
      find.bySemanticsLabel(
        RegExp('15 questions answered over the last 7 days, played on 2'),
      ),
      findsOneWidget,
    );
  });
}

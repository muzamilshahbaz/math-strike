import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/utils/calendar_day.dart';
import 'package:math_strike/features/statistics/domain/entities/game_session_summary.dart';
import 'package:math_strike/features/statistics/domain/entities/player_statistics.dart';

void main() {
  const today = CalendarDay(2026, 10, 9);

  GameSessionSummary session({
    int questions = 10,
    int correct = 8,
    int streak = 5,
    int combo = 3,
    bool completed = true,
  }) => GameSessionSummary(
    endedAt: DateTime(2026, 10, 9, 15),
    duration: const Duration(minutes: 4),
    questionsAnswered: questions,
    correctAnswers: correct,
    totalReactionTime: Duration(milliseconds: questions * 1500),
    bestStreak: streak,
    highestCombo: combo,
    levelCompleted: completed,
  );

  test('empty statistics have no derived values', () {
    const stats = PlayerStatistics();

    expect(stats.hasPlayed, isFalse);
    expect(stats.overall.accuracy, isNull);
    expect(stats.overall.averageReaction, isNull);
    expect(stats.totalsFor(StatisticsPeriod.week, today).isEmpty, isTrue);
  });

  test('recording a game updates overall and per-day totals', () {
    final stats = const PlayerStatistics().record(session(), today);

    expect(stats.hasPlayed, isTrue);
    expect(stats.overall.gamesPlayed, 1);
    expect(stats.overall.questionsAnswered, 10);
    expect(stats.overall.mistakes, 2);
    expect(stats.overall.accuracy, 0.8);
    expect(stats.overall.averageReaction, const Duration(milliseconds: 1500));
    expect(stats.overall.timePlayed, const Duration(minutes: 4));
    expect(stats.overall.levelsCompleted, 1);
    expect(stats.totalsOn(today), stats.overall);
    expect(stats.bestStreak, 5);
    expect(stats.highestCombo, 3);
    expect(stats.lastPlayedAt, DateTime(2026, 10, 9, 15));
  });

  test('bests keep the maximum across games', () {
    final stats = const PlayerStatistics()
        .record(session(streak: 9, combo: 2), today)
        .record(session(streak: 4, combo: 6), today);

    expect(stats.bestStreak, 9);
    expect(stats.highestCombo, 6);
    expect(stats.totalsOn(today).gamesPlayed, 2);
  });

  test('period totals include only days inside the window', () {
    final stats = const PlayerStatistics()
        .record(session(questions: 10, correct: 10), today)
        .record(session(questions: 20, correct: 10), today.addDays(-6))
        .record(session(questions: 40, correct: 20), today.addDays(-7))
        .record(session(questions: 80, correct: 40), today.addDays(-29));

    expect(
      stats.totalsFor(StatisticsPeriod.today, today).questionsAnswered,
      10,
    );
    expect(stats.totalsFor(StatisticsPeriod.week, today).questionsAnswered, 30);
    expect(
      stats.totalsFor(StatisticsPeriod.month, today).questionsAnswered,
      150,
    );
    expect(
      stats.totalsFor(StatisticsPeriod.overall, today).questionsAnswered,
      150,
    );
  });

  test('history lists every day oldest first, including empty days', () {
    final stats = const PlayerStatistics().record(session(), today.addDays(-2));
    final history = stats.history(today, 4);

    expect(
      [for (final (day, _) in history) day],
      [today.addDays(-3), today.addDays(-2), today.addDays(-1), today],
    );
    expect([for (final (_, t) in history) t.questionsAnswered], [0, 10, 0, 0]);
  });

  test('old per-day history is pruned but overall totals are kept', () {
    final old = today.addDays(-PlayerStatistics.retainedDays);
    final stats = const PlayerStatistics()
        .record(session(), old)
        .record(session(), today);

    expect(stats.days.keys, [today.toKey()]);
    expect(stats.overall.gamesPlayed, 2);
  });

  test('survives a JSON round trip', () {
    final stats = const PlayerStatistics()
        .record(session(), today)
        .record(session(), today.addDays(-3));

    expect(PlayerStatistics.fromJson(stats.toJson()), stats);
  });
}

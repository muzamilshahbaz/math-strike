import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/calendar_day.dart';
import 'game_session_summary.dart';

part 'player_statistics.freezed.dart';
part 'player_statistics.g.dart';

/// Time windows the statistics can be summarised over.
enum StatisticsPeriod {
  /// The current calendar day.
  today('Today', 1),

  /// The last 7 days, including today.
  week('7 days', 7),

  /// The last 30 days, including today.
  month('30 days', 30),

  /// Everything since the first game.
  overall('All time', null);

  const StatisticsPeriod(this.label, this.days);

  /// Short player-facing label.
  final String label;

  /// Number of days covered, or `null` for [overall].
  final int? days;
}

/// Additive gameplay counters for some span of time.
@freezed
abstract class StatTotals with _$StatTotals {
  /// Creates totals.
  const factory StatTotals({
    @Default(0) int gamesPlayed,
    @Default(0) int questionsAnswered,
    @Default(0) int correctAnswers,
    @Default(0) int timePlayedMs,

    /// Sum of per-question reaction times.
    @Default(0) int reactionTimeMs,
    @Default(0) int levelsCompleted,
  }) = _StatTotals;

  const StatTotals._();

  /// Deserialises totals.
  factory StatTotals.fromJson(Map<String, dynamic> json) =>
      _$StatTotalsFromJson(json);

  /// The counters contributed by one game.
  factory StatTotals.fromSession(GameSessionSummary session) => StatTotals(
    gamesPlayed: 1,
    questionsAnswered: session.questionsAnswered,
    correctAnswers: session.correctAnswers,
    timePlayedMs: session.duration.inMilliseconds,
    reactionTimeMs: session.totalReactionTime.inMilliseconds,
    levelsCompleted: session.levelCompleted ? 1 : 0,
  );

  /// Wrong answers.
  int get mistakes => questionsAnswered - correctAnswers;

  /// Share of correct answers (0–1), or `null` before any question.
  double? get accuracy =>
      questionsAnswered == 0 ? null : correctAnswers / questionsAnswered;

  /// Mean time to answer a question, or `null` before any question.
  Duration? get averageReaction => questionsAnswered == 0
      ? null
      : Duration(milliseconds: reactionTimeMs ~/ questionsAnswered);

  /// Total time played.
  Duration get timePlayed => Duration(milliseconds: timePlayedMs);

  /// Whether nothing has been played.
  bool get isEmpty => gamesPlayed == 0;

  /// The sum of these and [other] totals.
  StatTotals operator +(StatTotals other) => StatTotals(
    gamesPlayed: gamesPlayed + other.gamesPlayed,
    questionsAnswered: questionsAnswered + other.questionsAnswered,
    correctAnswers: correctAnswers + other.correctAnswers,
    timePlayedMs: timePlayedMs + other.timePlayedMs,
    reactionTimeMs: reactionTimeMs + other.reactionTimeMs,
    levelsCompleted: levelsCompleted + other.levelsCompleted,
  );
}

/// Everything the game tracks about the player's performance.
///
/// [overall] holds lifetime totals; [days] keeps per-day totals (keyed by
/// [CalendarDay.toKey]) for the last [retainedDays] days, which is enough
/// for daily, weekly and monthly summaries and the activity charts.
@freezed
abstract class PlayerStatistics with _$PlayerStatistics {
  /// Creates statistics.
  const factory PlayerStatistics({
    @Default(StatTotals()) StatTotals overall,
    @Default(<String, StatTotals>{}) Map<String, StatTotals> days,

    /// Longest run of consecutive correct answers ever.
    @Default(0) int bestStreak,

    /// Highest combo ever reached.
    @Default(0) int highestCombo,

    /// When the last game ended.
    DateTime? lastPlayedAt,
  }) = _PlayerStatistics;

  const PlayerStatistics._();

  /// Deserialises statistics.
  factory PlayerStatistics.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatisticsFromJson(json);

  /// How many days of per-day history are kept.
  static const int retainedDays = 400;

  /// Whether at least one game has been played.
  bool get hasPlayed => !overall.isEmpty;

  /// Totals for a single [day].
  StatTotals totalsOn(CalendarDay day) =>
      days[day.toKey()] ?? const StatTotals();

  /// Totals for [period], ending on [today].
  StatTotals totalsFor(StatisticsPeriod period, CalendarDay today) {
    final count = period.days;
    if (count == null) return overall;
    var sum = const StatTotals();
    for (var i = 0; i < count; i++) {
      sum += totalsOn(today.addDays(-i));
    }
    return sum;
  }

  /// Per-day totals for the [count] days ending on [today], oldest first.
  List<(CalendarDay, StatTotals)> history(CalendarDay today, int count) => [
    for (var i = count - 1; i >= 0; i--)
      (today.addDays(-i), totalsOn(today.addDays(-i))),
  ];

  /// These statistics with [session] added to [day] (the local calendar
  /// day it ended on). Days older than [retainedDays] are dropped.
  PlayerStatistics record(GameSessionSummary session, CalendarDay day) {
    final added = StatTotals.fromSession(session);
    final oldestKept = day.addDays(-(retainedDays - 1));
    return copyWith(
      overall: overall + added,
      days: {
        for (final MapEntry(:key, :value) in days.entries)
          if (!(CalendarDay.tryParse(key)?.isBefore(oldestKept) ?? true))
            key: value,
        day.toKey(): totalsOn(day) + added,
      },
      bestStreak: math.max(bestStreak, session.bestStreak),
      highestCombo: math.max(highestCombo, session.highestCombo),
      lastPlayedAt: session.endedAt,
    );
  }
}

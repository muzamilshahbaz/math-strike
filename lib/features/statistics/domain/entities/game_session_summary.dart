import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session_summary.freezed.dart';

/// What happened in one finished game, reported by gameplay (Phase 7) to
/// be added to the player's statistics.
@freezed
abstract class GameSessionSummary with _$GameSessionSummary {
  /// Creates a summary.
  @Assert('correctAnswers >= 0 && correctAnswers <= questionsAnswered')
  const factory GameSessionSummary({
    /// When the game ended; decides which day it counts towards.
    required DateTime endedAt,

    /// Time actually spent playing.
    required Duration duration,
    required int questionsAnswered,
    required int correctAnswers,

    /// Sum of the time taken to answer each question.
    @Default(Duration.zero) Duration totalReactionTime,

    /// Longest run of consecutive correct answers.
    @Default(0) int bestStreak,

    /// Highest combo multiplier reached.
    @Default(0) int highestCombo,

    /// Whether the level was completed.
    @Default(false) bool levelCompleted,
  }) = _GameSessionSummary;
}

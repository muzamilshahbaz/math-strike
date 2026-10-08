import 'package:freezed_annotation/freezed_annotation.dart';

import 'math_topic.dart';

part 'topic_mastery.freezed.dart';
part 'topic_mastery.g.dart';

/// How well the player knows one topic.
@freezed
abstract class TopicMastery with _$TopicMastery {
  /// Creates mastery data.
  const factory TopicMastery({
    /// Continuous skill estimate; the whole part is the level (1–10).
    required double rating,
    @Default(0) int attempts,
    @Default(0) int correct,

    /// Most recent results, oldest first (at most [recentWindow]).
    @Default(<bool>[]) List<bool> recent,

    /// Current run of correct answers.
    @Default(0) int streak,
    DateTime? lastPracticedAt,
  }) = _TopicMastery;

  const TopicMastery._();

  /// Deserialises mastery data.
  factory TopicMastery.fromJson(Map<String, dynamic> json) =>
      _$TopicMasteryFromJson(json);

  /// How many recent results are kept for weak-topic detection.
  static const int recentWindow = 12;

  /// Current level, 1–10.
  int get level => rating.floor().clamp(1, 10);

  /// Share of recent answers that were correct, or `null` with no history.
  double? get recentAccuracy => recent.isEmpty
      ? null
      : recent.where((correct) => correct).length / recent.length;

  /// Share of all answers that were correct, or `null` before any.
  double? get accuracy => attempts == 0 ? null : correct / attempts;
}

/// How a topic is going, for weak-topic detection and recommendations.
enum TopicStrength {
  /// Never practised.
  notStarted('New'),

  /// Recent accuracy is low: needs practice.
  weak('Needs practice'),

  /// Some practice, neither weak nor strong yet.
  developing('Improving'),

  /// Consistently accurate.
  strong('Strong');

  const TopicStrength(this.label);

  /// Player-facing label.
  final String label;
}

/// The player's mastery of every topic they have practised.
@freezed
abstract class LearningProgress with _$LearningProgress {
  /// Creates progress data.
  const factory LearningProgress({
    /// Keyed by [MathTopic.name]; unknown names (from newer app versions)
    /// are kept but ignored.
    @Default(<String, TopicMastery>{}) Map<String, TopicMastery> topics,
  }) = _LearningProgress;

  const LearningProgress._();

  /// Deserialises progress data.
  factory LearningProgress.fromJson(Map<String, dynamic> json) =>
      _$LearningProgressFromJson(json);

  /// Mastery of [topic], or `null` if it has never been practised.
  TopicMastery? masteryOf(MathTopic topic) => topics[topic.name];

  /// This progress with [topic] set to [mastery].
  LearningProgress withMastery(MathTopic topic, TopicMastery mastery) =>
      copyWith(topics: {...topics, topic.name: mastery});
}

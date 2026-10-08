import 'package:flutter/foundation.dart';

import '../../../profile/domain/entities/age_group.dart';
import '../../../profile/domain/entities/difficulty.dart';
import '../entities/math_topic.dart';

/// What the math engine may ask a player, derived from their age group and
/// chosen difficulty.
///
/// * The **age group** decides which topics are available, the highest
///   level and how many answer choices appear.
/// * The **difficulty** decides where an unpractised topic starts within
///   that range and how much time each answer gets.
///
/// The adaptive model then moves each topic up or down from its start.
@immutable
final class DifficultyProfile {
  /// Creates a profile.
  const DifficultyProfile({
    required this.topics,
    required this.maxLevel,
    required this.startLevel,
    required this.choiceCount,
    required this.answerTime,
  });

  /// The profile for [ageGroup] at [difficulty].
  factory DifficultyProfile.of(AgeGroup ageGroup, Difficulty difficulty) {
    final (topics, maxLevel, choices, timeFactor) = switch (ageGroup) {
      AgeGroup.preschool => (_preschool, 3, 3, 1.6),
      AgeGroup.earlyPrimary => (_earlyPrimary, 6, 4, 1.3),
      AgeGroup.latePrimary => (_latePrimary, 9, 4, 1.1),
      AgeGroup.teen ||
      AgeGroup.adult ||
      AgeGroup.custom => (MathTopic.values, 10, 4, 1.0),
    };
    final (startShare, seconds) = switch (difficulty) {
      Difficulty.easy => (0.0, 20),
      Difficulty.medium => (0.25, 15),
      Difficulty.hard => (0.5, 11),
      Difficulty.expert => (0.7, 8),
    };
    return DifficultyProfile(
      topics: [
        for (final topic in MathTopic.values)
          if (topics.contains(topic)) topic,
      ],
      maxLevel: maxLevel,
      startLevel: 1 + ((maxLevel - 1) * startShare).floor(),
      choiceCount: choices,
      answerTime: Duration(milliseconds: (seconds * 1000 * timeFactor).round()),
    );
  }

  static const List<MathTopic> _preschool = [
    MathTopic.addition,
    MathTopic.subtraction,
    MathTopic.geometry,
  ];

  static const List<MathTopic> _earlyPrimary = [
    ..._preschool,
    MathTopic.multiplication,
    MathTopic.division,
    MathTopic.time,
    MathTopic.money,
    MathTopic.measurement,
    MathTopic.wordProblems,
  ];

  static const List<MathTopic> _latePrimary = [
    ..._earlyPrimary,
    MathTopic.fractions,
    MathTopic.decimals,
    MathTopic.percentages,
    MathTopic.probability,
    MathTopic.statistics,
  ];

  /// Topics available to the player, in catalogue order.
  final List<MathTopic> topics;

  /// Highest level any topic can reach.
  final int maxLevel;

  /// Level of a topic the player has not practised yet.
  final int startLevel;

  /// Number of answer choices per question.
  final int choiceCount;

  /// Time allowed per answer; answering well inside it counts as fast.
  final Duration answerTime;

  /// Whether [topic] is available.
  bool includes(MathTopic topic) => topics.contains(topic);

  /// [level] limited to 1–[maxLevel].
  int clampLevel(int level) => level.clamp(1, maxLevel);
}

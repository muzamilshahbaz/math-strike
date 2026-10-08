import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../difficulty/difficulty_profile.dart';
import '../entities/math_topic.dart';
import '../entities/topic_mastery.dart';

/// The result of answering one question, fed into [AdaptiveModel.record].
@immutable
final class AnswerOutcome {
  /// Creates an outcome.
  const AnswerOutcome({
    required this.correct,
    required this.level,
    required this.reactionTime,
    this.usedHint = false,
  });

  /// Whether the answer was right.
  final bool correct;

  /// Level of the question that was answered.
  final int level;

  /// Time from showing the question to answering it.
  final Duration reactionTime;

  /// Whether the hint was shown first (a hinted answer counts as slow).
  final bool usedHint;
}

/// Pure rules of adaptive learning.
///
/// Each topic has a continuous rating whose whole part is its level. A
/// correct answer nudges it up (more for fast answers and harder
/// questions), a wrong one pulls it down more sharply, so players settle
/// where they answer most questions correctly but still feel stretched.
///
/// Topics are classified as weak or strong from recent accuracy, and mixed
/// practice leans towards weak, new and long-unpractised topics.
final class AdaptiveModel {
  /// Creates the model.
  const AdaptiveModel();

  /// Recent results needed before a topic can be called weak or strong.
  static const int minResultsToJudge = 5;

  /// Days without practice after which a topic is due for revision.
  static const int revisionAfterDays = 3;

  /// Mastery for a topic the player has never practised.
  TopicMastery initial(DifficultyProfile profile) =>
      TopicMastery(rating: profile.startLevel.toDouble());

  /// [mastery] (or the initial mastery) updated with [outcome] at [at].
  TopicMastery record(
    TopicMastery? mastery,
    AnswerOutcome outcome,
    DifficultyProfile profile,
    DateTime at,
  ) {
    final current = mastery ?? initial(profile);
    final levelGap = outcome.level - current.level;
    final double change;
    if (outcome.correct) {
      final fast =
          !outcome.usedHint && outcome.reactionTime < profile.answerTime * 0.4;
      final slow =
          outcome.usedHint || outcome.reactionTime > profile.answerTime;
      final base = fast ? 0.35 : (slow ? 0.12 : 0.25);
      final difficulty = levelGap > 0 ? 1.5 : (levelGap < 0 ? 0.5 : 1.0);
      final streakBonus = current.streak >= 2 ? 0.1 : 0.0;
      change = base * difficulty + streakBonus;
    } else {
      // Missing a stretch question is forgivable; missing an easier one
      // is a clear sign the level is too high.
      change = levelGap > 0 ? -0.25 : (levelGap < 0 ? -0.6 : -0.45);
    }
    final recent = [...current.recent, outcome.correct];
    return current.copyWith(
      rating: (current.rating + change).clamp(1.0, profile.maxLevel + 0.99),
      attempts: current.attempts + 1,
      correct: current.correct + (outcome.correct ? 1 : 0),
      recent: recent.length > TopicMastery.recentWindow
          ? recent.sublist(recent.length - TopicMastery.recentWindow)
          : recent,
      streak: outcome.correct ? current.streak + 1 : 0,
      lastPracticedAt: at,
    );
  }

  /// The level of the next question: usually the current level, sometimes
  /// one below (consolidation) or one above (stretch).
  int pickLevel(
    TopicMastery mastery,
    DifficultyProfile profile,
    math.Random random,
  ) {
    final roll = random.nextDouble();
    final offset = roll < 0.15 ? -1 : (roll < 0.30 ? 1 : 0);
    return profile.clampLevel(mastery.level + offset);
  }

  /// How [mastery] is going (`null` means never practised).
  TopicStrength strength(TopicMastery? mastery) {
    if (mastery == null || mastery.attempts == 0) {
      return TopicStrength.notStarted;
    }
    if (mastery.recent.length < minResultsToJudge) {
      return TopicStrength.developing;
    }
    final accuracy = mastery.recentAccuracy!;
    if (accuracy < 0.6) return TopicStrength.weak;
    if (accuracy >= 0.85 && mastery.attempts >= 10) return TopicStrength.strong;
    return TopicStrength.developing;
  }

  /// How strongly mixed practice should favour [topic].
  double weight(TopicMastery? mastery, DateTime now) {
    final base = switch (strength(mastery)) {
      TopicStrength.weak => 3.0,
      TopicStrength.notStarted => 2.0,
      TopicStrength.developing => 1.5,
      TopicStrength.strong => 0.6,
    };
    final last = mastery?.lastPracticedAt;
    final due =
        last != null && now.difference(last).inDays >= revisionAfterDays;
    return due ? base * 1.5 : base;
  }

  /// Picks a topic for mixed practice from the profile's topics, weighted
  /// by [weight]. [avoid] (e.g. the previous topic) is skipped when there
  /// is any alternative.
  MathTopic pickTopic(
    LearningProgress progress,
    DifficultyProfile profile,
    math.Random random,
    DateTime now, {
    MathTopic? avoid,
  }) {
    final candidates = [
      for (final topic in profile.topics)
        if (topic != avoid || profile.topics.length == 1) topic,
    ];
    final weights = [
      for (final topic in candidates) weight(progress.masteryOf(topic), now),
    ];
    var roll = random.nextDouble() * weights.fold(0.0, (a, b) => a + b);
    for (final (i, topic) in candidates.indexed) {
      roll -= weights[i];
      if (roll < 0) return topic;
    }
    return candidates.last;
  }
}

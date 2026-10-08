import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../domain/adaptive/adaptive_model.dart';
import '../../domain/entities/math_topic.dart';
import '../../domain/entities/topic_mastery.dart';
import '../../math_providers.dart';

part 'learning_controller.g.dart';

/// The player's per-topic mastery, updated after every answer.
///
/// Requires an opened database: only read it after start-up completes.
@Riverpod(keepAlive: true)
class LearningController extends _$LearningController {
  @override
  LearningProgress build() {
    // Reload when local data is replaced (restore / reset).
    ref.watch(localDataEpochProvider);
    return ref.watch(learningRepositoryProvider).load();
  }

  /// Mastery of [topic], or the starting mastery if never practised.
  TopicMastery masteryOf(MathTopic topic) =>
      state.masteryOf(topic) ??
      ref
          .read(adaptiveModelProvider)
          .initial(ref.read(difficultyProfileProvider));

  /// Applies [outcome] to [topic] and saves the result.
  Future<Result<void>> recordAnswer(
    MathTopic topic,
    AnswerOutcome outcome,
  ) async {
    final updated = state.withMastery(
      topic,
      ref
          .read(adaptiveModelProvider)
          .record(
            state.masteryOf(topic),
            outcome,
            ref.read(difficultyProfileProvider),
            ref.read(clockProvider)(),
          ),
    );
    state = updated;
    return ref.read(learningRepositoryProvider).save(updated);
  }
}

/// A topic's standing, for the topic picker and progress screens.
@immutable
final class TopicSummary {
  /// Creates a summary.
  const TopicSummary({
    required this.topic,
    required this.mastery,
    required this.strength,
  });

  /// The topic.
  final MathTopic topic;

  /// Its mastery (starting mastery when never practised).
  final TopicMastery mastery;

  /// How it is going.
  final TopicStrength strength;

  /// Current level.
  int get level => mastery.level;
}

/// Summaries of every topic available to the player, in catalogue order.
@riverpod
List<TopicSummary> topicSummaries(Ref ref) {
  final progress = ref.watch(learningControllerProvider);
  final profile = ref.watch(difficultyProfileProvider);
  final model = ref.watch(adaptiveModelProvider);
  return [
    for (final topic in profile.topics)
      TopicSummary(
        topic: topic,
        mastery: progress.masteryOf(topic) ?? model.initial(profile),
        strength: model.strength(progress.masteryOf(topic)),
      ),
  ];
}

import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/math/domain/entities/math_topic.dart';
import 'package:math_strike/features/math/domain/entities/topic_mastery.dart';
import 'package:math_strike/features/math/math_providers.dart';
import 'package:math_strike/features/math/presentation/controllers/learning_controller.dart';
import 'package:math_strike/features/math/presentation/controllers/practice_session_controller.dart';
import 'package:math_strike/features/profile/domain/entities/age_group.dart';
import 'package:math_strike/features/profile/domain/entities/difficulty.dart';
import 'package:math_strike/features/statistics/presentation/controllers/statistics_controller.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_app.dart';

void main() {
  late InMemoryLocalDatabase database;
  late FakeClock clock;
  late ProviderContainer container;

  setUp(() async {
    database = InMemoryLocalDatabase();
    clock = FakeClock(DateTime(2026, 10, 9, 16));
    container = createTestContainer(
      database: database,
      overrides: [
        clock.override,
        mathRandomProvider.overrideWithValue(math.Random(4)),
      ],
    );
  });

  /// Keeps an auto-dispose session alive for the test and returns its
  /// provider.
  PracticeSessionControllerProvider session([MathTopic? topic]) {
    final provider = practiceSessionControllerProvider(topic);
    container.listen(provider, (_, _) {});
    return provider;
  }

  Future<void> answerAll(
    PracticeSessionControllerProvider provider, {
    required bool correctly,
  }) async {
    final controller = container.read(provider.notifier);
    while (!container.read(provider).finished) {
      final question = container.read(provider).question;
      clock.advance(const Duration(seconds: 3));
      await controller.answer(
        correctly
            ? question.answerIndex
            : (question.answerIndex + 1) % question.choices.length,
      );
      await controller.next();
    }
  }

  test('a topic session asks only that topic', () async {
    final provider = session(MathTopic.multiplication);
    final controller = container.read(provider.notifier);
    for (var i = 0; i < 5; i++) {
      expect(container.read(provider).question.topic, MathTopic.multiplication);
      await controller.answer(0);
      await controller.next();
    }
  });

  test('answering records the result and the reaction time', () async {
    final provider = session(MathTopic.addition);
    final question = container.read(provider).question;
    clock.advance(const Duration(seconds: 4));

    await container.read(provider.notifier).answer(question.answerIndex);

    final state = container.read(provider);
    expect(state.answered, isTrue);
    expect(state.lastCorrect, isTrue);
    expect(state.streak, 1);
    expect(state.answers.single.reactionTime, const Duration(seconds: 4));
    expect(state.startLevels[MathTopic.addition], 3);
    expect(
      container
          .read(learningControllerProvider)
          .masteryOf(MathTopic.addition)!
          .attempts,
      1,
    );
  });

  test('a question can only be answered once', () async {
    final provider = session(MathTopic.addition);
    final controller = container.read(provider.notifier);
    final question = container.read(provider).question;
    final wrong = (question.answerIndex + 1) % question.choices.length;

    await controller.answer(wrong);
    await controller.answer(question.answerIndex);

    expect(container.read(provider).selected, wrong);
    expect(container.read(provider).answers, hasLength(1));
  });

  test('next is ignored until the question is answered', () async {
    final provider = session(MathTopic.addition);
    await container.read(provider.notifier).next();
    expect(container.read(provider).number, 1);
  });

  test('a hinted answer is remembered and the hint resets', () async {
    final provider = session(MathTopic.addition);
    final controller = container.read(provider.notifier)..showHint();
    expect(container.read(provider).hintShown, isTrue);

    await controller.answer(container.read(provider).question.answerIndex);
    expect(container.read(provider).answers.single.usedHint, isTrue);

    await controller.next();
    expect(container.read(provider).hintShown, isFalse);
  });

  test('finishing adds the session to the statistics', () async {
    final provider = session(MathTopic.addition);
    await answerAll(provider, correctly: true);

    final state = container.read(provider);
    expect(state.finished, isTrue);
    expect(state.correctCount, 10);
    expect(state.bestStreak, 10);
    expect(state.mistakes, isEmpty);
    final stats = container.read(statisticsControllerProvider).overall;
    expect(stats.gamesPlayed, 1);
    expect(stats.questionsAnswered, 10);
    expect(stats.correctAnswers, 10);
    expect(stats.reactionTimeMs, 30000);
  });

  test('a perfect session levels the topic up and persists it', () async {
    await answerAll(session(MathTopic.subtraction), correctly: true);

    final mastery = container
        .read(learningControllerProvider)
        .masteryOf(MathTopic.subtraction)!;
    expect(mastery.level, greaterThan(3));
    final saved = LearningProgress.fromJson(
      database.store(StorageBox.learning).readJson(LearningKeys.progress)!,
    );
    expect(saved.masteryOf(MathTopic.subtraction), mastery);
  });

  test('wrong answers are collected for review and lower the level', () async {
    final provider = session(MathTopic.division);
    await answerAll(provider, correctly: false);

    expect(container.read(provider).mistakes, hasLength(10));
    expect(
      container
          .read(learningControllerProvider.notifier)
          .masteryOf(MathTopic.division)
          .level,
      1,
    );
    expect(
      container
          .read(topicSummariesProvider)
          .firstWhere((t) => t.topic == MathTopic.division)
          .strength,
      TopicStrength.weak,
    );
  });

  test('the recommended mix rotates topics for the player', () async {
    final provider = session();
    final controller = container.read(provider.notifier);
    final topics = <MathTopic>{};
    MathTopic? previous;
    for (var i = 0; i < 10; i++) {
      final topic = container.read(provider).question.topic;
      expect(topic, isNot(previous), reason: 'same topic twice in a row');
      topics.add(topic);
      previous = topic;
      await controller.answer(0);
      await controller.next();
    }
    expect(topics.length, greaterThan(3));
  });

  test('a young player only gets their topics, levels and choices', () async {
    await database
        .store(StorageBox.profile)
        .writeJson(
          ProfileKeys.player,
          testProfile
              .copyWith(
                ageGroup: AgeGroup.preschool,
                difficulty: Difficulty.hard,
              )
              .toJson(),
        );
    container.read(localDataEpochProvider.notifier).bump();
    final provider = session();
    final controller = container.read(provider.notifier);
    for (var i = 0; i < 10; i++) {
      final question = container.read(provider).question;
      expect(const [
        MathTopic.addition,
        MathTopic.subtraction,
        MathTopic.geometry,
      ], contains(question.topic));
      expect(question.level, lessThanOrEqualTo(3));
      expect(question.choices.length, lessThanOrEqualTo(3));
      await controller.answer(question.answerIndex);
      await controller.next();
    }
  });

  test('unreadable learning data starts fresh', () async {
    await database
        .store(StorageBox.learning)
        .write(LearningKeys.progress, '{bad');
    container.read(localDataEpochProvider.notifier).bump();
    expect(container.read(learningControllerProvider).topics, isEmpty);
  });
}

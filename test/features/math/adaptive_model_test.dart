import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/features/math/domain/adaptive/adaptive_model.dart';
import 'package:math_strike/features/math/domain/difficulty/difficulty_profile.dart';
import 'package:math_strike/features/math/domain/entities/math_topic.dart';
import 'package:math_strike/features/math/domain/entities/topic_mastery.dart';
import 'package:math_strike/features/profile/domain/entities/age_group.dart';
import 'package:math_strike/features/profile/domain/entities/difficulty.dart';

void main() {
  const model = AdaptiveModel();
  final adult = DifficultyProfile.of(AgeGroup.adult, Difficulty.medium);
  final now = DateTime(2026, 10, 9, 12);

  AnswerOutcome outcome({
    bool correct = true,
    int level = 3,
    int seconds = 5,
    bool hint = false,
  }) => AnswerOutcome(
    correct: correct,
    level: level,
    reactionTime: Duration(seconds: seconds),
    usedHint: hint,
  );

  TopicMastery answerMany(int count, {required bool correct, int? level}) {
    TopicMastery? mastery;
    for (var i = 0; i < count; i++) {
      mastery = model.record(
        mastery,
        outcome(correct: correct, level: level ?? mastery?.level ?? 3),
        adult,
        now,
      );
    }
    return mastery!;
  }

  group('DifficultyProfile', () {
    test('age groups unlock more topics and higher levels', () {
      final preschool = DifficultyProfile.of(
        AgeGroup.preschool,
        Difficulty.easy,
      );
      final early = DifficultyProfile.of(
        AgeGroup.earlyPrimary,
        Difficulty.easy,
      );
      final late = DifficultyProfile.of(AgeGroup.latePrimary, Difficulty.easy);

      expect(preschool.topics, [
        MathTopic.addition,
        MathTopic.subtraction,
        MathTopic.geometry,
      ]);
      expect(preschool.maxLevel, 3);
      expect(preschool.choiceCount, 3);
      expect(early.includes(MathTopic.multiplication), isTrue);
      expect(early.includes(MathTopic.fractions), isFalse);
      expect(late.includes(MathTopic.fractions), isTrue);
      expect(late.includes(MathTopic.algebra), isFalse);
      expect(adult.topics, MathTopic.values);
      expect(adult.maxLevel, 10);
    });

    test('difficulty sets the starting level and the answer time', () {
      int start(Difficulty d) =>
          DifficultyProfile.of(AgeGroup.adult, d).startLevel;
      expect([for (final d in Difficulty.values) start(d)], [1, 3, 5, 7]);
      expect(
        DifficultyProfile.of(AgeGroup.preschool, Difficulty.expert).startLevel,
        lessThanOrEqualTo(3),
      );
      expect(
        DifficultyProfile.of(AgeGroup.adult, Difficulty.expert).answerTime,
        lessThan(
          DifficultyProfile.of(AgeGroup.adult, Difficulty.easy).answerTime,
        ),
      );
      expect(
        DifficultyProfile.of(AgeGroup.preschool, Difficulty.medium).answerTime,
        greaterThan(adult.answerTime),
      );
    });
  });

  group('rating updates', () {
    test('an unpractised topic starts at the profile start level', () {
      expect(model.initial(adult).level, adult.startLevel);
    });

    test('correct answers raise the level; mistakes lower it', () {
      expect(answerMany(8, correct: true).level, greaterThan(3));
      expect(answerMany(4, correct: false).level, lessThan(3));
    });

    test('fast answers earn more than slow or hinted ones', () {
      double after(AnswerOutcome o) => model.record(null, o, adult, now).rating;
      final fast = after(outcome(seconds: 2));
      final normal = after(outcome(seconds: 8));
      final slow = after(outcome(seconds: 30));
      final hinted = after(outcome(seconds: 2, hint: true));
      expect(fast, greaterThan(normal));
      expect(normal, greaterThan(slow));
      expect(hinted, slow);
    });

    test('harder questions earn more; easier misses cost more', () {
      double after(AnswerOutcome o) => model.record(null, o, adult, now).rating;
      expect(after(outcome(level: 4)), greaterThan(after(outcome(level: 3))));
      expect(after(outcome(level: 2)), lessThan(after(outcome(level: 3))));
      expect(
        after(outcome(correct: false, level: 2)),
        lessThan(after(outcome(correct: false, level: 4))),
      );
    });

    test('ratings stay within 1 and the profile maximum', () {
      final preschool = DifficultyProfile.of(
        AgeGroup.preschool,
        Difficulty.easy,
      );
      TopicMastery? m;
      for (var i = 0; i < 50; i++) {
        m = model.record(m, outcome(level: 3, seconds: 1), preschool, now);
      }
      expect(m!.level, 3);
      expect(answerMany(30, correct: false).rating, 1.0);
    });

    test('tracks attempts, accuracy, streak and a bounded history', () {
      var m = answerMany(15, correct: true);
      m = model.record(m, outcome(correct: false), adult, now);

      expect(m.attempts, 16);
      expect(m.correct, 15);
      expect(m.streak, 0);
      expect(m.recent, hasLength(TopicMastery.recentWindow));
      expect(m.recent.last, isFalse);
      expect(m.lastPracticedAt, now);
    });
  });

  group('strength', () {
    test('needs enough results before judging', () {
      expect(model.strength(null), TopicStrength.notStarted);
      expect(
        model.strength(answerMany(3, correct: false)),
        TopicStrength.developing,
      );
    });

    test('low recent accuracy is weak; high and sustained is strong', () {
      expect(model.strength(answerMany(6, correct: false)), TopicStrength.weak);
      expect(
        model.strength(answerMany(12, correct: true)),
        TopicStrength.strong,
      );
      expect(
        model.strength(answerMany(6, correct: true)),
        TopicStrength.developing,
        reason: 'strong needs at least 10 attempts',
      );
    });
  });

  group('topic selection', () {
    test('mixed practice favours weak topics', () {
      final profile = DifficultyProfile.of(AgeGroup.preschool, Difficulty.easy);
      final progress = const LearningProgress()
          .withMastery(MathTopic.addition, answerMany(12, correct: true))
          .withMastery(MathTopic.subtraction, answerMany(8, correct: false))
          .withMastery(MathTopic.geometry, answerMany(12, correct: true));
      final random = math.Random(1);
      final counts = <MathTopic, int>{};
      for (var i = 0; i < 1000; i++) {
        final topic = model.pickTopic(progress, profile, random, now);
        counts[topic] = (counts[topic] ?? 0) + 1;
      }
      expect(
        counts[MathTopic.subtraction],
        greaterThan(counts[MathTopic.addition]! * 3),
      );
    });

    test('topics not practised for days are due for revision', () {
      final mastery = answerMany(12, correct: true);
      expect(
        model.weight(mastery, now.add(const Duration(days: 5))),
        greaterThan(model.weight(mastery, now)),
      );
    });

    test('the previous topic is avoided when possible', () {
      final random = math.Random(2);
      for (var i = 0; i < 50; i++) {
        expect(
          model.pickTopic(
            const LearningProgress(),
            adult,
            random,
            now,
            avoid: MathTopic.addition,
          ),
          isNot(MathTopic.addition),
        );
      }
    });

    test('question levels stay near the current level', () {
      final random = math.Random(3);
      final mastery = model.initial(adult).copyWith(rating: 5.5);
      final levels = {
        for (var i = 0; i < 200; i++) model.pickLevel(mastery, adult, random),
      };
      expect(levels, {4, 5, 6});
    });
  });

  test('learning progress survives JSON and ignores unknown topics', () {
    final progress = const LearningProgress().withMastery(
      MathTopic.algebra,
      answerMany(3, correct: true),
    );
    final json = progress.toJson()
      ..['topics'] = {
        ...(progress.toJson()['topics'] as Map<String, dynamic>),
        'quantumPhysics': {'rating': 4.0},
      };
    final restored = LearningProgress.fromJson(json);

    expect(
      restored.masteryOf(MathTopic.algebra),
      progress.masteryOf(MathTopic.algebra),
    );
    expect(MathTopic.tryParse('quantumPhysics'), isNull);
  });
}

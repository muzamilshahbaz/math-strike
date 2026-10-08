import 'dart:math' as math;

import '../entities/math_topic.dart';
import '../entities/question.dart';
import 'math_text.dart';

/// Produces one question for [QuestionContext.topic] at
/// [QuestionContext.level].
typedef TopicGenerator = Question Function(QuestionContext context);

/// Everything a [TopicGenerator] needs for one question: the topic and
/// level, a random source, and helpers that turn an answer plus likely
/// mistakes into a shuffled, de-duplicated set of choices.
final class QuestionContext {
  /// Creates a context.
  QuestionContext({
    required this.topic,
    required this.level,
    required this.random,
    this.choiceCount = 4,
  }) : assert(level >= 1 && level <= 10, 'level must be 1–10'),
       assert(choiceCount >= 2, 'need at least two choices');

  /// The topic being asked about.
  final MathTopic topic;

  /// Difficulty level, 1–10.
  final int level;

  /// Random source (seeded in tests for reproducible questions).
  final math.Random random;

  /// Number of answer choices to offer.
  final int choiceCount;

  /// The entry of [byLevel] for the current level (index `level − 1`); the
  /// last entry applies to any higher level.
  T scale<T>(List<T> byLevel) => byLevel[math.min(level, byLevel.length) - 1];

  /// A random integer in `[min, max]`, inclusive.
  int between(int min, int max) {
    assert(max >= min, 'empty range $min..$max');
    return min + random.nextInt(max - min + 1);
  }

  /// A random non-zero integer in `[-max, max]`.
  int nonZero(int max) => between(1, max) * (random.nextBool() ? 1 : -1);

  /// A random element of [items].
  T pick<T>(List<T> items) => items[random.nextInt(items.length)];

  /// True with probability [p].
  bool chance(double p) => random.nextDouble() < p;

  /// Alternative integer answers spreading out from [answer] in steps of
  /// [step], never below [min]; for [question]'s `alternative`.
  String Function(int attempt) nearbyIntegers(
    int answer, {
    int step = 1,
    int? min = 0,
    String Function(int value) format = MathText.integer,
  }) => (attempt) {
    final offset = ((attempt + 1) ~/ 2) * step;
    var value = answer + (random.nextBool() ? offset : -offset);
    if (min != null && value < min) value = answer + offset;
    return format(value);
  };

  /// Builds the question.
  ///
  /// Choices are the [answer], then wrong answers drawn first from
  /// [mistakes] (typical errors, in random order) and then from
  /// [alternative], which is called with increasing attempt numbers and
  /// should drift further from the answer each time. Without an
  /// [alternative] the question may offer fewer than [choiceCount] choices
  /// (never fewer than two).
  Question question({
    required String prompt,
    required String answer,
    required String hint,
    required String explanation,
    Iterable<String> mistakes = const [],
    String Function(int attempt)? alternative,
  }) {
    final choices = <String>{answer};
    for (final mistake in [...mistakes]..shuffle(random)) {
      if (choices.length == choiceCount) break;
      if (mistake.isNotEmpty) choices.add(mistake);
    }
    if (alternative != null) {
      for (var attempt = 1; choices.length < choiceCount; attempt++) {
        if (attempt > 200) {
          throw StateError('Could not find enough choices for "$prompt"');
        }
        choices.add(alternative(attempt));
      }
    }
    if (choices.length < 2) {
      throw StateError('Question "$prompt" has no wrong answers');
    }
    final shuffled = [...choices]..shuffle(random);
    return Question(
      topic: topic,
      level: level,
      prompt: prompt,
      choices: shuffled,
      answerIndex: shuffled.indexOf(answer),
      hint: hint,
      explanation: explanation,
    );
  }
}

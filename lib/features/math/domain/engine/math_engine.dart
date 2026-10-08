import 'dart:collection';
import 'dart:math' as math;

import '../entities/math_topic.dart';
import '../entities/question.dart';
import 'generators/applied_generators.dart';
import 'generators/arithmetic_generators.dart';
import 'generators/data_generators.dart';
import 'generators/number_generators.dart';
import 'question_context.dart';

/// Generates questions for every [MathTopic] at levels 1–10.
///
/// Pure Dart and deterministic for a given [math.Random] seed. Remembers
/// the last [memory] prompts and avoids repeating them, so a session never
/// shows the same question twice in a row.
final class MathEngine {
  /// Creates an engine. [generators] defaults to the full topic set.
  MathEngine({
    math.Random? random,
    Map<MathTopic, TopicGenerator>? generators,
    this.memory = 30,
  }) : _random = random ?? math.Random(),
       _generators = generators ?? defaultGenerators;

  /// Generators for every topic.
  static final Map<MathTopic, TopicGenerator> defaultGenerators = {
    ...arithmeticGenerators,
    ...numberGenerators,
    ...appliedGenerators,
    ...dataGenerators,
  };

  /// Lowest level.
  static const int minLevel = 1;

  /// Highest level.
  static const int maxLevel = 10;

  /// How many recent prompts are remembered to avoid repeats.
  final int memory;

  final math.Random _random;
  final Map<MathTopic, TopicGenerator> _generators;
  final Queue<String> _recent = Queue();

  /// A new question about [topic] at [level] (clamped to 1–10) with
  /// [choiceCount] options.
  Question generate(
    MathTopic topic, {
    required int level,
    int choiceCount = 4,
  }) {
    final generator = _generators[topic];
    if (generator == null) {
      throw ArgumentError.value(topic, 'topic', 'No generator registered');
    }
    final context = QuestionContext(
      topic: topic,
      level: level.clamp(minLevel, maxLevel),
      random: _random,
      choiceCount: choiceCount,
    );
    var question = generator(context);
    // Small ranges (e.g. level 1) can only produce a few distinct
    // questions, so give up after a few tries rather than loop forever.
    for (
      var attempt = 0;
      attempt < 8 && _recent.contains(question.prompt);
      attempt++
    ) {
      question = generator(context);
    }
    _remember(question.prompt);
    return question;
  }

  void _remember(String prompt) {
    _recent.addLast(prompt);
    while (_recent.length > memory) {
      _recent.removeFirst();
    }
  }
}

import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/features/math/domain/engine/math_engine.dart';
import 'package:math_strike/features/math/domain/engine/math_text.dart';
import 'package:math_strike/features/math/domain/entities/math_topic.dart';
import 'package:math_strike/features/math/domain/entities/question.dart';

/// Topics whose questions may legitimately offer fewer choices than asked
/// (their answers come from a small fixed set of words).
const _fixedChoiceTopics = {MathTopic.probability, MathTopic.geometry};

/// Characters the bundled fonts are known to contain. Anything else would
/// need a runtime font download (which the offline-first app must avoid).
final RegExp _fontSafe = RegExp(r'^[ -~−×÷√²³°½·…—–’π\n]*$');

int _parse(String text) =>
    int.parse(text.replaceAll(MathText.minus, '-').replaceAll(',', '').trim());

void main() {
  group('every topic and level produces valid questions', () {
    for (final topic in MathTopic.values) {
      test(topic.label, () {
        for (var level = 1; level <= 10; level++) {
          for (final choices in const [3, 4]) {
            final engine = MathEngine(
              random: math.Random(level * 31 + choices),
            );
            for (var i = 0; i < 150; i++) {
              final Question q;
              try {
                q = engine.generate(topic, level: level, choiceCount: choices);
              } on Object catch (e) {
                fail('$topic level $level (#$i) threw: $e');
              }
              final where = '$topic L$level "${q.prompt}" ${q.choices}';
              expect(q.topic, topic);
              expect(q.level, level);
              expect(
                q.choices.toSet(),
                hasLength(q.choices.length),
                reason: 'duplicate choices: $where',
              );
              if (_fixedChoiceTopics.contains(topic)) {
                expect(
                  q.choices.length,
                  inInclusiveRange(2, choices),
                  reason: where,
                );
              } else {
                expect(q.choices, hasLength(choices), reason: where);
              }
              expect(q.answer, isNotEmpty, reason: where);
              expect(q.prompt.trim(), isNotEmpty);
              expect(q.hint.trim(), isNotEmpty);
              expect(q.explanation.trim(), isNotEmpty);
              for (final text in [
                q.prompt,
                ...q.choices,
                q.hint,
                q.explanation,
              ]) {
                expect(
                  text,
                  matches(_fontSafe),
                  reason: 'unsafe glyph: $where',
                );
                expect(text, isNot(contains('NaN')), reason: where);
                expect(text, isNot(contains('Infinity')), reason: where);
                expect(text, isNot(contains('−0 ')), reason: where);
                expect(text, isNot(contains('null')), reason: where);
              }
            }
          }
        }
      });
    }
  });

  group('arithmetic answers are correct', () {
    final pattern = RegExp(r'^(.+) ([+−×÷]) (.+) = \?$');
    for (final topic in const [
      MathTopic.addition,
      MathTopic.subtraction,
      MathTopic.multiplication,
      MathTopic.division,
    ]) {
      test(topic.label, () {
        final engine = MathEngine(random: math.Random(7));
        for (var level = 1; level <= 10; level++) {
          for (var i = 0; i < 100; i++) {
            final q = engine.generate(topic, level: level);
            final match = pattern.firstMatch(q.prompt)!;
            final a = _parse(match.group(1)!);
            final b = _parse(match.group(3)!);
            final expected = switch (match.group(2)) {
              '+' => a + b,
              '−' => a - b,
              '×' => a * b,
              _ => a ~/ b,
            };
            if (match.group(2) == '÷') expect(a % b, 0, reason: q.prompt);
            expect(_parse(q.answer), expected, reason: q.prompt);
            expect(expected, greaterThanOrEqualTo(0), reason: q.prompt);
          }
        }
      });
    }
  });

  test('numbers grow with the level', () {
    final engine = MathEngine(random: math.Random(3));
    double averageAnswer(int level) {
      var sum = 0;
      for (var i = 0; i < 200; i++) {
        sum += _parse(engine.generate(MathTopic.addition, level: level).answer);
      }
      return sum / 200;
    }

    expect(averageAnswer(1), lessThan(averageAnswer(4)));
    expect(averageAnswer(4), lessThan(averageAnswer(8)));
  });

  test('the same seed produces the same questions', () {
    List<String> run() {
      final engine = MathEngine(random: math.Random(42));
      return [
        for (final topic in MathTopic.values)
          engine.generate(topic, level: 5).prompt,
      ];
    }

    expect(run(), run());
  });

  test('recent prompts are not repeated', () {
    final engine = MathEngine(random: math.Random(9));
    final prompts = [
      for (var i = 0; i < 20; i++)
        engine.generate(MathTopic.multiplication, level: 4).prompt,
    ];
    expect(prompts.toSet(), hasLength(20));
  });

  test('levels outside 1–10 are clamped', () {
    final engine = MathEngine(random: math.Random(1));
    expect(engine.generate(MathTopic.addition, level: 0).level, 1);
    expect(engine.generate(MathTopic.addition, level: 99).level, 10);
  });

  test('answer positions are spread across the choices', () {
    final engine = MathEngine(random: math.Random(5));
    final positions = <int>{
      for (var i = 0; i < 40; i++)
        engine.generate(MathTopic.addition, level: 3).answerIndex,
    };
    expect(positions, {0, 1, 2, 3});
  });
}

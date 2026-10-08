import 'package:freezed_annotation/freezed_annotation.dart';

import 'math_topic.dart';

part 'question.freezed.dart';

/// A multiple-choice math question produced by the engine.
///
/// In gameplay each choice becomes a target to shoot; in practice mode a
/// button to tap.
@freezed
abstract class Question with _$Question {
  /// Creates a question. [choices] are unique and contain the answer at
  /// [answerIndex].
  @Assert('answerIndex >= 0 && answerIndex < choices.length')
  const factory Question({
    required MathTopic topic,

    /// Difficulty level, 1–10.
    required int level,

    /// The question text, e.g. `7 + 5 = ?`.
    required String prompt,

    /// Answer options in display order.
    required List<String> choices,

    /// Index of the correct option in [choices].
    required int answerIndex,

    /// A nudge in the right direction, shown on request.
    required String hint,

    /// How to get the answer, shown after answering.
    required String explanation,
  }) = _Question;

  const Question._();

  /// The correct option.
  String get answer => choices[answerIndex];

  /// Whether choosing option [index] is correct.
  bool isCorrect(int index) => index == answerIndex;
}

import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../statistics/domain/entities/game_session_summary.dart';
import '../../../statistics/presentation/controllers/statistics_controller.dart';
import '../../domain/adaptive/adaptive_model.dart';
import '../../domain/entities/math_topic.dart';
import '../../domain/entities/question.dart';
import '../../math_providers.dart';
import 'learning_controller.dart';

part 'practice_session_controller.freezed.dart';
part 'practice_session_controller.g.dart';

/// One answered practice question.
@freezed
abstract class PracticeAnswer with _$PracticeAnswer {
  /// Creates an answer record.
  const factory PracticeAnswer({
    required Question question,
    required int selectedIndex,
    required Duration reactionTime,
    @Default(false) bool usedHint,
  }) = _PracticeAnswer;

  const PracticeAnswer._();

  /// Whether the chosen option was right.
  bool get correct => question.isCorrect(selectedIndex);
}

/// The state of a practice session.
@freezed
abstract class PracticeSession with _$PracticeSession {
  /// Creates a session state.
  const factory PracticeSession({
    /// The topic being practised, or `null` for a recommended mix.
    MathTopic? focus,
    required Question question,

    /// 1-based number of the current question.
    @Default(1) int number,
    required int total,

    /// The option chosen for the current question, once answered.
    int? selected,
    @Default(false) bool hintShown,
    @Default(<PracticeAnswer>[]) List<PracticeAnswer> answers,
    @Default(0) int streak,
    @Default(0) int bestStreak,

    /// Each practised topic's level before its first answer this session.
    @Default(<MathTopic, int>{}) Map<MathTopic, int> startLevels,
    required DateTime startedAt,
    required DateTime questionShownAt,
    @Default(false) bool finished,
  }) = _PracticeSession;

  const PracticeSession._();

  /// Whether the current question has been answered.
  bool get answered => selected != null;

  /// Whether the current answer was right.
  bool get lastCorrect => answered && question.isCorrect(selected!);

  /// Correct answers so far.
  int get correctCount => answers.where((a) => a.correct).length;

  /// Answers that were wrong, for the mistake review.
  List<PracticeAnswer> get mistakes =>
      answers.where((a) => !a.correct).toList();
}

/// Runs a 10-question practice session on one topic, or a recommended mix
/// when [focus] is `null`. Every answer updates the adaptive model at once;
/// a finished session is also added to the statistics.
@riverpod
class PracticeSessionController extends _$PracticeSessionController {
  /// Questions per session.
  static const int length = 10;

  @override
  PracticeSession build(MathTopic? focus) {
    final now = ref.read(clockProvider)();
    return PracticeSession(
      focus: focus,
      question: _nextQuestion(focus, previous: null),
      total: length,
      startedAt: now,
      questionShownAt: now,
    );
  }

  Question _nextQuestion(MathTopic? focus, {required MathTopic? previous}) {
    final profile = ref.read(difficultyProfileProvider);
    final model = ref.read(adaptiveModelProvider);
    final random = ref.read(mathRandomProvider);
    final topic =
        focus ??
        model.pickTopic(
          ref.read(learningControllerProvider),
          profile,
          random,
          ref.read(clockProvider)(),
          avoid: previous,
        );
    final mastery = ref
        .read(learningControllerProvider.notifier)
        .masteryOf(topic);
    return ref
        .read(mathEngineProvider)
        .generate(
          topic,
          level: model.pickLevel(mastery, profile, random),
          choiceCount: profile.choiceCount,
        );
  }

  /// Reveals the hint for the current question.
  void showHint() {
    if (!state.answered) state = state.copyWith(hintShown: true);
  }

  /// Answers the current question with option [index]. Ignored once the
  /// question has been answered.
  Future<void> answer(int index) async {
    if (state.answered || state.finished) return;
    final question = state.question;
    final learning = ref.read(learningControllerProvider.notifier);
    final reaction = ref
        .read(clockProvider)()
        .difference(state.questionShownAt);
    final correct = question.isCorrect(index);
    final streak = correct ? state.streak + 1 : 0;
    state = state.copyWith(
      selected: index,
      streak: streak,
      bestStreak: math.max(state.bestStreak, streak),
      startLevels: state.startLevels.containsKey(question.topic)
          ? state.startLevels
          : {
              ...state.startLevels,
              question.topic: learning.masteryOf(question.topic).level,
            },
      answers: [
        ...state.answers,
        PracticeAnswer(
          question: question,
          selectedIndex: index,
          reactionTime: reaction,
          usedHint: state.hintShown,
        ),
      ],
    );
    await learning.recordAnswer(
      question.topic,
      AnswerOutcome(
        correct: correct,
        level: question.level,
        reactionTime: reaction,
        usedHint: state.hintShown,
      ),
    );
  }

  /// Moves on to the next question, or finishes after the last one.
  Future<void> next() async {
    if (!state.answered || state.finished) return;
    final now = ref.read(clockProvider)();
    if (state.number >= state.total) {
      state = state.copyWith(finished: true);
      await ref
          .read(statisticsControllerProvider.notifier)
          .recordSession(
            GameSessionSummary(
              endedAt: now,
              duration: now.difference(state.startedAt),
              questionsAnswered: state.answers.length,
              correctAnswers: state.correctCount,
              totalReactionTime: state.answers.fold(
                Duration.zero,
                (sum, a) => sum + a.reactionTime,
              ),
              bestStreak: state.bestStreak,
            ),
          );
      return;
    }
    state = state.copyWith(
      question: _nextQuestion(state.focus, previous: state.question.topic),
      number: state.number + 1,
      selected: null,
      hintShown: false,
      questionShownAt: now,
    );
  }
}

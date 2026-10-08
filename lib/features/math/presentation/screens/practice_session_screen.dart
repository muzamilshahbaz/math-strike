import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/responsive/responsive_grid.dart';
import '../../domain/entities/math_topic.dart';
import '../controllers/practice_session_controller.dart';
import '../widgets/answer_button.dart';
import '../widgets/math_text_view.dart';
import '../widgets/practice_summary.dart';
import '../widgets/topic_badge.dart';

/// A 10-question practice session on [topic], or a recommended mix when
/// [topic] is `null`.
///
/// Keyboard: `1`–`4` choose an answer, `H` shows the hint, `Enter` moves
/// on.
class PracticeSessionScreen extends ConsumerWidget {
  /// Creates the screen.
  const PracticeSessionScreen({this.topic, super.key});

  /// The topic, or `null` for a recommended mix.
  final MathTopic? topic;

  static const List<LogicalKeyboardKey> _digitKeys = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit4,
  ];

  static const List<LogicalKeyboardKey> _numpadKeys = [
    LogicalKeyboardKey.numpad1,
    LogicalKeyboardKey.numpad2,
    LogicalKeyboardKey.numpad3,
    LogicalKeyboardKey.numpad4,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = practiceSessionControllerProvider(topic);
    final session = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final title = topic?.label ?? 'Recommended mix';

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: Text(title),
        actions: [
          if (!session.finished) _StreakCounter(streak: session.streak),
          const SizedBox(width: AppSpacing.md),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(
              end:
                  (session.number - (session.answered ? 0 : 1)) / session.total,
            ),
            duration: context.motion(AppDurations.medium),
            builder: (context, value, _) => LinearProgressIndicator(
              value: session.finished ? 1 : value,
              semanticsLabel:
                  'Practice progress, question ${session.number} of '
                  '${session.total}',
            ),
          ),
        ),
      ),
      body: session.finished
          ? PracticeSummary(
              session: session,
              onAgain: () => ref.invalidate(provider),
            )
          : CallbackShortcuts(
              bindings: {
                for (var i = 0; i < session.question.choices.length; i++) ...{
                  SingleActivator(_digitKeys[i]): () => controller.answer(i),
                  SingleActivator(_numpadKeys[i]): () => controller.answer(i),
                },
                const SingleActivator(LogicalKeyboardKey.keyH):
                    controller.showHint,
                const SingleActivator(LogicalKeyboardKey.enter):
                    controller.next,
              },
              child: Focus(
                autofocus: true,
                child: _QuestionView(
                  session: session,
                  onAnswer: controller.answer,
                  onHint: controller.showHint,
                  onNext: controller.next,
                ),
              ),
            ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    required this.session,
    required this.onAnswer,
    required this.onHint,
    required this.onNext,
  });

  final PracticeSession session;
  final ValueChanged<int> onAnswer;
  final VoidCallback onHint;
  final VoidCallback onNext;

  AnswerState _stateOf(int index) {
    if (!session.answered) return AnswerState.idle;
    if (session.question.isCorrect(index)) return AnswerState.correct;
    if (index == session.selected) return AnswerState.wrong;
    return AnswerState.dimmed;
  }

  @override
  Widget build(BuildContext context) {
    final question = session.question;
    final isLast = session.number >= session.total;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  TopicBadge(topic: question.topic, size: 32),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      '${question.topic.label} · Level ${question.level}',
                      style: context.textStyles.labelLarge,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      'Question ${session.number} of ${session.total}',
                      textAlign: TextAlign.end,
                      style: context.textStyles.labelLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AnimatedSwitcher(
                duration: context.motion(AppDurations.medium),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween(
                      begin: const Offset(0.08, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: Card(
                  key: ValueKey(session.number),
                  // Full width: AnimatedSwitcher would otherwise shrink the
                  // card to its text.
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.xl,
                      ),
                      child: Semantics(
                        liveRegion: true,
                        child: MathTextView(
                          question.prompt,
                          textAlign: TextAlign.center,
                          style: context.textStyles.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ResponsiveGrid(
                minTileWidth: 150,
                balanced: true,
                children: [
                  for (final (i, choice) in question.choices.indexed)
                    AnswerButton(
                      key: ValueKey('choice-$i'),
                      label: choice,
                      shortcut: i + 1,
                      state: _stateOf(i),
                      onPressed: () => onAnswer(i),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (session.answered)
                _Feedback(
                  correct: session.lastCorrect,
                  answer: question.answer,
                  explanation: question.explanation,
                  isLast: isLast,
                  onNext: onNext,
                )
              else if (session.hintShown)
                _HintCard(hint: question.hint)
              else
                Center(
                  child: TextButton.icon(
                    onPressed: onHint,
                    icon: const Icon(Icons.lightbulb_outline_rounded),
                    label: const Text('Show a hint'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HintCard extends StatelessWidget {
  const _HintCard({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.gamePalette.coin.withValues(alpha: 0.14),
        borderRadius: AppRadii.mdAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_rounded, color: context.gamePalette.coin),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: MathTextView(hint, style: context.textStyles.bodyLarge),
          ),
        ],
      ),
    ),
  );
}

class _Feedback extends StatelessWidget {
  const _Feedback({
    required this.correct,
    required this.answer,
    required this.explanation,
    required this.isLast,
    required this.onNext,
  });

  final bool correct;
  final String answer;
  final String explanation;
  final bool isLast;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final palette = context.gamePalette;
    final color = correct ? palette.correct : palette.wrong;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          liveRegion: true,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: AppRadii.mdAll,
              border: Border.all(color: color.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      correct ? Icons.check_circle_rounded : Icons.info_rounded,
                      color: color,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: MathTextView(
                        correct
                            ? 'Correct!'
                            : 'Not quite — the answer is $answer',
                        style: context.textStyles.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                MathTextView(explanation, style: context.textStyles.bodyLarge),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: FilledButton.icon(
            autofocus: true,
            onPressed: onNext,
            icon: Icon(
              isLast ? Icons.flag_rounded : Icons.arrow_forward_rounded,
            ),
            label: Text(isLast ? 'See results' : 'Next question'),
            style: FilledButton.styleFrom(minimumSize: const Size(200, 52)),
          ),
        ),
      ],
    );
  }
}

class _StreakCounter extends StatelessWidget {
  const _StreakCounter({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$streak in a row',
    excludeSemantics: true,
    child: AnimatedOpacity(
      opacity: streak >= 2 ? 1 : 0.35,
      duration: context.motion(AppDurations.short),
      child: Row(
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            color: context.gamePalette.combo,
          ),
          const SizedBox(width: 2),
          Text(
            '$streak',
            style: context.textStyles.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    ),
  );
}

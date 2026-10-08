import 'package:flutter/material.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../domain/engine/math_text.dart';
import 'math_text_view.dart';

/// How an answer option looks after the question is answered.
enum AnswerState {
  /// Not answered yet: tappable.
  idle,

  /// The correct option.
  correct,

  /// The option the player chose, which was wrong.
  wrong,

  /// Any other option once answered.
  dimmed,
}

/// One answer option, with its keyboard shortcut number.
///
/// Correctness is shown with an icon as well as colour, so it does not
/// rely on colour vision.
class AnswerButton extends StatelessWidget {
  /// Creates the button.
  const AnswerButton({
    required this.label,
    required this.shortcut,
    required this.state,
    required this.onPressed,
    super.key,
  });

  /// The option text.
  final String label;

  /// Keyboard number (1-based) that selects this option.
  final int shortcut;

  /// Visual state.
  final AnswerState state;

  /// Called when chosen; ignored unless [state] is [AnswerState.idle].
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final palette = context.gamePalette;
    final (background, foreground, border) = switch (state) {
      AnswerState.idle => (
        colors.surfaceContainerHigh,
        colors.onSurface,
        colors.outlineVariant,
      ),
      AnswerState.correct => (
        palette.correct,
        palette.onCorrect,
        palette.correct,
      ),
      AnswerState.wrong => (palette.wrong, palette.onWrong, palette.wrong),
      AnswerState.dimmed => (
        colors.surfaceContainerLow,
        colors.onSurface.withValues(alpha: 0.45),
        colors.outlineVariant.withValues(alpha: 0.5),
      ),
    };
    final stateLabel = switch (state) {
      AnswerState.correct => ', correct answer',
      AnswerState.wrong => ', your answer, wrong',
      _ => '',
    };

    return Semantics(
      button: state == AnswerState.idle,
      label: '${MathText.spoken(label)}$stateLabel',
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: context.motion(AppDurations.medium),
        constraints: const BoxConstraints(minHeight: 64),
        decoration: BoxDecoration(
          color: background,
          borderRadius: AppRadii.mdAll,
          border: Border.all(color: border, width: 2),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: AppRadii.mdAll,
            onTap: state == AnswerState.idle ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.smd,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  _ShortcutBadge(number: shortcut, color: foreground),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: MathTextView(
                      label,
                      textAlign: TextAlign.center,
                      style: context.textStyles.titleLarge?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                    child: switch (state) {
                      AnswerState.correct => Icon(
                        Icons.check_circle_rounded,
                        color: foreground,
                      ),
                      AnswerState.wrong => Icon(
                        Icons.cancel_rounded,
                        color: foreground,
                      ),
                      _ => null,
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShortcutBadge extends StatelessWidget {
  const _ShortcutBadge({required this.number, required this.color});

  final int number;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 24,
    height: 24,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: const BorderRadius.all(AppRadii.sm),
    ),
    child: Text(
      '$number',
      textScaler: TextScaler.noScaling,
      style: context.textStyles.labelMedium?.copyWith(color: color),
    ),
  );
}

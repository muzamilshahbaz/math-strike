import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/effects/confetti_burst.dart';
import '../../../../core/widgets/responsive/responsive_grid.dart';
import '../../../statistics/presentation/widgets/stat_tile.dart';
import '../controllers/learning_controller.dart';
import '../controllers/practice_session_controller.dart';
import 'math_text_view.dart';
import 'topic_badge.dart';

/// Results of a finished practice session: score, speed, level changes and
/// a review of every mistake with its explanation.
class PracticeSummary extends ConsumerWidget {
  /// Creates the summary.
  const PracticeSummary({
    required this.session,
    required this.onAgain,
    super.key,
  });

  /// The finished session.
  final PracticeSession session;

  /// Starts another session.
  final VoidCallback onAgain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learning = ref.read(learningControllerProvider.notifier);
    ref.watch(learningControllerProvider);
    final answered = session.answers.length;
    final accuracy = answered == 0 ? 0.0 : session.correctCount / answered;
    final averageMs = answered == 0
        ? 0
        : session.answers.fold(
                0,
                (sum, a) => sum + a.reactionTime.inMilliseconds,
              ) ~/
              answered;
    final palette = context.gamePalette;
    final great = accuracy >= 0.8;

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Icon(
                      great
                          ? Icons.emoji_events_rounded
                          : Icons.trending_up_rounded,
                      size: 64,
                      color: great ? palette.coin : context.colors.primary,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Semantics(
                      header: true,
                      child: Text(
                        great ? 'Brilliant work!' : 'Practice makes progress!',
                        textAlign: TextAlign.center,
                        style: context.textStyles.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ResponsiveGrid(
                      minTileWidth: 150,
                      children: [
                        StatTile(
                          icon: Icons.check_circle_rounded,
                          label: 'Score',
                          value: '${session.correctCount} / $answered',
                          color: palette.correct,
                        ),
                        StatTile(
                          icon: Icons.track_changes_rounded,
                          label: 'Accuracy',
                          value: formatPercent(accuracy),
                          color: palette.correct,
                        ),
                        StatTile(
                          icon: Icons.timer_rounded,
                          label: 'Average time',
                          value: formatReaction(
                            Duration(milliseconds: averageMs),
                          ),
                          color: palette.diamond,
                        ),
                        StatTile(
                          icon: Icons.local_fire_department_rounded,
                          label: 'Best streak',
                          value: '${session.bestStreak}',
                          color: palette.combo,
                        ),
                      ],
                    ),
                    const _Header('Your levels'),
                    Card(
                      child: Column(
                        children: [
                          for (final MapEntry(key: topic, value: before)
                              in session.startLevels.entries)
                            _LevelChange(
                              badge: TopicBadge(topic: topic, size: 36),
                              name: topic.label,
                              before: before,
                              after: learning.masteryOf(topic).level,
                            ),
                        ],
                      ),
                    ),
                    if (session.mistakes.isNotEmpty) ...[
                      const _Header('Review your mistakes'),
                      for (final mistake in session.mistakes)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _MistakeCard(answer: mistake),
                        ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.sm,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          child: const Text('Done'),
                        ),
                        FilledButton.icon(
                          autofocus: true,
                          onPressed: onAgain,
                          icon: const Icon(Icons.replay_rounded),
                          label: const Text('Practice again'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (great) const Positioned.fill(child: ConfettiBurst()),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.sm,
      AppSpacing.lg,
      AppSpacing.sm,
      AppSpacing.sm,
    ),
    child: Semantics(
      header: true,
      child: Text(
        title,
        style: context.textStyles.titleSmall?.copyWith(
          color: context.colors.primary,
        ),
      ),
    ),
  );
}

class _LevelChange extends StatelessWidget {
  const _LevelChange({
    required this.badge,
    required this.name,
    required this.before,
    required this.after,
  });

  final Widget badge;
  final String name;
  final int before;
  final int after;

  @override
  Widget build(BuildContext context) {
    final palette = context.gamePalette;
    final (icon, color, text) = after > before
        ? (Icons.arrow_upward_rounded, palette.correct, 'Level up!')
        : after < before
        ? (Icons.arrow_downward_rounded, palette.wrong, 'Easier for now')
        : (Icons.remove_rounded, context.colors.outline, 'Steady');
    return ListTile(
      leading: badge,
      title: Text(name),
      subtitle: Text(text),
      trailing: Semantics(
        label: before == after
            ? 'Level $after'
            : 'Level $before to level $after',
        excludeSemantics: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              before == after ? 'Level $after' : 'Level $before',
              style: context.textStyles.labelLarge,
            ),
            if (before != after) ...[
              const Icon(Icons.arrow_forward_rounded, size: 16),
              Text('$after', style: context.textStyles.labelLarge),
            ],
            const SizedBox(width: AppSpacing.xs),
            Icon(icon, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}

class _MistakeCard extends StatelessWidget {
  const _MistakeCard({required this.answer});

  final PracticeAnswer answer;

  @override
  Widget build(BuildContext context) {
    final question = answer.question;
    final palette = context.gamePalette;
    final muted = context.textStyles.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MathTextView(
              question.prompt,
              style: context.textStyles.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(Icons.cancel_rounded, size: 18, color: palette.wrong),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: MathTextView(
                    'You said ${question.choices[answer.selectedIndex]}',
                    style: muted,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: palette.correct,
                ),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: MathTextView(
                    'Answer: ${question.answer}',
                    style: muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            MathTextView(
              question.explanation,
              style: context.textStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

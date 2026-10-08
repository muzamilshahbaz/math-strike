import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/theme_context.dart';
import '../../../features/math/domain/entities/topic_mastery.dart';
import '../../../features/math/presentation/controllers/learning_controller.dart';
import '../../../features/math/presentation/practice_navigation.dart';
import '../../../features/math/presentation/widgets/topic_badge.dart';
import '../../../routing/app_routes.dart';

/// Dashboard entry to practice mode, suggesting the weakest topic.
class PracticeCard extends ConsumerWidget {
  /// Creates the card.
  const PracticeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicSummariesProvider);
    final weakest =
        [
          for (final t in topics)
            if (t.strength == TopicStrength.weak) t,
        ]..sort(
          (a, b) =>
              a.mastery.recentAccuracy!.compareTo(b.mastery.recentAccuracy!),
        );
    final suggestion = weakest.isEmpty ? null : weakest.first;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school_rounded, color: context.colors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Practice',
                    style: context.textStyles.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              suggestion == null
                  ? 'Sharpen your skills in ${topics.length} topics, at your '
                        'own pace.'
                  : '${suggestion.topic.label} needs some practice. A few '
                        'questions will help!',
              style: context.textStyles.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.smd),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                if (suggestion != null)
                  FilledButton.icon(
                    onPressed: () => context.startPractice(suggestion.topic),
                    icon: TopicBadge(topic: suggestion.topic, size: 22),
                    label: Text('Practise ${suggestion.topic.label}'),
                  ),
                if (suggestion == null)
                  FilledButton.tonalIcon(
                    onPressed: () => context.push(AppRoutes.practice),
                    icon: const Icon(Icons.grid_view_rounded),
                    label: const Text('Choose a topic'),
                  )
                else
                  TextButton(
                    onPressed: () => context.push(AppRoutes.practice),
                    child: const Text('All topics'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

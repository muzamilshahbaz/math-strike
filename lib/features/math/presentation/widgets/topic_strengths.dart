import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../routing/app_routes.dart';
import '../../domain/entities/topic_mastery.dart';
import '../controllers/learning_controller.dart';
import '../practice_navigation.dart';
import 'topic_badge.dart';

/// Strong topics and topics that need practice, each a shortcut into a
/// practice session.
class TopicStrengths extends ConsumerWidget {
  /// Creates the section.
  const TopicStrengths({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicSummariesProvider);
    List<TopicSummary> withStrength(TopicStrength strength) => [
      for (final t in topics)
        if (t.strength == strength) t,
    ];
    final strong = withStrength(TopicStrength.strong);
    final weak = withStrength(TopicStrength.weak);
    final practised = topics.where((t) => t.mastery.attempts > 0).length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: practised == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Practise a few topics to discover your strengths.',
                    style: context.textStyles.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.smd),
                  FilledButton.tonalIcon(
                    onPressed: () => context.push(AppRoutes.practice),
                    icon: const Icon(Icons.school_rounded),
                    label: const Text('Go to practice'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$practised of ${topics.length} topics practised',
                    style: context.textStyles.titleSmall,
                  ),
                  _Group(
                    title: 'Needs practice',
                    empty: 'Nothing weak right now. Keep it up!',
                    topics: weak,
                  ),
                  _Group(
                    title: 'Strong',
                    empty: 'Keep practising to make a topic strong.',
                    topics: strong,
                  ),
                ],
              ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    required this.title,
    required this.empty,
    required this.topics,
  });

  final String title;
  final String empty;
  final List<TopicSummary> topics;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyles.labelLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (topics.isEmpty)
          Text(empty, style: context.textStyles.bodySmall)
        else
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              for (final t in topics)
                ActionChip(
                  avatar: TopicBadge(topic: t.topic, size: 22),
                  label: Text('${t.topic.label} · L${t.level}'),
                  tooltip: 'Practise ${t.topic.label}',
                  onPressed: () => context.startPractice(t.topic),
                ),
            ],
          ),
      ],
    ),
  );
}

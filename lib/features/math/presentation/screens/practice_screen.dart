import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/responsive/responsive_grid.dart';
import '../../domain/entities/topic_mastery.dart';
import '../controllers/learning_controller.dart';
import '../practice_navigation.dart';
import '../widgets/topic_badge.dart';
import '../widgets/topic_card.dart';

/// Practice hub: a recommended mix that targets weak topics, plus every
/// topic available for the player's age group with its level.
class PracticeScreen extends ConsumerWidget {
  /// Creates the screen.
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(topicSummariesProvider);
    final weak = [
      for (final t in topics)
        if (t.strength == TopicStrength.weak) t,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Practice')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              _RecommendedCard(weak: weak),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.sm,
                ),
                child: Semantics(
                  header: true,
                  child: Text(
                    'Topics',
                    style: context.textStyles.titleSmall?.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ),
              ResponsiveGrid(
                minTileWidth: 200,
                children: [
                  for (final summary in topics)
                    TopicCard(
                      summary: summary,
                      onTap: () => context.startPractice(summary.topic),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({required this.weak});

  final List<TopicSummary> weak;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colors.secondaryContainer, colors.primaryContainer],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome_rounded, color: colors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Recommended mix',
                    style: context.textStyles.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              weak.isEmpty
                  ? '10 questions from all your topics, matched to your level.'
                  : '10 questions from all your topics, with extra practice '
                        'where you need it most:',
              style: context.textStyles.bodyMedium,
            ),
            if (weak.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final t in weak.take(4))
                    Chip(
                      avatar: TopicBadge(topic: t.topic, size: 22),
                      label: Text(t.topic.label),
                    ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: () => context.startPractice(),
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start mix'),
            ),
          ],
        ),
      ),
    );
  }
}

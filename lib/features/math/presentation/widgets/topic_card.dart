import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/learning_controller.dart';
import 'topic_badge.dart';

/// A tappable card for one topic: symbol, name, level, progress towards the
/// next level and how it is going.
class TopicCard extends StatelessWidget {
  /// Creates the card.
  const TopicCard({required this.summary, required this.onTap, super.key});

  /// The topic's standing.
  final TopicSummary summary;

  /// Called when the card is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mastery = summary.mastery;
    final color = topicColor(context, summary.topic);
    final progress = mastery.rating - mastery.rating.floor();
    final accuracy = mastery.accuracy;
    return Semantics(
      button: true,
      label:
          '${summary.topic.label}, level ${summary.level}, '
          '${summary.strength.label}'
          '${accuracy == null ? '' : ', ${formatPercent(accuracy)} correct'}',
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.smd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    TopicBadge(topic: summary.topic, size: 40),
                    const SizedBox(width: AppSpacing.smd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            summary.topic.label,
                            style: context.textStyles.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Level ${summary.level}',
                            style: context.textStyles.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.smd),
                ClipRRect(
                  borderRadius: const BorderRadius.all(AppRadii.pill),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    color: color,
                    backgroundColor: color.withValues(alpha: 0.15),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: StrengthChip(strength: summary.strength),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

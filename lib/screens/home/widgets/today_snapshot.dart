import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/theme_context.dart';
import '../../../core/widgets/responsive/responsive_grid.dart';
import '../../../features/statistics/domain/entities/player_statistics.dart';
import '../../../features/statistics/presentation/controllers/statistics_controller.dart';
import '../../../features/statistics/presentation/widgets/activity_chart.dart';
import '../../../features/statistics/presentation/widgets/stat_tiles.dart';
import '../../../routing/app_routes.dart';

/// Today's key statistics and the last week's activity, linking to the
/// full Progress tab.
class TodaySnapshot extends ConsumerWidget {
  /// Creates the snapshot.
  const TodaySnapshot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(periodTotalsProvider(StatisticsPeriod.today));
    final history = ref.watch(activityHistoryProvider(7));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wraps the link below the title at large text sizes.
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    "Today's stats",
                    style: context.textStyles.titleMedium,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(AppRoutes.progress),
                  child: const Text('See progress'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ResponsiveGrid(
              minTileWidth: 150,
              children: [
                questionsTile(today),
                accuracyTile(context, today),
                timePlayedTile(context, today),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'This week',
              style: context.textStyles.labelLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ActivityChart(history: history, height: 80),
          ],
        ),
      ),
    );
  }
}

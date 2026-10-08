import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/responsive/responsive_grid.dart';
import '../../../../routing/app_routes.dart';
import '../../../math/presentation/widgets/topic_strengths.dart';
import '../../domain/entities/player_statistics.dart';
import '../controllers/statistics_controller.dart';
import '../widgets/activity_chart.dart';
import '../widgets/stat_tile.dart';
import '../widgets/stat_tiles.dart';

/// The Progress tab: the player's statistics for a chosen period, all-time
/// highlights and recent activity.
///
/// Phase 14 adds learning graphs and detailed reports.
class StatisticsScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  StatisticsPeriod _period = StatisticsPeriod.week;

  @override
  Widget build(BuildContext context) {
    final statistics = ref.watch(statisticsControllerProvider);
    final totals = ref.watch(periodTotalsProvider(_period));
    final chartDays = _period == StatisticsPeriod.month ? 30 : 7;
    final history = ref.watch(activityHistoryProvider(chartDays));

    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (!statistics.hasPlayed) ...[
                const _NoGamesYet(),
                const SizedBox(height: AppSpacing.md),
              ],
              // Chips wrap onto a second line on narrow screens and at
              // large text sizes, so every period stays reachable.
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final period in StatisticsPeriod.values)
                    ChoiceChip(
                      label: Text(period.label),
                      selected: period == _period,
                      onSelected: (_) => setState(() => _period = period),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ResponsiveGrid(children: periodTiles(context, totals)),
              const _SectionHeader('Activity'),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Questions per day · last $chartDays days',
                        style: context.textStyles.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ActivityChart(history: history, height: 140),
                    ],
                  ),
                ),
              ),
              const _SectionHeader('Topics'),
              const TopicStrengths(),
              const _SectionHeader('All-time bests'),
              ResponsiveGrid(
                children: [
                  StatTile(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Best answer streak',
                    value: formatCount(statistics.bestStreak),
                    color: context.gamePalette.combo,
                  ),
                  StatTile(
                    icon: Icons.auto_awesome_rounded,
                    label: 'Highest combo',
                    value: statistics.highestCombo == 0
                        ? noValue
                        : '×${statistics.highestCombo}',
                    color: context.gamePalette.combo,
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

class _NoGamesYet extends StatelessWidget {
  const _NoGamesYet();

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Icon(Icons.insights_rounded, size: 48, color: context.colors.primary),
          const SizedBox(height: AppSpacing.smd),
          Text(
            'No games yet',
            style: context.textStyles.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Play a game and your accuracy, speed and streaks will show '
            'up here.',
            style: context.textStyles.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: () => context.push(AppRoutes.game),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Play now'),
          ),
        ],
      ),
    ),
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

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

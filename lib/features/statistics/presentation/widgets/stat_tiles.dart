import 'package:flutter/material.dart';

import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/player_statistics.dart';
import 'stat_tile.dart';

/// Placeholder value for a metric without data yet.
const String noValue = '—';

/// Accuracy tile for [totals].
StatTile accuracyTile(BuildContext context, StatTotals totals) => StatTile(
  icon: Icons.track_changes_rounded,
  label: 'Accuracy',
  value: totals.accuracy == null ? noValue : formatPercent(totals.accuracy!),
  color: context.gamePalette.correct,
);

/// Questions-answered tile for [totals].
StatTile questionsTile(StatTotals totals) => StatTile(
  icon: Icons.quiz_rounded,
  label: 'Questions answered',
  value: formatCount(totals.questionsAnswered),
);

/// Time-played tile for [totals].
StatTile timePlayedTile(BuildContext context, StatTotals totals) => StatTile(
  icon: Icons.schedule_rounded,
  label: 'Time played',
  value: formatPlayTime(totals.timePlayed),
  color: context.colors.tertiary,
);

/// Every per-period tile for [totals], in display order.
List<StatTile> periodTiles(BuildContext context, StatTotals totals) {
  final palette = context.gamePalette;
  return [
    accuracyTile(context, totals),
    questionsTile(totals),
    StatTile(
      icon: Icons.check_circle_rounded,
      label: 'Correct answers',
      value: formatCount(totals.correctAnswers),
      color: palette.correct,
    ),
    StatTile(
      icon: Icons.cancel_rounded,
      label: 'Mistakes',
      value: formatCount(totals.mistakes),
      color: palette.wrong,
    ),
    StatTile(
      icon: Icons.timer_rounded,
      label: 'Average reaction',
      value: totals.averageReaction == null
          ? noValue
          : formatReaction(totals.averageReaction!),
      color: palette.diamond,
    ),
    timePlayedTile(context, totals),
    StatTile(
      icon: Icons.sports_esports_rounded,
      label: 'Games played',
      value: formatCount(totals.gamesPlayed),
      color: context.colors.secondary,
    ),
    StatTile(
      icon: Icons.flag_rounded,
      label: 'Levels completed',
      value: formatCount(totals.levelsCompleted),
      color: palette.xp,
    ),
  ];
}

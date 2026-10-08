import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/calendar_day.dart';
import '../../domain/entities/player_statistics.dart';

const List<String> _weekdayLabels = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

/// Bar chart of questions answered per day, oldest on the left and today
/// highlighted on the right.
///
/// Bars grow in when shown. Screen readers get the whole series as one
/// description instead of individual bars.
class ActivityChart extends StatelessWidget {
  /// Creates the chart from per-day [history] (oldest first; the last
  /// entry is today).
  const ActivityChart({required this.history, this.height = 120, super.key});

  /// Per-day totals, oldest first.
  final List<(CalendarDay, StatTotals)> history;

  /// Height of the bar area.
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final peak = history.fold(
      0,
      (peak, entry) => math.max(peak, entry.$2.questionsAnswered),
    );
    // Day labels fit for a week or two; longer ranges label every 5th day.
    final labelEvery = history.length <= 14 ? 1 : 5;

    return Semantics(
      label: _describe(),
      excludeSemantics: true,
      child: SizedBox(
        height: height + 24,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final (i, (day, totals)) in history.indexed)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: history.length <= 14 ? 4 : 1.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(
                          begin: 0,
                          end: peak == 0 ? 0 : totals.questionsAnswered / peak,
                        ),
                        duration: context.motion(AppDurations.long),
                        curve: Curves.easeOutCubic,
                        builder: (context, fraction, _) => Container(
                          // A sliver of bar on empty days keeps the axis
                          // readable.
                          height: math.max(3, fraction * height),
                          decoration: BoxDecoration(
                            color: i == history.length - 1
                                ? colors.primary
                                : totals.isEmpty
                                ? colors.outlineVariant
                                : colors.primary.withValues(alpha: 0.45),
                            borderRadius: const BorderRadius.vertical(
                              top: AppRadii.sm,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                        child: (history.length - 1 - i) % labelEvery == 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    labelEvery == 1
                                        ? _weekdayLabels[day.weekday - 1]
                                        : '${day.day}',
                                    style: context.textStyles.labelSmall
                                        ?.copyWith(
                                          color: colors.onSurfaceVariant,
                                        ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _describe() {
    final total = history.fold(
      0,
      (sum, entry) => sum + entry.$2.questionsAnswered,
    );
    final active = history.where((entry) => !entry.$2.isEmpty).length;
    return 'Activity chart: $total questions answered over the last '
        '${history.length} days, played on $active of them. Today: '
        '${history.last.$2.questionsAnswered} questions.';
  }
}

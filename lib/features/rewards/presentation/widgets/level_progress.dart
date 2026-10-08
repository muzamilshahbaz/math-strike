import 'package:flutter/material.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/player_level.dart';

/// Level, rank and an animated experience bar towards the next level.
class LevelProgress extends StatelessWidget {
  /// Creates the indicator.
  const LevelProgress({required this.level, this.foreground, super.key});

  /// The level to show.
  final PlayerLevel level;

  /// Text colour; defaults to the surface foreground.
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final xpColor = context.gamePalette.xp;
    final textColor = foreground ?? context.colors.onSurface;
    final xpText = level.isMax
        ? 'Max level'
        : '${formatCount(level.xpIntoLevel)} / '
              '${formatCount(level.xpForNextLevel)} XP';
    return Semantics(
      label:
          'Level ${level.level}, ${level.rank.label}. '
          '${level.isMax ? 'Max level' : '$xpText to level ${level.level + 1}'}',
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _LevelBadge(level: level.level),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  level.rank.label,
                  style: context.textStyles.titleMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TweenAnimationBuilder<double>(
            tween: Tween(end: level.progress),
            duration: context.motion(AppDurations.extraLong),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => ClipRRect(
              borderRadius: const BorderRadius.all(AppRadii.pill),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 10,
                color: xpColor,
                backgroundColor: xpColor.withValues(alpha: 0.18),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            xpText,
            textAlign: TextAlign.end,
            style: context.textStyles.labelMedium?.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final color = context.gamePalette.xp;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(AppRadii.sm),
      ),
      child: Text(
        'LV $level',
        style: context.textStyles.labelLarge?.copyWith(
          color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

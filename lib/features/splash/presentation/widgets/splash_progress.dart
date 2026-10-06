import 'package:flutter/material.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/brand_colors.dart';
import '../../../../core/theme/theme_context.dart';

/// Gradient progress bar with the current task label underneath.
class SplashProgress extends StatelessWidget {
  /// Creates the indicator.
  const SplashProgress({required this.progress, this.label, super.key});

  /// Completion, 0.0–1.0.
  final double progress;

  /// Current task description.
  final String? label;

  static const double _width = 260;
  static const double _height = 8;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: 'Loading',
          value: '$percent%',
          child: ClipRRect(
            borderRadius: const BorderRadius.all(AppRadii.pill),
            child: SizedBox(
              width: _width,
              height: _height,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColoredBox(
                      color: BrandColors.star.withValues(alpha: 0.12),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(end: progress.clamp(0, 1)),
                    duration: context.motion(AppDurations.medium),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => FractionallySizedBox(
                      widthFactor: value,
                      heightFactor: 1,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [BrandColors.cyan, BrandColors.magenta],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.smd),
        SizedBox(
          height: 20,
          child: AnimatedSwitcher(
            duration: context.motion(AppDurations.short),
            child: Semantics(
              key: ValueKey(label),
              liveRegion: true,
              child: Text(
                label == null ? '' : '$label…',
                style: TextStyle(
                  color: BrandColors.star.withValues(alpha: 0.75),
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

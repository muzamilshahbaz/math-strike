import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';

/// One headline number with an icon and a label, e.g. "86% Accuracy".
class StatTile extends StatelessWidget {
  /// Creates the tile.
  const StatTile({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
    super.key,
  });

  /// Illustrative icon.
  final IconData icon;

  /// What the number means.
  final String label;

  /// The formatted value ("—" when there is no data yet).
  final String value;

  /// Accent colour; defaults to the primary colour.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? context.colors.primary;
    return Semantics(
      container: true,
      label: '$label: $value',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.smd),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerHigh,
          borderRadius: AppRadii.mdAll,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent, size: 20),
            ),
            const SizedBox(width: AppSpacing.smd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: context.textStyles.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    label,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lays [children] out in equal-width columns, as many as fit at
/// [minTileWidth] (at least [minColumns]).
class StatGrid extends StatelessWidget {
  /// Creates the grid.
  const StatGrid({
    required this.children,
    this.minTileWidth = 170,
    this.minColumns = 2,
    super.key,
  });

  /// The tiles.
  final List<Widget> children;

  /// Narrowest a tile may become before wrapping to fewer columns.
  final double minTileWidth;

  /// Fewest columns, even on narrow screens.
  final int minColumns;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      const gap = AppSpacing.sm;
      final fitting = ((constraints.maxWidth + gap) / (minTileWidth + gap))
          .floor();
      final columns = math.max(
        1,
        math.min(math.max(fitting, minColumns), children.length),
      );
      final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [
          for (final child in children) SizedBox(width: width, child: child),
        ],
      );
    },
  );
}

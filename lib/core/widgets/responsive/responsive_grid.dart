import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../theme/app_tokens.dart';

/// Lays [children] out in equal-width columns, as many as fit at
/// [minTileWidth] (at least [minColumns]).
class ResponsiveGrid extends StatelessWidget {
  /// Creates the grid.
  const ResponsiveGrid({
    required this.children,
    this.minTileWidth = 170,
    this.minColumns = 2,
    this.balanced = false,
    super.key,
  });

  /// The tiles.
  final List<Widget> children;

  /// Narrowest a tile may become before wrapping to fewer columns.
  final double minTileWidth;

  /// Fewest columns, even on narrow screens.
  final int minColumns;

  /// Whether to use only column counts that divide the number of
  /// children evenly (e.g. 4 answers as 2×2 or 4×1, never 3 + 1).
  final bool balanced;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      const gap = AppSpacing.sm;
      final fitting = ((constraints.maxWidth + gap) / (minTileWidth + gap))
          .floor();
      var columns = math.max(
        1,
        math.min(math.max(fitting, minColumns), children.length),
      );
      while (balanced && columns > 1 && children.length % columns != 0) {
        columns--;
      }
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

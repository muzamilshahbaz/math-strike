import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/theme_context.dart';

/// A one-shot burst of confetti, for celebrations (rewards, level-ups).
///
/// Fills its parent and ignores pointer input, so place it in a [Stack]
/// above the content. Plays once when inserted; renders nothing when the
/// player has reduced motion. Purely decorative, so hidden from screen
/// readers.
class ConfettiBurst extends StatefulWidget {
  /// Creates a burst.
  const ConfettiBurst({
    this.colors,
    this.particleCount = 70,
    this.duration = const Duration(milliseconds: 1800),
    this.origin = const Alignment(0, -0.2),
    this.seed = 7,
    super.key,
  });

  /// Confetti colours; defaults to the theme's accent colours.
  final List<Color>? colors;

  /// Number of pieces.
  final int particleCount;

  /// How long the burst lasts.
  final Duration duration;

  /// Where the pieces are launched from.
  final Alignment origin;

  /// Random seed; fixed by default so the effect is reproducible.
  final int seed;

  @override
  State<ConfettiBurst> createState() => _ConfettiBurstState();
}

class _ConfettiBurstState extends State<ConfettiBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final List<_Piece> _pieces = _generate();

  List<_Piece> _generate() {
    final random = math.Random(widget.seed);
    return [
      for (var i = 0; i < widget.particleCount; i++)
        _Piece(
          // Mostly upwards, fanning out to both sides.
          angle: -math.pi / 2 + (random.nextDouble() - 0.5) * math.pi * 0.9,
          speed: 0.55 + random.nextDouble() * 0.6,
          spin: (random.nextDouble() - 0.5) * 14,
          size: 5 + random.nextDouble() * 6,
          colorIndex: i,
        ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Plays once: only from the very start, and never with reduced motion.
    if (!context.reduceMotion && _controller.isDismissed) {
      _controller.forward().ignore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return const SizedBox.shrink();
    final colors = context.colors;
    final palette =
        widget.colors ??
        [
          colors.primary,
          colors.tertiary,
          colors.secondary,
          context.gamePalette.coin,
          context.gamePalette.diamond,
        ];
    return ExcludeSemantics(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: CustomPaint(
            size: Size.infinite,
            painter: _ConfettiPainter(
              progress: _controller,
              pieces: _pieces,
              colors: palette,
              origin: widget.origin,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _Piece {
  const _Piece({
    required this.angle,
    required this.speed,
    required this.spin,
    required this.size,
    required this.colorIndex,
  });

  final double angle;
  final double speed;
  final double spin;
  final double size;
  final int colorIndex;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({
    required this.progress,
    required this.pieces,
    required this.colors,
    required this.origin,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final List<_Piece> pieces;
  final List<Color> colors;
  final Alignment origin;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress.value;
    if (t == 0 || t == 1) return;
    final start = origin.alongSize(size);
    final reach = size.shortestSide;
    final paint = Paint();
    // Fade out over the last 30%.
    final opacity = t < 0.7 ? 1.0 : (1 - t) / 0.3;
    for (final piece in pieces) {
      final distance = piece.speed * reach * t;
      final gravity = 0.9 * reach * t * t;
      final position =
          start +
          Offset(
            math.cos(piece.angle) * distance,
            math.sin(piece.angle) * distance + gravity,
          );
      paint.color = colors[piece.colorIndex % colors.length].withValues(
        alpha: opacity,
      );
      canvas
        ..save()
        ..translate(position.dx, position.dy)
        ..rotate(piece.spin * t)
        ..drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: piece.size,
            height: piece.size * 0.55,
          ),
          paint,
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      oldDelegate.pieces != pieces || oldDelegate.colors != colors;
}

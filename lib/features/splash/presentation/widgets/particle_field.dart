import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/brand_colors.dart';

/// Animated backdrop of twinkling stars and drifting math symbols.
///
/// Performance notes:
/// * The painter repaints from [animation] directly (no widget rebuilds).
/// * Particles are generated once per size and positions are pure
///   functions of time, so frames allocate nothing.
/// * Glyph text is laid out once and reused.
/// * Integer cycle counts make the loop seamless at `t = 1 → 0`.
///
/// Wrap in a [RepaintBoundary] so the rest of the screen is not repainted.
class ParticleField extends StatefulWidget {
  /// Creates the field. [animation] should loop 0→1; pass a stopped
  /// animation for a static backdrop (reduced motion).
  const ParticleField({required this.animation, this.seed = 7, super.key});

  /// Looping time source, 0.0–1.0.
  final Animation<double> animation;

  /// Seed for the deterministic particle layout.
  final int seed;

  @override
  State<ParticleField> createState() => _ParticleFieldState();
}

class _ParticleFieldState extends State<ParticleField> {
  static const List<String> _glyphs = ['+', '−', '×', '÷', '=', '%', '√', 'π'];
  static const double _glyphBaseSize = 32;

  List<TextPainter> _glyphPainters = const [];
  String? _glyphFontFamily;

  Size? _layoutSize;
  List<_Particle> _particles = const [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TextPainters live outside the widget tree and do not inherit the app
    // font, so pass it explicitly (re-laid out only if the font changes).
    final family = DefaultTextStyle.of(context).style.fontFamily;
    if (_glyphPainters.isEmpty || family != _glyphFontFamily) {
      _glyphFontFamily = family;
      _disposePainters();
      _glyphPainters = [
        for (final glyph in _glyphs)
          TextPainter(
            text: TextSpan(
              text: glyph,
              style: TextStyle(
                fontFamily: family,
                fontSize: _glyphBaseSize,
                fontWeight: FontWeight.w800,
                color: BrandColors.violet.withValues(alpha: 0.30),
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout(),
      ];
    }
  }

  void _disposePainters() {
    for (final painter in _glyphPainters) {
      painter.dispose();
    }
  }

  @override
  void dispose() {
    _disposePainters();
    super.dispose();
  }

  List<_Particle> _generate(Size size) {
    final random = math.Random(widget.seed);
    final area = size.width * size.height;
    final stars = (area / 6000).clamp(40, 160).round();
    final glyphs = (area / 45000).clamp(8, 28).round();
    return [
      for (var i = 0; i < stars; i++)
        _Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 0.6 + random.nextDouble() * 1.8,
          cycles: 1 + random.nextInt(2),
          twinkle: 1 + random.nextInt(4),
          phase: random.nextDouble(),
          spin: 0,
          glyph: null,
        ),
      for (var i = 0; i < glyphs; i++)
        _Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: 14 + random.nextDouble() * 26,
          cycles: 1,
          twinkle: 0,
          phase: random.nextDouble(),
          spin: random.nextBool() ? 1 : -1,
          glyph: random.nextInt(_glyphs.length),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        if (size != _layoutSize) {
          _layoutSize = size;
          _particles = _generate(size);
        }
        return CustomPaint(
          size: size,
          painter: _ParticlePainter(
            animation: widget.animation,
            particles: _particles,
            glyphPainters: _glyphPainters,
            glyphBaseSize: _glyphBaseSize,
          ),
        );
      },
    );
  }
}

/// Immutable per-particle parameters; position is derived from time.
@immutable
class _Particle {
  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.cycles,
    required this.twinkle,
    required this.phase,
    required this.spin,
    required this.glyph,
  });

  /// Normalised start position.
  final double x, y;

  /// Star radius or glyph font size.
  final double size;

  /// Full vertical traversals per animation loop (integer → seamless).
  final int cycles;

  /// Twinkle oscillations per loop (integer → seamless).
  final int twinkle;

  /// Phase offset, 0–1.
  final double phase;

  /// Glyph rotation direction (-1, 0, 1 turns per loop).
  final int spin;

  /// Index into the glyph table, or null for a star.
  final int? glyph;
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.animation,
    required this.particles,
    required this.glyphPainters,
    required this.glyphBaseSize,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final List<_Particle> particles;
  final List<TextPainter> glyphPainters;
  final double glyphBaseSize;

  final Paint _starPaint = Paint();

  static double _frac(double v) => v - v.floorToDouble();

  @override
  void paint(Canvas canvas, Size size) {
    const tau = 2 * math.pi;
    final t = animation.value;

    for (final p in particles) {
      // Drift upward, wrapping around.
      final y = _frac(p.y - t * p.cycles) * (size.height + 40) - 20;
      final sway = math.sin(tau * (t * p.cycles + p.phase)) * 8;
      final x = p.x * size.width + sway;

      final glyph = p.glyph;
      if (glyph == null) {
        final shimmer = 0.5 + 0.5 * math.sin(tau * (t * p.twinkle + p.phase));
        _starPaint.color = BrandColors.star.withValues(
          alpha: 0.25 + 0.75 * shimmer,
        );
        canvas.drawCircle(Offset(x, y), p.size, _starPaint);
      } else {
        final painter = glyphPainters[glyph];
        canvas
          ..save()
          ..translate(x, y)
          ..rotate(tau * (p.phase + t * p.spin))
          ..scale(p.size / glyphBaseSize);
        painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) =>
      old.particles != particles || old.animation != animation;
}

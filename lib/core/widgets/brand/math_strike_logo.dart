import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../theme/brand_colors.dart';

/// The official Math Strike emblem.
///
/// A targeting reticle (*strike*) locked onto a plus sign (*math*), with a
/// projectile streak at the moment of impact, on a lit violet-to-magenta
/// tile. Drawn entirely as vectors: crisp at every size, identical on every
/// platform and needs no assets.
///
/// Animation hooks (all default to the resting pose):
/// * [reticleTurns] – rotation of the reticle, in full turns.
/// * [strike] – projectile progress, 0 (absent) → 1 (impact position).
/// * [flash] – impact flash strength, 0–1.
/// * [glow] – outer glow strength, 0–1.
class MathStrikeLogo extends StatelessWidget {
  /// Creates the emblem.
  const MathStrikeLogo({
    this.size = 44,
    this.reticleTurns = 0,
    this.strike = 1,
    this.flash = 0,
    this.glow = 0,
    super.key,
  });

  /// Edge length of the square tile.
  final double size;

  /// Rotation of the reticle, in full turns.
  final double reticleTurns;

  /// Projectile progress, 0–1.
  final double strike;

  /// Impact flash, 0–1.
  final double flash;

  /// Outer glow, 0–1.
  final double glow;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${AppConstants.appName} logo',
      image: true,
      child: CustomPaint(
        size: Size.square(size),
        painter: MathStrikeEmblemPainter(
          reticleTurns: reticleTurns,
          strike: strike,
          flash: flash,
          glow: glow,
        ),
      ),
    );
  }
}

/// Paints the emblem into a square. Public so other surfaces (e.g. a
/// future icon generator) can render it without a widget.
class MathStrikeEmblemPainter extends CustomPainter {
  /// Creates the painter.
  const MathStrikeEmblemPainter({
    this.reticleTurns = 0,
    this.strike = 1,
    this.flash = 0,
    this.glow = 0,
  });

  /// See [MathStrikeLogo.reticleTurns].
  final double reticleTurns;

  /// See [MathStrikeLogo.strike].
  final double strike;

  /// See [MathStrikeLogo.flash].
  final double flash;

  /// See [MathStrikeLogo.glow].
  final double glow;

  /// Tile gradient: indigo-violet → orchid → magenta.
  static const LinearGradient tileGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5B3DF5), Color(0xFFA43CF0), BrandColors.magenta],
    stops: [0, 0.55, 1],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final rect = Offset.zero & Size.square(s);
    final c = rect.center;
    final tile = RRect.fromRectAndRadius(rect, Radius.circular(s * 0.26));

    _paintGlow(canvas, tile, s);
    _paintTile(canvas, tile, rect, s);

    canvas
      ..save()
      ..clipRRect(tile);
    _paintStreak(canvas, c, s);
    _paintFlash(canvas, c, s);
    canvas.restore();

    _paintReticle(canvas, c, s);
    _paintPlus(canvas, c, s);
    _paintSparkle(canvas, c.translate(s * 0.135, -s * 0.135), s * 0.05);
  }

  void _paintGlow(Canvas canvas, RRect tile, double s) {
    if (glow <= 0) return;
    canvas.drawRRect(
      tile.inflate(s * 0.03),
      Paint()
        ..color = BrandColors.magenta.withValues(alpha: 0.55 * glow)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.16),
    );
  }

  void _paintTile(Canvas canvas, RRect tile, Rect rect, double s) {
    canvas
      ..drawRRect(tile, Paint()..shader = tileGradient.createShader(rect))
      // Key light from the top-left.
      ..drawRRect(
        tile,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-0.65, -0.75),
            radius: 0.95,
            colors: [
              Colors.white.withValues(alpha: 0.30),
              Colors.white.withValues(alpha: 0),
            ],
          ).createShader(rect),
      )
      // Ground shade at the bottom for depth.
      ..drawRRect(
        tile,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0),
              Colors.black.withValues(alpha: 0.20),
            ],
          ).createShader(rect),
      )
      // Fine inner rim.
      ..drawRRect(
        tile.deflate(s * 0.012),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = s * 0.014
          ..color = Colors.white.withValues(alpha: 0.12),
      );
  }

  /// Tapered projectile trail from the lower-left toward the centre.
  void _paintStreak(Canvas canvas, Offset c, double s) {
    if (strike <= 0) return;
    final t = strike.clamp(0.0, 1.0);
    const dir = Offset(0.7071, -0.7071); // towards upper-right
    final start = c.translate(-s * 0.62, s * 0.62);
    final end = c.translate(-s * 0.075, s * 0.075);
    final head = Offset.lerp(start, end, t)!;
    // Trail grows as the projectile travels, capped in length.
    final trail = math.min((head - start).distance, s * 0.5);
    final tail = head - dir * trail;
    final halfWidth = s * 0.06;
    final normal = Offset(-dir.dy, dir.dx) * halfWidth;

    final path = Path()
      ..moveTo(tail.dx, tail.dy)
      ..lineTo(head.dx + normal.dx, head.dy + normal.dy)
      ..arcToPoint(head - normal, radius: Radius.circular(halfWidth))
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          colors: [
            BrandColors.cyan.withValues(alpha: 0),
            BrandColors.cyan,
            Colors.white,
          ],
          stops: const [0, 0.55, 1],
        ).createShader(Rect.fromPoints(tail, head)),
    );
    // Hot white core along the front half of the trail.
    final coreStart = Offset.lerp(tail, head, 0.45)!;
    canvas.drawLine(
      coreStart,
      head,
      Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = halfWidth * 0.7
        ..shader = LinearGradient(
          colors: [Colors.white.withValues(alpha: 0), Colors.white],
        ).createShader(Rect.fromPoints(coreStart, head)),
    );
  }

  void _paintFlash(Canvas canvas, Offset c, double s) {
    if (flash <= 0) return;
    canvas.drawCircle(
      c,
      s * 0.42,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.75 * flash),
            BrandColors.cyan.withValues(alpha: 0.35 * flash),
            BrandColors.cyan.withValues(alpha: 0),
          ],
          stops: const [0, 0.35, 1],
        ).createShader(Rect.fromCircle(center: c, radius: s * 0.42)),
    );
  }

  /// Ring of four arcs with ticks in the gaps, like a targeting scope.
  void _paintReticle(Canvas canvas, Offset c, double s) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = s * 0.05;
    final radius = s * 0.27;
    const gap = 30 * math.pi / 180;
    const quarter = math.pi / 2;
    final rotation = reticleTurns * 2 * math.pi;
    final arcRect = Rect.fromCircle(center: c, radius: radius);

    for (var i = 0; i < 4; i++) {
      final axis = rotation + i * quarter - quarter; // start at 12 o'clock
      canvas.drawArc(arcRect, axis + gap / 2, quarter - gap, false, paint);
      final d = Offset(math.cos(axis), math.sin(axis));
      canvas.drawLine(c + d * (s * 0.325), c + d * (s * 0.405), paint);
    }
  }

  void _paintPlus(Canvas canvas, Offset c, double s) {
    final arm = s * 0.13;
    final path = Path()
      ..moveTo(c.dx - arm, c.dy)
      ..lineTo(c.dx + arm, c.dy)
      ..moveTo(c.dx, c.dy - arm)
      ..lineTo(c.dx, c.dy + arm);
    // Soft cyan halo so the plus reads as "lit" by the impact.
    canvas
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = s * 0.12
          ..color = BrandColors.cyan.withValues(alpha: 0.35 + 0.4 * flash)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.035),
      )
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = s * 0.098
          ..color = Colors.white,
      );
  }

  /// Four-point glint.
  void _paintSparkle(Canvas canvas, Offset p, double r) {
    final w = r * 0.28;
    final path = Path()
      ..moveTo(p.dx, p.dy - r)
      ..quadraticBezierTo(p.dx + w * 0.3, p.dy - w * 0.3, p.dx + r, p.dy)
      ..quadraticBezierTo(p.dx + w * 0.3, p.dy + w * 0.3, p.dx, p.dy + r)
      ..quadraticBezierTo(p.dx - w * 0.3, p.dy + w * 0.3, p.dx - r, p.dy)
      ..quadraticBezierTo(p.dx - w * 0.3, p.dy - w * 0.3, p.dx, p.dy - r)
      ..close();
    canvas.drawPath(
      path,
      Paint()..color = Colors.white.withValues(alpha: 0.95),
    );
  }

  @override
  bool shouldRepaint(MathStrikeEmblemPainter old) =>
      old.reticleTurns != reticleTurns ||
      old.strike != strike ||
      old.flash != flash ||
      old.glow != glow;
}

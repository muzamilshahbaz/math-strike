import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'avatar_catalog.dart';

/// Renders an [AvatarSpec] as a circular badge.
class AvatarView extends StatelessWidget {
  /// Creates the view.
  const AvatarView({required this.avatar, this.size = 64, super.key});

  /// What to draw.
  final AvatarSpec avatar;

  /// Diameter of the badge.
  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Avatar ${avatar.name}',
    image: true,
    child: CustomPaint(size: Size.square(size), painter: AvatarPainter(avatar)),
  );
}

/// Paints an avatar in a unit square scaled to the canvas.
class AvatarPainter extends CustomPainter {
  /// Creates the painter.
  const AvatarPainter(this.avatar);

  /// What to draw.
  final AvatarSpec avatar;

  static const Color _ink = Color(0xFF1B1530);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    canvas
      ..save()
      ..scale(s);

    _badge(canvas);
    canvas
      ..save()
      ..clipPath(Path()..addOval(const Rect.fromLTWH(0, 0, 1, 1)));
    if (avatar.top case AvatarTop.ears || AvatarTop.horns) _behindHead(canvas);
    final body = _bodyPath();
    _paintBody(canvas, body);
    _eyes(canvas);
    _mouth(canvas);
    if (avatar.top case AvatarTop.antenna) _antenna(canvas);
    if (avatar.top case AvatarTop.helmet) _helmet(canvas);
    canvas
      ..restore()
      ..restore();
  }

  /// Circular background tinted with the accent colour.
  void _badge(Canvas canvas) {
    const rect = Rect.fromLTWH(0, 0, 1, 1);
    canvas.drawOval(
      rect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.4),
          radius: 0.9,
          colors: [
            Color.lerp(avatar.accent, Colors.white, 0.55)!,
            Color.lerp(avatar.accent, const Color(0xFF1B1530), 0.35)!,
          ],
        ).createShader(rect),
    );
  }

  Path _bodyPath() => switch (avatar.body) {
    AvatarBody.round =>
      Path()..addOval(
        Rect.fromCircle(center: const Offset(0.5, 0.62), radius: 0.3),
      ),
    AvatarBody.boxy =>
      Path()..addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0.2, 0.34, 0.6, 0.56),
          const Radius.circular(0.14),
        ),
      ),
    AvatarBody.blob =>
      Path()..addOval(const Rect.fromLTWH(0.16, 0.36, 0.68, 0.56)),
    AvatarBody.bell =>
      Path()
        ..moveTo(0.5, 0.3)
        ..cubicTo(0.74, 0.3, 0.8, 0.52, 0.82, 0.92)
        ..lineTo(0.18, 0.92)
        ..cubicTo(0.2, 0.52, 0.26, 0.3, 0.5, 0.3)
        ..close(),
  };

  void _paintBody(Canvas canvas, Path body) {
    final bounds = body.getBounds();
    canvas
      ..drawPath(body, Paint()..color = avatar.color)
      // Soft top highlight and bottom shade give volume.
      ..drawPath(
        body,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.35),
              Colors.white.withValues(alpha: 0),
              Colors.black.withValues(alpha: 0.15),
            ],
            stops: const [0, 0.45, 1],
          ).createShader(bounds),
      );
  }

  /// Ears / horns, drawn before the body so they tuck behind the head.
  void _behindHead(Canvas canvas) {
    final isEars = avatar.top == AvatarTop.ears;
    final paint = Paint()..color = isEars ? avatar.color : avatar.accent;
    for (final side in const [-1.0, 1.0]) {
      final base = 0.5 + side * 0.17;
      final path = Path()
        ..moveTo(base - 0.1, isEars ? 0.46 : 0.42)
        ..quadraticBezierTo(
          base + side * 0.02,
          isEars ? 0.18 : 0.22,
          base + side * 0.06,
          isEars ? 0.2 : 0.24,
        )
        ..quadraticBezierTo(base + 0.06, 0.34, base + 0.1, 0.46)
        ..close();
      canvas.drawPath(path, paint);
      if (isEars) {
        // Inner ear.
        canvas.drawCircle(
          Offset(base + side * 0.02, 0.36),
          0.035,
          Paint()..color = avatar.accent.withValues(alpha: 0.7),
        );
      }
    }
  }

  void _eyes(Canvas canvas) {
    const y = 0.58;
    const dx = 0.12;
    final ink = Paint()..color = _ink;
    switch (avatar.eyes) {
      case AvatarEyes.dots:
        for (final x in const [0.5 - dx, 0.5 + dx]) {
          canvas
            ..drawCircle(Offset(x, y), 0.045, ink)
            ..drawCircle(
              Offset(x - 0.014, y - 0.016),
              0.013,
              Paint()..color = Colors.white,
            );
        }
      case AvatarEyes.big:
        for (final x in const [0.5 - dx, 0.5 + dx]) {
          canvas
            ..drawCircle(Offset(x, y), 0.082, Paint()..color = Colors.white)
            ..drawCircle(Offset(x + 0.012, y + 0.008), 0.048, ink)
            ..drawCircle(
              Offset(x - 0.006, y - 0.016),
              0.018,
              Paint()..color = Colors.white,
            );
        }
        _cheeks(canvas);
      case AvatarEyes.visor:
        final visor = RRect.fromRectAndRadius(
          const Rect.fromLTWH(0.27, y - 0.065, 0.46, 0.13),
          const Radius.circular(0.065),
        );
        canvas
          ..drawRRect(visor, ink)
          ..drawRRect(
            visor.deflate(0.022),
            Paint()
              ..shader = LinearGradient(colors: [avatar.accent, Colors.white])
                  .createShader(visor.outerRect),
          );
      case AvatarEyes.happy:
        final arc = Paint()
          ..color = _ink
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 0.035;
        for (final x in const [0.5 - dx, 0.5 + dx]) {
          canvas.drawArc(
            Rect.fromCircle(center: Offset(x, y + 0.02), radius: 0.05),
            math.pi,
            math.pi,
            false,
            arc,
          );
        }
        _cheeks(canvas);
    }
  }

  void _cheeks(Canvas canvas) {
    final blush = Paint()
      ..color = const Color(0xFFFF6F91).withValues(alpha: 0.45);
    canvas
      ..drawOval(const Rect.fromLTWH(0.24, 0.66, 0.09, 0.05), blush)
      ..drawOval(const Rect.fromLTWH(0.67, 0.66, 0.09, 0.05), blush);
  }

  void _mouth(Canvas canvas) {
    final smile = Paint()
      ..color = _ink
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.04;
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(0.5, 0.69), radius: 0.085),
      0.3,
      math.pi - 0.6,
      false,
      smile,
    );
  }

  void _antenna(Canvas canvas) {
    final top = avatar.body == AvatarBody.round ? 0.33 : 0.32;
    canvas
      ..drawLine(
        Offset(0.5, top),
        const Offset(0.5, 0.17),
        Paint()
          ..color = _ink
          ..strokeWidth = 0.03
          ..strokeCap = StrokeCap.round,
      )
      ..drawCircle(
        const Offset(0.5, 0.15),
        0.07,
        Paint()
          ..color = avatar.accent.withValues(alpha: 0.45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.03),
      )
      ..drawCircle(
        const Offset(0.5, 0.15),
        0.045,
        Paint()..color = avatar.accent,
      );
  }

  void _helmet(Canvas canvas) {
    const glass = Rect.fromLTWH(0.13, 0.25, 0.74, 0.74);
    canvas
      ..drawOval(glass, Paint()..color = Colors.white.withValues(alpha: 0.14))
      ..drawOval(
        glass,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.035
          ..color = avatar.accent,
      )
      // Glint.
      ..drawArc(
        glass.deflate(0.06),
        math.pi * 1.1,
        math.pi * 0.3,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 0.03
          ..color = Colors.white.withValues(alpha: 0.8),
      );
  }

  @override
  bool shouldRepaint(AvatarPainter old) => old.avatar != avatar;
}

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../theme/brand_colors.dart';

/// The official "MATH STRIKE" wordmark.
///
/// The letters are custom vector letterforms (angular, chamfered arcade
/// style, slanted for speed) rather than a font, so the logo is identical
/// on every platform regardless of installed fonts.
///
/// "MATH" uses [mathColor] (white on dark backgrounds, `onSurface` on light
/// ones); "STRIKE" always uses the cyan → violet → magenta brand gradient.
/// [reveal] (0–1) wipes the wordmark in from the left with a light sweep.
class MathStrikeWordmark extends StatelessWidget {
  /// Creates the wordmark at the given cap [height].
  const MathStrikeWordmark({
    this.height = 32,
    this.mathColor = BrandColors.star,
    this.reveal = 1,
    super.key,
  });

  /// Cap height in logical pixels; width follows the aspect ratio.
  final double height;

  /// Colour of "MATH".
  final Color mathColor;

  /// Wipe-in progress, 0–1.
  final double reveal;

  /// Width / height ratio of the wordmark.
  static double get aspectRatio => _WordmarkGeometry.width / _capHeight;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppConstants.appName,
      excludeSemantics: true,
      child: CustomPaint(
        size: Size(height * aspectRatio, height),
        painter: _WordmarkPainter(mathColor: mathColor, reveal: reveal),
      ),
    );
  }
}

const double _capHeight = 10;
const double _slant = 0.2; // horizontal shift per unit of height
const double _tracking = 1.3;
const double _wordGap = 4.2;

/// Letterforms on a 10-unit cap-height grid (y grows downwards).
/// Each glyph is a list of polygons; holes are wound inside the outline and
/// filled with the even-odd rule.
abstract final class _Glyphs {
  static const Map<String, (double, List<List<Offset>>)> data = {
    'M': (
      10.4,
      [
        [
          Offset(0, 10),
          Offset(0, 1.6),
          Offset(1.6, 0),
          Offset(3, 0),
          Offset(5.2, 3.2),
          Offset(7.4, 0),
          Offset(8.8, 0),
          Offset(10.4, 1.6),
          Offset(10.4, 10),
          Offset(7.8, 10),
          Offset(7.8, 4.6),
          Offset(5.2, 8),
          Offset(2.6, 4.6),
          Offset(2.6, 10),
        ],
      ],
    ),
    'A': (
      9.2,
      [
        [
          Offset(0, 10),
          Offset(0, 2.2),
          Offset(2.2, 0),
          Offset(7, 0),
          Offset(9.2, 2.2),
          Offset(9.2, 10),
          Offset(6.6, 10),
          Offset(6.6, 7.1),
          Offset(2.6, 7.1),
          Offset(2.6, 10),
        ],
        [
          Offset(2.6, 4.6),
          Offset(6.6, 4.6),
          Offset(6.6, 3.2),
          Offset(5.8, 2.5),
          Offset(3.4, 2.5),
          Offset(2.6, 3.2),
        ],
      ],
    ),
    'T': (
      9.2,
      [
        [
          Offset(0, 0),
          Offset(9.2, 0),
          Offset(9.2, 2.6),
          Offset(5.9, 2.6),
          Offset(5.9, 10),
          Offset(3.3, 10),
          Offset(3.3, 2.6),
          Offset(0, 2.6),
        ],
      ],
    ),
    'H': (
      9.2,
      [
        [
          Offset(0, 0),
          Offset(2.6, 0),
          Offset(2.6, 3.7),
          Offset(6.6, 3.7),
          Offset(6.6, 0),
          Offset(9.2, 0),
          Offset(9.2, 10),
          Offset(6.6, 10),
          Offset(6.6, 6.3),
          Offset(2.6, 6.3),
          Offset(2.6, 10),
          Offset(0, 10),
        ],
      ],
    ),
    'S': (
      9.2,
      [
        [
          Offset(0, 2.2),
          Offset(2.2, 0),
          Offset(9.2, 0),
          Offset(9.2, 2.6),
          Offset(2.6, 2.6),
          Offset(2.6, 3.7),
          Offset(7, 3.7),
          Offset(9.2, 5.9),
          Offset(9.2, 7.8),
          Offset(7, 10),
          Offset(0, 10),
          Offset(0, 7.4),
          Offset(6.6, 7.4),
          Offset(6.6, 6.3),
          Offset(2.2, 6.3),
          Offset(0, 4.1),
        ],
      ],
    ),
    'R': (
      9.6,
      [
        [
          Offset(0, 0),
          Offset(7, 0),
          Offset(9.2, 2.2),
          Offset(9.2, 4.6),
          Offset(7.6, 6.1),
          Offset(9.6, 10),
          Offset(6.7, 10),
          Offset(5, 6.6),
          Offset(2.6, 6.6),
          Offset(2.6, 10),
          Offset(0, 10),
        ],
        [
          Offset(2.6, 4.1),
          Offset(6.6, 4.1),
          Offset(6.6, 3.2),
          Offset(5.9, 2.5),
          Offset(2.6, 2.5),
        ],
      ],
    ),
    'I': (
      2.6,
      [
        [Offset(0, 0), Offset(2.6, 0), Offset(2.6, 10), Offset(0, 10)],
      ],
    ),
    'K': (
      9.6,
      [
        [
          Offset(0, 0),
          Offset(2.6, 0),
          Offset(2.6, 3.9),
          Offset(6.2, 0),
          Offset(9.6, 0),
          Offset(5.1, 5),
          Offset(9.6, 10),
          Offset(6.2, 10),
          Offset(2.6, 6.1),
          Offset(2.6, 10),
          Offset(0, 10),
        ],
      ],
    ),
    'E': (
      8.2,
      [
        [
          Offset(0, 0),
          Offset(8.2, 0),
          Offset(8.2, 2.6),
          Offset(2.6, 2.6),
          Offset(2.6, 3.7),
          Offset(7.2, 3.7),
          Offset(7.2, 6.3),
          Offset(2.6, 6.3),
          Offset(2.6, 7.4),
          Offset(8.2, 7.4),
          Offset(8.2, 10),
          Offset(0, 10),
        ],
      ],
    ),
  };
}

/// Pre-computed outlines of both words, in grid units.
abstract final class _WordmarkGeometry {
  static final (Path, double) _math = _word('MATH', 0);
  static final (Path, double) _strike = _word('STRIKE', _math.$2 + _wordGap);

  /// "MATH" outline.
  static Path get math => _math.$1;

  /// "STRIKE" outline.
  static Path get strike => _strike.$1;

  /// Horizontal extent of "STRIKE" (start, end), before slant.
  static (double, double) get strikeSpan => (_math.$2 + _wordGap, _strike.$2);

  /// Total width including the slant overhang.
  static double get width => _strike.$2 + _capHeight * _slant;

  /// Builds [text] starting at [x]; returns the path and the end x.
  static (Path, double) _word(String text, double x) {
    final path = Path()..fillType = PathFillType.evenOdd;
    var cursor = x;
    for (final (i, char) in text.split('').indexed) {
      final (advance, polygons) = _Glyphs.data[char]!;
      for (final polygon in polygons) {
        path.addPolygon([
          for (final p in polygon)
            // Slant: lean the top to the right.
            Offset(cursor + p.dx + (_capHeight - p.dy) * _slant, p.dy),
        ], true);
      }
      cursor += advance + (i == text.length - 1 ? 0 : _tracking);
    }
    return (path, cursor);
  }
}

class _WordmarkPainter extends CustomPainter {
  const _WordmarkPainter({required this.mathColor, required this.reveal});

  final Color mathColor;
  final double reveal;

  @override
  void paint(Canvas canvas, Size size) {
    if (reveal <= 0) return;
    final scale = size.height / _capHeight;
    final animating = reveal < 1;

    // A layer is only needed while the sweep is composited onto the letters.
    if (animating) {
      canvas
        ..saveLayer(Offset.zero & size, Paint())
        ..clipRect(Rect.fromLTWH(0, 0, size.width * reveal, size.height));
    }
    canvas
      ..save()
      ..scale(scale);

    final (strikeStart, strikeEnd) = _WordmarkGeometry.strikeSpan;
    final strikeShader = ui.Gradient.linear(
      Offset(strikeStart, 0),
      Offset(strikeEnd + _capHeight * _slant, 0),
      const [BrandColors.cyan, BrandColors.violet, BrandColors.magenta],
      const [0, 0.5, 1],
    );

    // Soft drop shadow for depth on busy backgrounds.
    final shadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.6);
    canvas
      ..save()
      ..translate(0, 0.5)
      ..drawPath(_WordmarkGeometry.math, shadow)
      ..drawPath(_WordmarkGeometry.strike, shadow)
      ..restore()
      ..drawPath(_WordmarkGeometry.math, Paint()..color = mathColor)
      ..drawPath(_WordmarkGeometry.strike, Paint()..shader = strikeShader);

    canvas.restore();

    if (animating) {
      // Light sweep riding the reveal edge, drawn only onto the letters.
      final x = size.width * reveal;
      final sweep = size.height * 1.2;
      canvas
        ..drawRect(
          Rect.fromLTWH(x - sweep, 0, sweep, size.height),
          Paint()
            ..blendMode = BlendMode.srcATop
            ..shader = ui.Gradient.linear(Offset(x - sweep, 0), Offset(x, 0), [
              Colors.white.withValues(alpha: 0),
              Colors.white.withValues(alpha: 0.9),
            ]),
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_WordmarkPainter old) =>
      old.mathColor != mathColor || old.reveal != reveal;
}

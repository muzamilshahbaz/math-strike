@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/theme/brand_colors.dart';
import 'package:math_strike/core/widgets/brand/math_strike_logo.dart';
import 'package:math_strike/core/widgets/brand/math_strike_wordmark.dart';

import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

/// Brand sheet: the emblem at icon sizes, the wordmark on dark and light
/// backgrounds, and key animation frames. Review this image whenever the
/// logo changes.
void main() {
  setUpAll(loadGoldenFonts);

  testWidgets('brand sheet', (tester) async {
    tester.setWindowSize(const Size(900, 760));

    Widget label(String text, {Color color = Colors.white60}) => Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(text, style: TextStyle(color: color, fontSize: 12)),
    );

    Widget cell(Widget child, String caption, {Color? captionColor}) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        label(caption, color: captionColor ?? Colors.white60),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          color: BrandColors.midnight,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    cell(const MathStrikeLogo(size: 192, glow: 0.6), '192'),
                    const SizedBox(width: 40),
                    cell(const MathStrikeLogo(size: 64), '64'),
                    const SizedBox(width: 32),
                    cell(const MathStrikeLogo(size: 32), '32'),
                    const SizedBox(width: 48),
                    cell(
                      const MathStrikeLogo(size: 120, strike: 0.45),
                      'strike 0.45',
                    ),
                    const SizedBox(width: 24),
                    cell(
                      const MathStrikeLogo(size: 120, flash: 1, glow: 1),
                      'impact',
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                cell(const MathStrikeWordmark(height: 56), 'wordmark'),
                const SizedBox(height: 28),
                cell(
                  const MathStrikeWordmark(height: 56, reveal: 0.6),
                  'reveal 0.6',
                ),
                const SizedBox(height: 28),
                Container(
                  color: const Color(0xFFF6F2FF),
                  padding: const EdgeInsets.all(20),
                  child: cell(
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MathStrikeLogo(size: 48),
                        SizedBox(width: 14),
                        MathStrikeWordmark(
                          height: 22,
                          mathColor: Color(0xFF1C1530),
                        ),
                      ],
                    ),
                    'horizontal lockup on light',
                    captionColor: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/brand_sheet.png'),
    );
  });
}

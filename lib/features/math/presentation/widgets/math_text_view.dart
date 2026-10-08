import 'package:flutter/material.dart';

import '../../domain/engine/math_text.dart';

/// Shows engine text (prompts, answers, explanations), drawing exponents
/// marked up as `2^5` raised and smaller.
///
/// Uses plain digits rather than Unicode superscripts, so it renders with
/// any font and needs no runtime font downloads. Screen readers hear
/// "2 to the power of 5".
class MathTextView extends StatelessWidget {
  /// Creates the view.
  const MathTextView(this.text, {this.style, this.textAlign, super.key});

  /// Engine text, possibly containing exponent markup.
  final String text;

  /// Base text style.
  final TextStyle? style;

  /// Alignment.
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final base = DefaultTextStyle.of(context).style.merge(style);
    final fontSize = base.fontSize ?? 14;
    final runs = MathText.runs(text);
    if (runs.every((run) => !run.$2)) {
      return Text(text, style: style, textAlign: textAlign);
    }
    return Text.rich(
      TextSpan(
        children: [
          for (final (content, raised) in runs)
            if (raised)
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: Transform.translate(
                  offset: Offset(0, -fontSize * 0.42),
                  child: Text(
                    content,
                    style: base.copyWith(fontSize: fontSize * 0.62),
                  ),
                ),
              )
            else
              TextSpan(text: content),
        ],
      ),
      style: style,
      textAlign: textAlign,
      semanticsLabel: MathText.spoken(text),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/app_durations.dart';
import '../theme/theme_context.dart';
import '../utils/formatters.dart';

/// Shows an integer that counts up (or down) to each new [value].
///
/// The first value appears immediately; later changes roll over
/// [duration]. With reduced motion the new value appears at once.
class AnimatedCount extends StatelessWidget {
  /// Creates the counter.
  const AnimatedCount({
    required this.value,
    this.style,
    this.duration = AppDurations.extraLong,
    this.formatter = formatCount,
    super.key,
  });

  /// The value to show.
  final int value;

  /// Text style.
  final TextStyle? style;

  /// How long a change takes to roll over.
  final Duration duration;

  /// Turns the (intermediate) value into text.
  final String Function(int value) formatter;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(end: value.toDouble()),
    duration: context.motion(duration),
    curve: Curves.easeOutCubic,
    builder: (context, current, _) => Text(
      formatter(current.round()),
      style: style,
      // Screen readers announce the final value, not each step.
      semanticsLabel: formatter(value),
    ),
  );
}

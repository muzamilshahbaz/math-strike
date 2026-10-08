import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../domain/entities/math_topic.dart';
import '../../domain/entities/topic_mastery.dart';

/// A short symbol for [topic], or `null` when it is shown as an icon.
String? _glyph(MathTopic topic) => switch (topic) {
  MathTopic.addition => '+',
  MathTopic.subtraction => '−',
  MathTopic.multiplication => '×',
  MathTopic.division => '÷',
  MathTopic.fractions => '½',
  MathTopic.decimals => '.5',
  MathTopic.percentages => '%',
  MathTopic.integers => '±',
  MathTopic.algebra => 'x',
  MathTopic.squareRoots => '√',
  MathTopic.exponents => 'x²',
  _ => null,
};

IconData _icon(MathTopic topic) => switch (topic) {
  MathTopic.geometry => Icons.change_history_rounded,
  MathTopic.time => Icons.schedule_rounded,
  MathTopic.money => Icons.payments_rounded,
  MathTopic.measurement => Icons.straighten_rounded,
  MathTopic.probability => Icons.casino_rounded,
  MathTopic.statistics => Icons.bar_chart_rounded,
  _ => Icons.menu_book_rounded,
};

/// A distinct accent colour per topic, tuned for the theme brightness.
Color topicColor(BuildContext context, MathTopic topic) {
  final hue = topic.index * 360 / MathTopic.values.length;
  final dark = Theme.of(context).brightness == Brightness.dark;
  return HSLColor.fromAHSL(1, hue, 0.6, dark ? 0.68 : 0.42).toColor();
}

/// A round badge with the topic's symbol.
class TopicBadge extends StatelessWidget {
  /// Creates the badge.
  const TopicBadge({required this.topic, this.size = 44, super.key});

  /// The topic.
  final MathTopic topic;

  /// Diameter.
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = topicColor(context, topic);
    final glyph = _glyph(topic);
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.16),
          shape: BoxShape.circle,
        ),
        child: glyph == null
            ? Icon(_icon(topic), color: color, size: size * 0.55)
            : Text(
                glyph,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  color: color,
                  fontSize: size * (glyph.length > 1 ? 0.38 : 0.5),
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
      ),
    );
  }
}

/// A small pill describing a topic's [strength].
class StrengthChip extends StatelessWidget {
  /// Creates the chip.
  const StrengthChip({required this.strength, super.key});

  /// What to show.
  final TopicStrength strength;

  @override
  Widget build(BuildContext context) {
    final palette = context.gamePalette;
    final color = switch (strength) {
      TopicStrength.weak => palette.wrong,
      TopicStrength.strong => palette.correct,
      TopicStrength.developing => palette.diamond,
      TopicStrength.notStarted => context.colors.outline,
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: const BorderRadius.all(AppRadii.pill),
      ),
      child: Text(
        strength.label,
        style: context.textStyles.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

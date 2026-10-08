import 'package:flutter/material.dart';

import '../constants/app_durations.dart';
import '../theme/app_tokens.dart';
import '../theme/theme_context.dart';

/// A tappable card with an animated selected state.
///
/// Exposes selection to screen readers, shows a check badge (so selection
/// is never conveyed by colour alone), and has a hover / focus highlight
/// for mouse and keyboard users.
class SelectableCard extends StatelessWidget {
  /// Creates the card.
  const SelectableCard({
    required this.selected,
    required this.onTap,
    required this.child,
    this.semanticLabel,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  /// Whether this option is selected.
  final bool selected;

  /// Called when tapped / activated.
  final VoidCallback onTap;

  /// Card content.
  final Widget child;

  /// Accessible description, if [child] is not self-describing.
  final String? semanticLabel;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      child: AnimatedScale(
        scale: selected ? 1.0 : 0.98,
        duration: context.motion(AppDurations.short),
        child: AnimatedContainer(
          duration: context.motion(AppDurations.medium),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: selected
                ? colors.primaryContainer
                : colors.surfaceContainerHigh,
            borderRadius: AppRadii.mdAll,
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
              width: selected ? 2.5 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : const [],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: AppRadii.mdAll,
              onTap: onTap,
              child: Stack(
                children: [
                  Padding(padding: padding, child: child),
                  PositionedDirectional(
                    top: AppSpacing.sm,
                    end: AppSpacing.sm,
                    child: AnimatedScale(
                      scale: selected ? 1 : 0,
                      duration: context.motion(AppDurations.short),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 20,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

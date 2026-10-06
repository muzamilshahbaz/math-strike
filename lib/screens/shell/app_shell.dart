import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/theme_context.dart';
import '../../core/widgets/brand/math_strike_logo.dart';
import '../../core/widgets/brand/math_strike_wordmark.dart';
import '../../core/widgets/responsive/window_size.dart';
import 'app_destinations.dart';

/// Adaptive navigation chrome around the top-level tabs.
///
/// * compact (phones): bottom [NavigationBar]
/// * medium / expanded (tablets): collapsed [NavigationRail]
/// * large (desktop / wide web): extended sidebar
///
/// `Alt + 1â€¦5` switches tabs on keyboards.
class AppShell extends StatelessWidget {
  /// Creates the shell for [navigationShell].
  const AppShell({required this.navigationShell, super.key});

  /// Router-provided shell that owns the per-tab navigators.
  final StatefulNavigationShell navigationShell;

  static const List<LogicalKeyboardKey> _digitKeys = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit4,
    LogicalKeyboardKey.digit5,
    LogicalKeyboardKey.digit6,
    LogicalKeyboardKey.digit7,
    LogicalKeyboardKey.digit8,
    LogicalKeyboardKey.digit9,
  ];

  void _select(int index) => navigationShell.goBranch(
    index,
    // Re-selecting the active tab pops it back to its root.
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final size = context.windowSize;
    final scaffold = size == WindowSize.compact
        ? Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _select,
              destinations: [
                for (final d in appDestinations)
                  NavigationDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: d.label,
                  ),
              ],
            ),
          )
        : Scaffold(
            body: Row(
              children: [
                _SideNavigation(
                  selectedIndex: navigationShell.currentIndex,
                  onSelected: _select,
                  extended: size == WindowSize.large,
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: navigationShell),
              ],
            ),
          );

    return CallbackShortcuts(
      bindings: {
        for (
          var i = 0;
          i < appDestinations.length && i < _digitKeys.length;
          i++
        )
          SingleActivator(_digitKeys[i], alt: true): () => _select(i),
      },
      child: Focus(autofocus: true, child: scaffold),
    );
  }
}

/// Navigation rail that expands into a labelled sidebar on large screens.
class _SideNavigation extends StatelessWidget {
  const _SideNavigation({
    required this.selectedIndex,
    required this.onSelected,
    required this.extended,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    // On short windows (e.g. phones in landscape) the destinations may not
    // fit vertically: let the rail scroll instead of overflowing, while
    // still filling the full height when there is room.
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(child: _rail()),
        ),
      ),
    );
  }

  Widget _rail() {
    return NavigationRail(
      extended: extended,
      minExtendedWidth: AppSizes.sidebarWidth,
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      groupAlignment: -0.85,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: _Brand(extended: extended),
      ),
      destinations: [
        for (final (i, d) in appDestinations.indexed)
          NavigationRailDestination(
            icon: Tooltip(
              message: '${d.label}  (Alt+${i + 1})',
              child: Icon(d.icon),
            ),
            selectedIcon: Icon(d.selectedIcon),
            label: Text(d.label),
          ),
      ],
    );
  }
}

/// Logo mark, plus the product name when there is room.
class _Brand extends StatelessWidget {
  const _Brand({required this.extended});

  final bool extended;

  @override
  Widget build(BuildContext context) {
    const mark = MathStrikeLogo();
    return Semantics(
      label: AppConstants.appName,
      excludeSemantics: true,
      child: extended
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                mark,
                const SizedBox(width: AppSpacing.smd),
                // Official wordmark; "MATH" follows the theme so it reads on
                // both light and dark surfaces.
                MathStrikeWordmark(
                  height: 15,
                  mathColor: context.colors.onSurface,
                ),
              ],
            )
          : mark,
    );
  }
}

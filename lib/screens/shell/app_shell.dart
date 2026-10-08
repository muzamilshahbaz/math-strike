import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/di/core_providers.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/theme_context.dart';
import '../../core/widgets/brand/math_strike_logo.dart';
import '../../core/widgets/brand/math_strike_wordmark.dart';
import '../../core/widgets/responsive/window_size.dart';
import '../../features/rewards/presentation/controllers/daily_reward_controller.dart';
import 'app_destinations.dart';

/// Adaptive navigation chrome around the top-level tabs.
///
/// * compact (phones): bottom [NavigationBar]
/// * medium / expanded (tablets): collapsed [NavigationRail]
/// * large (desktop / wide web): extended sidebar
///
/// `Alt + 1…5` switches tabs on keyboards. A badge on Home signals an
/// unclaimed daily reward.
class AppShell extends ConsumerStatefulWidget {
  /// Creates the shell for [navigationShell].
  const AppShell({required this.navigationShell, super.key});

  /// Router-provided shell that owns the per-tab navigators.
  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  // Timers may not fire while a mobile app is suspended, so re-check the
  // date on resume: a reward left open overnight becomes claimable.
  late final AppLifecycleListener _lifecycle;

  StatefulNavigationShell get navigationShell => widget.navigationShell;

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
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.read(currentDayProvider.notifier).refresh(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  /// Which destinations currently show an attention badge.
  List<bool> _badges() {
    final rewardReady = ref.watch(
      dailyRewardControllerProvider.select((status) => status.canClaim),
    );
    return [
      for (final (i, _) in appDestinations.indexed) i == 0 && rewardReady,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = context.windowSize;
    final badges = _badges();
    final scaffold = size == WindowSize.compact
        ? Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _select,
              destinations: [
                for (final (i, d) in appDestinations.indexed)
                  NavigationDestination(
                    icon: _BadgedIcon(d.icon, badged: badges[i]),
                    selectedIcon: _BadgedIcon(
                      d.selectedIcon,
                      badged: badges[i],
                    ),
                    label: d.label,
                  ),
              ],
            ),
          )
        : Scaffold(
            body: Row(
              children: [
                _SideNavigation(
                  badges: badges,
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
    required this.badges,
    required this.selectedIndex,
    required this.onSelected,
    required this.extended,
  });

  final List<bool> badges;
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
              child: _BadgedIcon(d.icon, badged: badges[i]),
            ),
            selectedIcon: _BadgedIcon(d.selectedIcon, badged: badges[i]),
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

/// A destination icon with an optional attention dot.
class _BadgedIcon extends StatelessWidget {
  const _BadgedIcon(this.icon, {required this.badged});

  final IconData icon;
  final bool badged;

  @override
  Widget build(BuildContext context) => Semantics(
    label: badged ? 'Reward ready' : null,
    child: Badge(isLabelVisible: badged, smallSize: 10, child: Icon(icon)),
  );
}

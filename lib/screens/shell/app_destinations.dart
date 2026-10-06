import 'package:flutter/material.dart';

/// A top-level navigation destination shown in the bar / rail / sidebar.
///
/// The order of [appDestinations] must match the branch order in
/// `app_router.dart`.
@immutable
class AppDestination {
  /// Creates a destination.
  const AppDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  /// Short label.
  final String label;

  /// Icon when not selected.
  final IconData icon;

  /// Icon when selected.
  final IconData selectedIcon;
}

/// Top-level destinations, in shell-branch order.
const List<AppDestination> appDestinations = [
  AppDestination(
    label: 'Home',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
  ),
  AppDestination(
    label: 'Play',
    icon: Icons.sports_esports_outlined,
    selectedIcon: Icons.sports_esports_rounded,
  ),
  AppDestination(
    label: 'Progress',
    icon: Icons.insights_outlined,
    selectedIcon: Icons.insights_rounded,
  ),
  AppDestination(
    label: 'Shop',
    icon: Icons.storefront_outlined,
    selectedIcon: Icons.storefront_rounded,
  ),
  AppDestination(
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings_rounded,
  ),
];

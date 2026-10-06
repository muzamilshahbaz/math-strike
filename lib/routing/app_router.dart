import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/di/core_providers.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../screens/error/not_found_screen.dart';
import '../screens/placeholder/placeholder_screen.dart';
import '../screens/shell/app_shell.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

/// The app's [GoRouter].
///
/// Top-level tabs live in a [StatefulShellRoute] so each tab keeps its own
/// navigation stack and scroll position. Gameplay is a sibling route so it
/// renders full-screen without navigation chrome. Redirect guards for
/// sign-in (Phase 3) and onboarding (Phase 4) plug into `redirect`.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: !ref.read(appConfigProvider).isProduction,
    errorBuilder: (context, state) => NotFoundScreen(location: state.uri.path),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          _branch(
            AppRoutes.home,
            (context) => PlaceholderScreen(
              title: 'Home',
              icon: Icons.home_rounded,
              phase: 5,
              description:
                  'Your dashboard with stats, daily rewards and quick play.',
              action: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.game),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Quick play'),
              ),
            ),
          ),
          _branch(
            AppRoutes.play,
            (_) => const PlaceholderScreen(
              title: 'Play',
              icon: Icons.sports_esports_rounded,
              phase: 9,
              description: '1000+ levels, boss fights and game modes.',
            ),
          ),
          _branch(
            AppRoutes.progress,
            (_) => const PlaceholderScreen(
              title: 'Progress',
              icon: Icons.insights_rounded,
              phase: 14,
              description: 'Accuracy, reaction time and weak-topic reports.',
            ),
          ),
          _branch(
            AppRoutes.shop,
            (_) => const PlaceholderScreen(
              title: 'Shop',
              icon: Icons.storefront_rounded,
              phase: 10,
              description: 'Avatars, weapons, themes and effects.',
            ),
          ),
          _branch(AppRoutes.settings, (_) => const SettingsScreen()),
        ],
      ),
      GoRoute(
        path: AppRoutes.game,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Game',
          icon: Icons.rocket_launch_rounded,
          phase: 7,
          description: 'Shoot the correct answer before enemies reach you!',
        ),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}

StatefulShellBranch _branch(String path, WidgetBuilder builder) =>
    StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (context, _) => builder(context))],
    );

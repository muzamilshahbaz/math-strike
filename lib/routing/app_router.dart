import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/di/core_providers.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/splash/presentation/controllers/startup_controller.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../screens/error/not_found_screen.dart';
import '../screens/placeholder/placeholder_screen.dart';
import '../screens/shell/app_shell.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

/// The app's [GoRouter].
///
/// Top-level tabs live in a [StatefulShellRoute] so each tab keeps its own
/// navigation stack and scroll position. Gameplay is a sibling route so it
/// renders full-screen without navigation chrome.
///
/// Guards (see [startupRedirect]): until start-up completes every location
/// redirects to the splash, remembering where the user was going. Sign-in
/// (Phase 3) and onboarding (Phase 4) guards are added the same way.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Re-evaluates redirects when start-up completes, without rebuilding the
  // router (which would reset navigation state).
  final startupDone = ValueNotifier<bool>(
    ref.read(startupControllerProvider).isCompleted,
  );
  ref
    // ValueNotifier only notifies when the value actually changes.
    ..listen(
      startupControllerProvider,
      (_, next) => startupDone.value = next.isCompleted,
    )
    ..onDispose(startupDone.dispose);

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: !ref.read(appConfigProvider).isProduction,
    refreshListenable: startupDone,
    redirect: (context, state) =>
        startupRedirect(uri: state.uri, startupCompleted: startupDone.value),
    errorBuilder: (context, state) => NotFoundScreen(location: state.uri.path),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
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

/// Start-up guard.
///
/// * Before completion: any location except the splash redirects to
///   `/splash?from=<location>`.
/// * After completion: the splash forwards to `from` (or home).
///
/// `from` must be an in-app absolute path; anything else falls back to home
/// so crafted links cannot redirect outside the app.
@visibleForTesting
String? startupRedirect({required Uri uri, required bool startupCompleted}) {
  final atSplash = uri.path == AppRoutes.splash;
  if (!startupCompleted) {
    if (atSplash) return null;
    return Uri(
      path: AppRoutes.splash,
      queryParameters: {AppRoutes.fromParam: uri.toString()},
    ).toString();
  }
  if (!atSplash) return null;
  final from = uri.queryParameters[AppRoutes.fromParam];
  final isSafe =
      from != null &&
      from.startsWith('/') &&
      !from.startsWith('//') &&
      !from.startsWith(AppRoutes.splash);
  return isSafe ? from : AppRoutes.home;
}

StatefulShellBranch _branch(String path, WidgetBuilder builder) =>
    StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (context, _) => builder(context))],
    );

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/di/core_providers.dart';
import '../features/authentication/presentation/screens/sign_in_screen.dart';
import '../features/backup/presentation/screens/restore_screen.dart';
import '../features/math/domain/entities/math_topic.dart';
import '../features/math/presentation/screens/practice_screen.dart';
import '../features/math/presentation/screens/practice_session_screen.dart';
import '../features/profile/presentation/screens/onboarding_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/statistics/presentation/screens/statistics_screen.dart';
import '../screens/error/not_found_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/placeholder/placeholder_screen.dart';
import '../screens/shell/app_shell.dart';
import 'app_gate.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

/// The app's [GoRouter].
///
/// Top-level tabs live in a [StatefulShellRoute] so each tab keeps its own
/// navigation stack and scroll position. Gameplay is a sibling route so it
/// renders full-screen without navigation chrome.
///
/// Every navigation passes through [appRedirect]: splash → mandatory
/// sign-in → backup check / restore → onboarding → app.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Re-evaluates redirects when the gate changes, without rebuilding the
  // router (which would reset navigation state). ValueNotifier only
  // notifies when the (value-equal) gate actually changes.
  final gate = ValueNotifier<AppGate>(ref.read(appGateProvider));
  ref
    ..listen(appGateProvider, (_, next) => gate.value = next)
    ..onDispose(gate.dispose);

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: !ref.read(appConfigProvider).isProduction,
    refreshListenable: gate,
    redirect: (context, state) => appRedirect(uri: state.uri, gate: gate.value),
    errorBuilder: (context, state) => NotFoundScreen(location: state.uri.path),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.accountSetup,
        builder: (context, state) => const RestoreScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          _branch(AppRoutes.home, (_) => const HomeScreen()),
          _branch(
            AppRoutes.play,
            (context) => PlaceholderScreen(
              title: 'Play',
              icon: Icons.sports_esports_rounded,
              phase: 9,
              description: '1000+ levels, boss fights and game modes.',
              action: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.practice),
                icon: const Icon(Icons.school_rounded),
                label: const Text('Practice mode'),
              ),
            ),
          ),
          _branch(AppRoutes.progress, (_) => const StatisticsScreen()),
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
        path: AppRoutes.practice,
        builder: (context, state) => const PracticeScreen(),
        routes: [
          GoRoute(
            path: 'session',
            builder: (context, state) => PracticeSessionScreen(
              topic: MathTopic.tryParse(
                state.uri.queryParameters[AppRoutes.topicParam] ?? '',
              ),
            ),
          ),
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

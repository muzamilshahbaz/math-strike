import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_durations.dart';
import 'core/di/core_providers.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/accessibility_media_scope.dart';
import 'features/settings/presentation/controllers/appearance_controller.dart';
import 'routing/app_router.dart';

/// Root widget: wires theme, accessibility and routing together.
class MathStrikeApp extends ConsumerWidget {
  /// Creates the app. Must be placed under a configured `ProviderScope`.
  const MathStrikeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final appearance = ref.watch(appearanceControllerProvider);
    final router = ref.watch(appRouterProvider);
    final seed = appearance.gameTheme.seedColor;

    ThemeData theme(Brightness brightness, {required bool highContrast}) =>
        AppTheme.build(
          seedColor: seed,
          brightness: brightness,
          highContrast: highContrast,
        );

    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      themeMode: appearance.themeMode,
      theme: theme(Brightness.light, highContrast: appearance.highContrast),
      darkTheme: theme(Brightness.dark, highContrast: appearance.highContrast),
      // Used automatically when the OS requests high contrast.
      highContrastTheme: theme(Brightness.light, highContrast: true),
      highContrastDarkTheme: theme(Brightness.dark, highContrast: true),
      themeAnimationDuration: appearance.reduceMotion
          ? Duration.zero
          : AppDurations.medium,
      routerConfig: router,
      builder: (context, child) => AccessibilityMediaScope(
        textScale: appearance.textScale,
        reduceMotion: appearance.reduceMotion,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

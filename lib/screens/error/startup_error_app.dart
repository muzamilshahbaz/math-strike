import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/game_theme_id.dart';

/// Minimal standalone app shown when start-up fails before the DI container
/// exists (e.g. the local database cannot be opened).
class StartupErrorApp extends StatelessWidget {
  /// Creates the error app. [onRetry] re-runs start-up.
  const StartupErrorApp({required this.onRetry, super.key});

  /// Re-runs the bootstrap sequence.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(
        seedColor: GameThemeId.space.seedColor,
        brightness: Brightness.dark,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 72),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Something went wrong while starting up',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    'Your saved data could not be opened. Please try again.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try again'),
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

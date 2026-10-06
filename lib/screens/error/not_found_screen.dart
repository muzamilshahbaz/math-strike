import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/theme/theme_context.dart';
import '../../routing/app_routes.dart';

/// Shown for unknown routes (mostly reachable via web deep links).
class NotFoundScreen extends StatelessWidget {
  /// Creates the screen for the unmatched [location].
  const NotFoundScreen({required this.location, super.key});

  /// The path that did not match any route.
  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.explore_off_rounded,
                size: 72,
                color: context.colors.primary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Page not found', style: context.textStyles.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Text(location, style: context.textStyles.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('Go home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

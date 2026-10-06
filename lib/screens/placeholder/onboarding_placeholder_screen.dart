import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/authentication/domain/entities/account_link.dart';
import '../../features/authentication/presentation/controllers/account_controller.dart';
import 'placeholder_screen.dart';

/// Stand-in for profile onboarding (name, avatar, age group, difficulty,
/// theme, sound — Phase 4). Completing it finishes first-launch setup so
/// the whole flow can be exercised end to end today.
class OnboardingPlaceholderScreen extends ConsumerWidget {
  /// Creates the placeholder.
  const OnboardingPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PlaceholderScreen(
    title: 'Create your player',
    icon: Icons.person_add_alt_1_rounded,
    phase: 4,
    description:
        'Name, avatar, age group, difficulty, theme and sound choices.',
    action: FilledButton.icon(
      onPressed: () => unawaited(
        ref
            .read(accountControllerProvider.notifier)
            .advanceTo(AccountSetupStage.complete),
      ),
      icon: const Icon(Icons.arrow_forward_rounded),
      label: const Text('Continue to the app'),
    ),
  );
}

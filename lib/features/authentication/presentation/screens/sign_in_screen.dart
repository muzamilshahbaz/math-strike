import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/brand_colors.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/brand/brand_backdrop.dart';
import '../../../../core/widgets/brand/math_strike_logo.dart';
import '../../../../core/widgets/brand/math_strike_wordmark.dart';
import '../../authentication_providers.dart';
import '../controllers/sign_in_controller.dart';

/// Mandatory first-launch sign-in.
///
/// Explains *why* a Google account is needed (private backup and restore),
/// and what the app can and cannot access. There is no way to skip it; the
/// router keeps the player here until a device link exists.
class SignInScreen extends ConsumerWidget {
  /// Creates the screen.
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signInControllerProvider);
    final mode = ref.watch(googleIntegrationModeProvider);
    final unavailable = mode == GoogleIntegrationMode.unavailable;

    return BrandBackdrop(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MathStrikeLogo(size: 88, glow: 0.5),
                  const SizedBox(height: AppSpacing.lg),
                  const MathStrikeWordmark(height: 22),
                  const SizedBox(height: AppSpacing.xl),
                  Semantics(
                    header: true,
                    child: const Text(
                      'Keep your progress safe',
                      textAlign: TextAlign.center,
                      style: BrandText.headline,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Sign in once with Google so your progress can be backed '
                    'up and restored on any device.',
                    textAlign: TextAlign.center,
                    style: BrandText.body,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _Benefit(
                    icon: Icons.wifi_off_rounded,
                    text: 'Play anywhere — even offline',
                  ),
                  const _Benefit(
                    icon: Icons.lock_rounded,
                    text: 'Private backup in your own Google Drive',
                  ),
                  const _Benefit(
                    icon: Icons.devices_rounded,
                    text: 'Restore on a new phone, tablet or computer',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _GoogleButton(
                    busy: state.busy,
                    label: state.errorMessage == null
                        ? 'Continue with Google'
                        : 'Try again',
                    onPressed: unavailable
                        ? null
                        : () => unawaited(
                            ref
                                .read(signInControllerProvider.notifier)
                                .signIn(),
                          ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _StatusMessage(state: state, unavailable: unavailable),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Math Strike can only open its own hidden folder in your '
                    'Drive. It never sees your other files.',
                    textAlign: TextAlign.center,
                    style: BrandText.caption,
                  ),
                  if (mode == GoogleIntegrationMode.demo) ...[
                    const SizedBox(height: AppSpacing.lg),
                    const _DemoModeNotice(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs + 2),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: BrandColors.violet.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(AppRadii.sm),
          ),
          child: Icon(icon, size: 20, color: BrandColors.cyan),
        ),
        const SizedBox(width: AppSpacing.smd),
        Expanded(
          child: Text(
            text,
            style: BrandText.body.copyWith(color: BrandColors.star),
          ),
        ),
      ],
    ),
  );
}

/// High-contrast primary action. Uses a neutral account icon rather than a
/// hand-drawn Google mark; the official branded button asset is added with
/// the release assets (Phase 17).
class _GoogleButton extends StatelessWidget {
  const _GoogleButton({
    required this.busy,
    required this.label,
    required this.onPressed,
  });

  final bool busy;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // Minimum (not fixed) height so the label can wrap with large text.
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: 56,
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: BrandColors.star,
          foregroundColor: const Color(0xFF1F1F1F),
          disabledBackgroundColor: BrandColors.star.withValues(alpha: 0.4),
          // Derived from the theme so the app font is kept.
          textStyle: context.textStyles.labelLarge?.copyWith(fontSize: 16),
        ),
        onPressed: busy ? null : onPressed,
        child: AnimatedSwitcher(
          duration: context.motion(AppDurations.short),
          child: busy
              ? const SizedBox(
                  key: ValueKey('busy'),
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    semanticsLabel: 'Signing in',
                  ),
                )
              : Row(
                  key: ValueKey(label),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_circle_rounded),
                    const SizedBox(width: AppSpacing.smd),
                    Flexible(child: Text(label, textAlign: TextAlign.center)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _StatusMessage extends StatelessWidget {
  const _StatusMessage({required this.state, required this.unavailable});

  final SignInState state;
  final bool unavailable;

  @override
  Widget build(BuildContext context) {
    final (String? text, bool isError) = switch (state) {
      _ when unavailable => (
        "Sign-in isn't configured for this build. Please contact support.",
        true,
      ),
      SignInState(:final errorMessage?) => (errorMessage, true),
      SignInState(cancelled: true) => (
        'A Google account is needed to play, so your progress is never lost. '
            'Your data stays in your own Drive.',
        false,
      ),
      _ => (null, false),
    };
    return AnimatedSize(
      duration: context.motion(AppDurations.medium),
      child: text == null
          ? const SizedBox(width: double.infinity)
          : Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.smd),
                decoration: BoxDecoration(
                  color: (isError ? BrandColors.magenta : BrandColors.violet)
                      .withValues(alpha: 0.16),
                  borderRadius: AppRadii.mdAll,
                  border: Border.all(
                    color: (isError ? BrandColors.magenta : BrandColors.violet)
                        .withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: BrandText.body.copyWith(fontSize: 14),
                ),
              ),
            ),
    );
  }
}

class _DemoModeNotice extends StatelessWidget {
  const _DemoModeNotice();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.smd,
      vertical: AppSpacing.sm,
    ),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(AppRadii.pill),
      border: Border.all(color: BrandColors.cyan.withValues(alpha: 0.6)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.science_rounded, size: 16, color: BrandColors.cyan),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            'Developer mode: Google is not configured, a demo account is used',
            style: BrandText.caption.copyWith(color: BrandColors.cyan),
          ),
        ),
      ],
    ),
  );
}

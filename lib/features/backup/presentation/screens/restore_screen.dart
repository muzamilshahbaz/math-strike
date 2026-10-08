import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_messages.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/brand_colors.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/brand/brand_backdrop.dart';
import '../../../../core/widgets/brand/math_strike_logo.dart';
import '../../../authentication/presentation/controllers/account_controller.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../domain/entities/backup_metadata.dart';
import '../controllers/restore_flow_controller.dart';

/// First-launch step after sign-in: looks for a backup in the player's
/// Drive app folder and restores it automatically, with progress.
///
/// Outcomes advance the account setup stage, after which the router moves
/// on: restored → the app; no backup (or skipped) → onboarding.
class RestoreScreen extends ConsumerStatefulWidget {
  /// Creates the screen. [outcomeHold] is how long the "restored" / "no
  /// backup" message stays before moving on.
  const RestoreScreen({
    this.outcomeHold = const Duration(milliseconds: 1600),
    super.key,
  });

  /// Pause on outcome messages before continuing automatically.
  final Duration outcomeHold;

  @override
  ConsumerState<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends ConsumerState<RestoreScreen> {
  Timer? _autoContinue;

  RestoreFlowController get _controller =>
      ref.read(restoreFlowControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_controller.start());
    });
  }

  @override
  void dispose() {
    _autoContinue?.cancel();
    super.dispose();
  }

  void _continue() {
    _autoContinue?.cancel();
    unawaited(_controller.finish());
  }

  Future<void> _confirmSkip() async {
    final skip = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Continue without restoring?'),
        content: const Text(
          "You'll start with a new profile. Your backup stays safe in Google "
          'Drive and can be restored later from Settings → Backup.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
    if (skip ?? false) _continue();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restoreFlowControllerProvider);
    final account = ref.watch(accountControllerProvider)?.account;
    // Available once a restore has replaced local data.
    final restoredName = state is RestoreSucceeded
        ? ref.watch(profileControllerProvider)?.name
        : null;

    ref.listen(restoreFlowControllerProvider, (_, next) {
      if (next is RestoreSucceeded || next is NoBackupFound) {
        _autoContinue?.cancel();
        _autoContinue = Timer(widget.outcomeHold, _continue);
      }
    });

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
                  const MathStrikeLogo(size: 64, glow: 0.4),
                  if (account != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    _AccountChip(email: account.email),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  AnimatedSwitcher(
                    duration: context.motion(AppDurations.medium),
                    child: KeyedSubtree(
                      key: ValueKey(state.runtimeType),
                      child: switch (state) {
                        RestoreChecking() => const _Checking(),
                        RestoreInProgress(:final backup, :final progress) =>
                          _Restoring(backup: backup, progress: progress),
                        RestoreSucceeded() => _Outcome(
                          icon: Icons.check_circle_rounded,
                          color: BrandColors.cyan,
                          title: switch (restoredName) {
                            final name? => 'Welcome back, $name!',
                            null => 'Welcome back!',
                          },
                          message: 'Your progress has been restored.',
                          onContinue: _continue,
                        ),
                        NoBackupFound() => _Outcome(
                          icon: Icons.rocket_launch_rounded,
                          color: BrandColors.violet,
                          title: 'No backup yet',
                          message: "Let's set up your player profile.",
                          onContinue: _continue,
                        ),
                        RestoreFailed(:final failure, :final duringRestore) =>
                          _Failed(
                            failure: failure,
                            duringRestore: duringRestore,
                            onRetry: () => unawaited(_controller.start()),
                            onSkip: () => unawaited(_confirmSkip()),
                          ),
                      },
                    ),
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

class _AccountChip extends StatelessWidget {
  const _AccountChip({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.smd,
      vertical: AppSpacing.xs + 2,
    ),
    decoration: BoxDecoration(
      color: BrandColors.star.withValues(alpha: 0.08),
      borderRadius: const BorderRadius.all(AppRadii.pill),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.account_circle_rounded,
          size: 18,
          color: BrandColors.star.withValues(alpha: 0.8),
        ),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: BrandText.caption.copyWith(fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

class _Checking extends StatelessWidget {
  const _Checking();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(
        width: 48,
        height: 48,
        child: CircularProgressIndicator(
          strokeWidth: 3.5,
          color: BrandColors.cyan,
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      Semantics(
        liveRegion: true,
        child: const Text(
          'Looking for your backup…',
          textAlign: TextAlign.center,
          style: BrandText.headline,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Checking your private Math Strike folder in Google Drive.',
        textAlign: TextAlign.center,
        style: BrandText.body,
      ),
    ],
  );
}

class _Restoring extends StatelessWidget {
  const _Restoring({required this.backup, required this.progress});

  final BackupMetadata backup;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    return Column(
      children: [
        const Icon(
          Icons.cloud_download_rounded,
          size: 48,
          color: BrandColors.cyan,
        ),
        const SizedBox(height: AppSpacing.lg),
        const Text(
          'Restoring your progress',
          textAlign: TextAlign.center,
          style: BrandText.headline,
        ),
        const SizedBox(height: AppSpacing.lg),
        _BackupPreview(backup: backup),
        const SizedBox(height: AppSpacing.lg),
        Semantics(
          label: 'Restoring',
          value: '$percent%',
          child: ClipRRect(
            borderRadius: const BorderRadius.all(AppRadii.pill),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: progress),
              duration: context.motion(AppDurations.medium),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 10,
                color: BrandColors.cyan,
                backgroundColor: BrandColors.star.withValues(alpha: 0.12),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('$percent%', style: BrandText.caption),
      ],
    );
  }
}

/// Summary of the backup being restored.
class _BackupPreview extends StatelessWidget {
  const _BackupPreview({required this.backup});

  final BackupMetadata backup;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final local = backup.modifiedAt.toLocal();
    final saved =
        '${localizations.formatMediumDate(local)}, '
        '${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';
    final size = backup.sizeBytes < 1024
        ? '${backup.sizeBytes} B'
        : '${(backup.sizeBytes / 1024).toStringAsFixed(1)} KB';

    Widget row(IconData icon, String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 18, color: BrandColors.violet),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: BrandText.caption.copyWith(fontSize: 13.5)),
          const SizedBox(width: AppSpacing.md),
          // Flexible so long dates wrap instead of overflowing at large
          // text sizes.
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: BrandText.body.copyWith(
                color: BrandColors.star,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: BrandColors.star.withValues(alpha: 0.06),
        borderRadius: AppRadii.mdAll,
        border: Border.all(color: BrandColors.star.withValues(alpha: 0.12)),
      ),
      child: Column(
        children: [
          row(Icons.schedule_rounded, 'Last saved', saved),
          row(Icons.data_object_rounded, 'Size', size),
          if (backup.appVersion != null)
            row(Icons.info_outline_rounded, 'App version', backup.appVersion!),
        ],
      ),
    );
  }
}

class _Outcome extends StatelessWidget {
  const _Outcome({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.onContinue,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.4, end: 1),
        duration: context.motion(AppDurations.long),
        curve: Curves.elasticOut,
        builder: (context, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Icon(icon, size: 72, color: color),
      ),
      const SizedBox(height: AppSpacing.lg),
      Semantics(
        liveRegion: true,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: BrandText.headline,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(message, textAlign: TextAlign.center, style: BrandText.body),
      const SizedBox(height: AppSpacing.lg),
      TextButton(
        style: TextButton.styleFrom(foregroundColor: BrandColors.cyan),
        onPressed: onContinue,
        child: const Text('Continue'),
      ),
    ],
  );
}

class _Failed extends StatelessWidget {
  const _Failed({
    required this.failure,
    required this.duringRestore,
    required this.onRetry,
    required this.onSkip,
  });

  final Failure failure;
  final bool duringRestore;
  final VoidCallback onRetry;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Icon(
        failure is NetworkFailure
            ? Icons.cloud_off_rounded
            : Icons.error_outline_rounded,
        size: 56,
        color: BrandColors.magenta,
      ),
      const SizedBox(height: AppSpacing.lg),
      Semantics(
        liveRegion: true,
        child: Text(
          duringRestore
              ? "We couldn't restore your backup"
              : "We couldn't check for a backup",
          textAlign: TextAlign.center,
          style: BrandText.headline,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        describeFailure(
          failure,
          offline:
              "You're offline. Connect to the internet so we can check "
              'Google Drive for your saved progress.',
          fallback:
              'Google Drive is not available right now. Please try '
              'again in a moment.',
        ),
        textAlign: TextAlign.center,
        style: BrandText.body,
      ),
      const SizedBox(height: AppSpacing.lg),
      SizedBox(
        width: double.infinity,
        height: 52,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: BrandColors.violet,
            foregroundColor: BrandColors.midnight,
          ),
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Try again'),
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: BrandColors.star.withValues(alpha: 0.8),
        ),
        onPressed: onSkip,
        child: const Text('Continue without restoring'),
      ),
    ],
  );
}

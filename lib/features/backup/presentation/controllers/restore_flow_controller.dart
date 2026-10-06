import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../authentication/domain/entities/account_link.dart';
import '../../../authentication/presentation/controllers/account_controller.dart';
import '../../backup_providers.dart';
import '../../domain/entities/backup_metadata.dart';

part 'restore_flow_controller.freezed.dart';
part 'restore_flow_controller.g.dart';

/// State of the first-launch "check Drive → restore" step.
@freezed
sealed class RestoreFlowState with _$RestoreFlowState {
  /// Looking for a backup.
  const factory RestoreFlowState.checking() = RestoreChecking;

  /// Downloading and applying [backup].
  const factory RestoreFlowState.restoring({
    required BackupMetadata backup,
    required double progress,
  }) = RestoreInProgress;

  /// [backup] was restored.
  const factory RestoreFlowState.restored(BackupMetadata backup) =
      RestoreSucceeded;

  /// The player has no backup yet.
  const factory RestoreFlowState.noBackup() = NoBackupFound;

  /// Checking or restoring failed.
  const factory RestoreFlowState.failed({
    required Failure failure,

    /// True when a backup was found but could not be restored.
    required bool duringRestore,
  }) = RestoreFailed;
}

/// Runs the mandatory first-launch backup check:
/// backup found → restore automatically with progress; none → onboarding.
@riverpod
class RestoreFlowController extends _$RestoreFlowController {
  bool _running = false;

  @override
  RestoreFlowState build() => const RestoreFlowState.checking();

  /// Starts (or retries) the check. Concurrent calls are ignored.
  Future<void> start() async {
    if (_running) return;
    _running = true;
    try {
      await _run();
    } finally {
      _running = false;
    }
  }

  Future<void> _run() async {
    state = const RestoreFlowState.checking();
    final repository = ref.read(backupRepositoryProvider);

    final found = await repository.findLatestBackup();
    if (!ref.mounted) return;
    final BackupMetadata backup;
    switch (found) {
      case Err(:final failure):
        state = RestoreFlowState.failed(failure: failure, duringRestore: false);
        return;
      case Success(value: null):
        state = const RestoreFlowState.noBackup();
        return;
      case Success(value: final BackupMetadata latest):
        backup = latest;
    }

    state = RestoreFlowState.restoring(backup: backup, progress: 0);
    final restored = await repository.restore(
      backup,
      onProgress: (progress) {
        if (ref.mounted) {
          state = RestoreFlowState.restoring(
            backup: backup,
            progress: progress,
          );
        }
      },
    );
    if (!ref.mounted) return;
    if (restored case Err(:final failure)) {
      state = RestoreFlowState.failed(failure: failure, duringRestore: true);
      return;
    }
    // Reload every controller that caches local data.
    ref.read(localDataEpochProvider.notifier).bump();
    state = RestoreFlowState.restored(backup);
  }

  /// Leaves the step: to the app after a restore, otherwise to onboarding.
  /// Also used for "continue without restoring" after a failure.
  Future<Result<void>> finish() => ref
      .read(accountControllerProvider.notifier)
      .advanceTo(
        state is RestoreSucceeded
            ? AccountSetupStage.complete
            : AccountSetupStage.onboarding,
      );
}

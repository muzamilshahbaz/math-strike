import '../../../../core/errors/result.dart';
import '../entities/backup_metadata.dart';

/// Reports restore progress, 0.0–1.0.
typedef RestoreProgressCallback = void Function(double progress);

/// Cloud backups of the player's local data.
///
/// Phase 3 covers detection and restore; creating backups (automatic,
/// incremental, encrypted, with conflict handling) arrives in Phase 13.
abstract interface class BackupRepository {
  /// The most recent backup in the player's Drive app folder, or `null`.
  Future<Result<BackupMetadata?>> findLatestBackup();

  /// Downloads [backup] and replaces local game data with it. Device-local
  /// data (launch history, account link) is preserved. The local data is
  /// untouched unless the backup was downloaded and validated completely.
  Future<Result<void>> restore(
    BackupMetadata backup, {
    RestoreProgressCallback? onProgress,
  });
}

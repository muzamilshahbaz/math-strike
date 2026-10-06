import 'dart:typed_data';

import '../../domain/entities/backup_metadata.dart';

/// Name of the backup file inside the Drive app folder.
const String backupFileName = 'math_strike_backup.json';

/// Remote storage for backup files.
///
/// Implementations throw `NetworkException` when offline, `AuthException`
/// when the Google session is unusable and `StorageException` for other
/// remote failures.
abstract interface class BackupRemoteDataSource {
  /// Metadata of the newest backup, or `null` if there is none.
  Future<BackupMetadata?> findLatest();

  /// Downloads the backup [id], reporting progress 0.0–1.0 when the size is
  /// known.
  Future<Uint8List> download(
    String id, {
    void Function(double progress)? onProgress,
  });

  /// Uploads a backup file. Used by Phase 13 backups and the demo seed.
  Future<BackupMetadata> upload(
    Uint8List bytes, {
    required String appVersion,
    required int formatVersion,
  });
}

import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/local_database.dart';
import '../../domain/entities/backup_metadata.dart';
import '../../domain/repositories/backup_repository.dart';
import '../codec/backup_snapshot_codec.dart';
import '../datasources/backup_remote_data_source.dart';

/// [BackupRepository] over a remote store and the local database.
final class BackupRepositoryImpl implements BackupRepository {
  /// Creates the repository.
  const BackupRepositoryImpl({
    required this._remote,
    required this._database,
    required this._logger,
    this._codec = const BackupSnapshotCodec(),
  });

  final BackupRemoteDataSource _remote;
  final LocalDatabase _database;
  final AppLogger _logger;
  final BackupSnapshotCodec _codec;

  /// Share of the progress bar used by the download (the rest is applying).
  static const double _downloadShare = 0.85;

  @override
  Future<Result<BackupMetadata?>> findLatestBackup() =>
      Result.guard(_remote.findLatest);

  @override
  Future<Result<void>> restore(
    BackupMetadata backup, {
    RestoreProgressCallback? onProgress,
  }) => Result.guard(() async {
    onProgress?.call(0);
    final bytes = await _remote.download(
      backup.id,
      onProgress: (p) => onProgress?.call(p * _downloadShare),
    );
    // Fully decoded and validated before any local data is touched.
    final snapshot = _codec.decode(bytes);
    onProgress?.call(_downloadShare);
    await _database.restoreSnapshot(snapshot.boxes);
    onProgress?.call(1);
    _logger.info(
      'Restored backup from ${snapshot.createdAt.toIso8601String()} '
      '(app ${snapshot.appVersion}, ${bytes.length} bytes)',
    );
  });
}

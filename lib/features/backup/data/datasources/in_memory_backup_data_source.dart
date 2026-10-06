import 'dart:typed_data';

import '../../domain/entities/backup_metadata.dart';
import 'backup_remote_data_source.dart';

/// Non-persistent [BackupRemoteDataSource] used by demo mode and tests.
final class InMemoryBackupDataSource implements BackupRemoteDataSource {
  /// Creates an empty store. [latency] simulates network time per call.
  InMemoryBackupDataSource({this.latency = Duration.zero});

  /// Simulated network delay per call.
  final Duration latency;

  final Map<String, (BackupMetadata, Uint8List)> _files = {};
  int _nextId = 1;

  /// Fails the next calls with [error] while non-null (tests).
  Object? failWith;

  @override
  Future<BackupMetadata?> findLatest() async {
    await _simulate();
    if (_files.isEmpty) return null;
    return (_files.values.toList()
          ..sort((a, b) => b.$1.modifiedAt.compareTo(a.$1.modifiedAt)))
        .first
        .$1;
  }

  @override
  Future<Uint8List> download(
    String id, {
    void Function(double progress)? onProgress,
  }) async {
    await _simulate();
    final file = _files[id];
    if (file == null) throw StateError('No backup with id $id');
    for (final step in const [0.25, 0.5, 0.75, 1.0]) {
      await Future<void>.delayed(latency ~/ 4);
      onProgress?.call(step);
    }
    return file.$2;
  }

  @override
  Future<BackupMetadata> upload(
    Uint8List bytes, {
    required String appVersion,
    required int formatVersion,
  }) async {
    await _simulate();
    return seed(bytes, appVersion: appVersion, formatVersion: formatVersion);
  }

  /// Synchronously stores a backup (demo seed and test set-up).
  BackupMetadata seed(
    Uint8List bytes, {
    required String appVersion,
    required int formatVersion,
    DateTime? modifiedAt,
  }) {
    final metadata = BackupMetadata(
      id: 'backup-${_nextId++}',
      modifiedAt: modifiedAt ?? DateTime.now().toUtc(),
      sizeBytes: bytes.length,
      appVersion: appVersion,
      formatVersion: formatVersion,
    );
    _files[metadata.id] = (metadata, bytes);
    return metadata;
  }

  Future<void> _simulate() async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);
    final error = failWith;
    if (error != null) throw error;
  }
}

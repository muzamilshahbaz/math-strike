import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_metadata.freezed.dart';

/// Describes a backup stored in the player's Drive app folder, without
/// downloading it (used for detection and the restore preview).
@freezed
abstract class BackupMetadata with _$BackupMetadata {
  /// Creates metadata.
  const factory BackupMetadata({
    /// Remote file identifier.
    required String id,
    required DateTime modifiedAt,
    required int sizeBytes,

    /// Version of the app that wrote the backup, if recorded.
    String? appVersion,

    /// Snapshot format version, if recorded.
    int? formatVersion,
  }) = _BackupMetadata;
}

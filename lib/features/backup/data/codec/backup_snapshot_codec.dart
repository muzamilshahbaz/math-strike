import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/storage/local_database.dart';

part 'backup_snapshot_codec.freezed.dart';

/// A complete, self-describing copy of the backed-up local data.
@freezed
abstract class BackupSnapshot with _$BackupSnapshot {
  /// Creates a snapshot.
  const factory BackupSnapshot({
    required int formatVersion,
    required DateTime createdAt,
    required String appVersion,

    /// Box name → key → value (see [DatabaseSnapshot]).
    required DatabaseSnapshot boxes,
  }) = _BackupSnapshot;
}

/// Serialises [BackupSnapshot]s to and from backup file bytes.
///
/// Format v1 is UTF-8 JSON with a `format` marker and version. Phase 13
/// adds v2 (encrypted, incremental); [decode] rejects versions it does not
/// understand instead of guessing, so old apps never corrupt new backups.
class BackupSnapshotCodec {
  /// Creates the codec.
  const BackupSnapshotCodec();

  /// Marker identifying Math Strike backup files.
  static const String formatMarker = 'math-strike-backup';

  /// Newest format this build can read and write.
  static const int currentFormatVersion = 1;

  /// Encodes [snapshot].
  Uint8List encode(BackupSnapshot snapshot) => utf8.encode(
    jsonEncode({
      'format': formatMarker,
      'formatVersion': snapshot.formatVersion,
      'createdAt': snapshot.createdAt.toUtc().toIso8601String(),
      'appVersion': snapshot.appVersion,
      'boxes': snapshot.boxes,
    }),
  );

  /// Decodes and validates backup [bytes].
  ///
  /// Throws [DataFormatException] for anything that is not a complete,
  /// supported Math Strike backup.
  BackupSnapshot decode(List<int> bytes) {
    final Object? json;
    try {
      json = jsonDecode(utf8.decode(bytes));
    } on FormatException catch (e, st) {
      throw DataFormatException(
        'The backup file is damaged',
        cause: e,
        stackTrace: st,
      );
    }
    if (json is! Map<String, dynamic> || json['format'] != formatMarker) {
      throw const DataFormatException('This is not a Math Strike backup');
    }
    final version = json['formatVersion'];
    if (version is! int || version < 1) {
      throw const DataFormatException('The backup file is damaged');
    }
    if (version > currentFormatVersion) {
      throw const DataFormatException(
        'This backup was made by a newer version of Math Strike. '
        'Please update the app to restore it.',
      );
    }
    try {
      return BackupSnapshot(
        formatVersion: version,
        createdAt: DateTime.parse(json['createdAt'] as String),
        appVersion: json['appVersion'] as String,
        boxes: {
          for (final MapEntry(:key, :value)
              in (json['boxes'] as Map<String, dynamic>).entries)
            // Copies and type-checks every value (throws if not a String).
            key: Map<String, String>.from(value as Map<String, dynamic>),
        },
      );
    } on Object catch (e, st) {
      throw DataFormatException(
        'The backup file is damaged',
        cause: e,
        stackTrace: st,
      );
    }
  }
}

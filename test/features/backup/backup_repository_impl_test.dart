import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/errors/failure.dart';
import 'package:math_strike/core/services/logging/app_logger.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/backup/data/codec/backup_snapshot_codec.dart';
import 'package:math_strike/features/backup/data/datasources/in_memory_backup_data_source.dart';
import 'package:math_strike/features/backup/data/repositories/backup_repository_impl.dart';

void main() {
  late InMemoryBackupDataSource drive;
  late InMemoryLocalDatabase db;
  late BackupRepositoryImpl repository;

  setUp(() async {
    drive = InMemoryBackupDataSource();
    db = InMemoryLocalDatabase();
    await db.store(StorageBox.settings).write('theme', 'space');
    repository = BackupRepositoryImpl(
      remote: drive,
      database: db,
      logger: const SilentAppLogger(),
    );
  });

  test('finds nothing when Drive is empty', () async {
    expect((await repository.findLatestBackup()).valueOrNull, isNull);
  });

  test('finds the newest backup', () async {
    drive
      ..seed(
        Uint8List.fromList([1]),
        appVersion: '1.0',
        formatVersion: 1,
        modifiedAt: DateTime.utc(2026, 1, 1),
      )
      ..seed(
        Uint8List.fromList([2]),
        appVersion: '1.1',
        formatVersion: 1,
        modifiedAt: DateTime.utc(2026, 2, 1),
      );

    final latest = (await repository.findLatestBackup()).valueOrNull!;

    expect(latest.appVersion, '1.1');
  });

  test('restore applies the snapshot with increasing progress', () async {
    final backup = drive.seed(
      const BackupSnapshotCodec().encode(
        BackupSnapshot(
          formatVersion: 1,
          createdAt: DateTime.utc(2026),
          appVersion: '1.0.0',
          boxes: {
            'settings': {'theme': 'neon'},
          },
        ),
      ),
      appVersion: '1.0.0',
      formatVersion: 1,
    );
    final progress = <double>[];

    final result = await repository.restore(backup, onProgress: progress.add);

    expect(result.isSuccess, isTrue);
    expect(db.store(StorageBox.settings).read('theme'), 'neon');
    expect(progress.first, 0);
    expect(progress.last, 1);
    for (var i = 1; i < progress.length; i++) {
      expect(progress[i], greaterThanOrEqualTo(progress[i - 1]));
    }
  });

  test('a damaged backup fails and leaves local data untouched', () async {
    final backup = drive.seed(
      utf8.encode('{"format":"something-else"}'),
      appVersion: '1.0.0',
      formatVersion: 1,
    );

    final result = await repository.restore(backup);

    expect(result.failureOrNull, isA<DataFormatFailure>());
    expect(db.store(StorageBox.settings).read('theme'), 'space');
  });

  test('offline errors surface as network failures', () async {
    drive.failWith = const NetworkException('offline');

    expect(
      (await repository.findLatestBackup()).failureOrNull,
      isA<NetworkFailure>(),
    );
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/features/backup/data/codec/backup_snapshot_codec.dart';

void main() {
  const codec = BackupSnapshotCodec();
  final snapshot = BackupSnapshot(
    formatVersion: 1,
    createdAt: DateTime.utc(2026, 5, 4, 3, 2, 1),
    appVersion: '1.2.3',
    boxes: {
      'settings': {'appearance': '{"themeMode":"dark"}'},
      'progress': <String, String>{},
    },
  );

  test('round-trips a snapshot', () {
    expect(codec.decode(codec.encode(snapshot)), snapshot);
  });

  void expectRejected(Object json, String messageFragment) {
    expect(
      () => codec.decode(utf8.encode(jsonEncode(json))),
      throwsA(
        isA<DataFormatException>().having(
          (e) => e.message,
          'message',
          contains(messageFragment),
        ),
      ),
    );
  }

  test('rejects files that are not Math Strike backups', () {
    expectRejected({'hello': 'world'}, 'not a Math Strike backup');
    expect(
      () => codec.decode(utf8.encode('not json at all')),
      throwsA(isA<DataFormatException>()),
    );
  });

  test('refuses backups from a newer format instead of guessing', () {
    expectRejected({
      'format': BackupSnapshotCodec.formatMarker,
      'formatVersion': BackupSnapshotCodec.currentFormatVersion + 1,
    }, 'newer version');
  });

  test('rejects damaged content', () {
    expectRejected({
      'format': BackupSnapshotCodec.formatMarker,
      'formatVersion': 1,
      'createdAt': '2026-01-01T00:00:00Z',
      'appVersion': '1.0.0',
      'boxes': {
        'settings': {'appearance': 42}, // values must be strings
      },
    }, 'damaged');
  });
}

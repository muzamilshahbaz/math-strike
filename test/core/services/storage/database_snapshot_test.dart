import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/local_database.dart';

void main() {
  late InMemoryLocalDatabase db;

  setUp(() async {
    db = InMemoryLocalDatabase();
    await db.store(StorageBox.settings).write('theme', 'dark');
    await db.store(StorageBox.device).write('account', 'linked');
  });

  test('export contains backed-up boxes only', () {
    final snapshot = db.exportSnapshot();

    expect(snapshot, {
      'settings': {'theme': 'dark'},
      'profile': <String, String>{},
      'rewards': <String, String>{},
      'statistics': <String, String>{},
    });
    expect(snapshot.containsKey(StorageBox.device.boxName), isFalse);
  });

  test('restore replaces backed-up data and preserves device data', () async {
    await db.store(StorageBox.settings).write('stale', 'remove me');

    await db.restoreSnapshot({
      'settings': {'theme': 'neon'},
      'unknown_box_from_newer_app': {'x': 'y'},
      'device': {'account': 'hijacked'},
    });

    final settings = db.store(StorageBox.settings);
    expect(settings.read('theme'), 'neon');
    expect(settings.read('stale'), isNull);
    expect(db.store(StorageBox.device).read('account'), 'linked');
  });
}

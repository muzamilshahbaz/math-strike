import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';

void main() {
  group('JsonKeyValueStore', () {
    test('round-trips a JSON object', () async {
      final store = InMemoryKeyValueStore();
      await store.writeJson('k', {'a': 1, 'b': 'two'});
      expect(store.readJson('k'), {'a': 1, 'b': 'two'});
    });

    test('returns null for a missing key', () {
      expect(InMemoryKeyValueStore().readJson('missing'), isNull);
    });

    test('throws DataFormatException for invalid JSON', () {
      final store = InMemoryKeyValueStore({'k': '{not json'});
      expect(() => store.readJson('k'), throwsA(isA<DataFormatException>()));
    });

    test('throws DataFormatException when the value is not an object', () {
      final store = InMemoryKeyValueStore({'k': '[1,2]'});
      expect(() => store.readJson('k'), throwsA(isA<DataFormatException>()));
    });
  });

  group('InMemoryLocalDatabase', () {
    test('wipe clears every box', () async {
      final db = InMemoryLocalDatabase();
      await db.store(StorageBox.settings).write('k', 'v');
      await db.wipe();
      expect(db.store(StorageBox.settings).keys, isEmpty);
    });
  });
}

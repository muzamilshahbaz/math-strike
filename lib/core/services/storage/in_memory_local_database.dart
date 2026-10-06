import 'key_value_store.dart';
import 'local_database.dart';

/// Non-persistent [LocalDatabase] used by tests and previews.
final class InMemoryLocalDatabase
    with SnapshotSupport
    implements LocalDatabase {
  /// Creates an empty in-memory database.
  InMemoryLocalDatabase();

  final Map<StorageBox, InMemoryKeyValueStore> _stores = {
    for (final box in StorageBox.values) box: InMemoryKeyValueStore(),
  };

  @override
  Future<void> init() async {}

  @override
  KeyValueStore store(StorageBox box) => _stores[box]!;

  @override
  Future<void> wipe() async {
    for (final store in _stores.values) {
      await store.clear();
    }
  }

  @override
  Future<void> close() async {}
}

/// Map-backed [KeyValueStore].
final class InMemoryKeyValueStore implements KeyValueStore {
  /// Creates a store, optionally pre-populated with [initial] entries.
  InMemoryKeyValueStore([Map<String, String>? initial]) : _data = {...?initial};

  final Map<String, String> _data;

  @override
  String? read(String key) => _data[key];

  @override
  Future<void> write(String key, String value) async => _data[key] = value;

  @override
  Future<void> delete(String key) async => _data.remove(key);

  @override
  Future<void> clear() async => _data.clear();

  @override
  Iterable<String> get keys => _data.keys;
}

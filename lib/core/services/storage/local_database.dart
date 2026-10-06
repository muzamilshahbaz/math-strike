import 'key_value_store.dart';

/// Logical partitions ("boxes") of the local database.
///
/// Add a value here when a feature needs its own partition; it is opened
/// automatically at start-up. Box names are persisted — never rename one
/// without a migration.
enum StorageBox {
  /// User preferences: appearance, audio, accessibility, language.
  settings('settings');

  const StorageBox(this.boxName);

  /// On-disk name of the box.
  final String boxName;
}

/// The app's offline-first local database.
///
/// Owns the lifecycle (open/close/wipe) of every [StorageBox] and hands out
/// a [KeyValueStore] per box. All game data lives here; the network is only
/// a backup target.
abstract interface class LocalDatabase {
  /// Opens every [StorageBox]. Must complete before [store] is called.
  Future<void> init();

  /// The store backing [box].
  KeyValueStore store(StorageBox box);

  /// Deletes all local data (used by "Reset progress" and restore).
  Future<void> wipe();

  /// Flushes and closes all boxes.
  Future<void> close();
}

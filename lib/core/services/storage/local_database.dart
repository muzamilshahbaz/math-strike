import 'key_value_store.dart';

/// Logical partitions ("boxes") of the local database.
///
/// Add a value here when a feature needs its own partition; it is opened
/// automatically at start-up. Box names are persisted — never rename one
/// without a migration.
enum StorageBox {
  /// User preferences: appearance, audio, accessibility, language.
  settings('settings'),

  /// The player profile (name, avatar, age group, difficulty).
  profile('profile'),

  /// Facts about *this installation* (launch history, linked account).
  /// Never included in backups and preserved across restores.
  device('device', backedUp: false);

  const StorageBox(this.boxName, {this.backedUp = true});

  /// On-disk name of the box.
  final String boxName;

  /// Whether the box is part of backup snapshots.
  final bool backedUp;

  /// Boxes included in backups.
  static Iterable<StorageBox> get backedUpBoxes =>
      values.where((box) => box.backedUp);
}

/// Raw contents of every backed-up box: box name → key → value.
typedef DatabaseSnapshot = Map<String, Map<String, String>>;

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

  /// Copies every backed-up box (see [StorageBox.backedUp]).
  DatabaseSnapshot exportSnapshot();

  /// Replaces every backed-up box with the contents of [snapshot].
  /// Boxes absent from the snapshot are cleared; unknown box names are
  /// ignored; device-local boxes are never touched.
  Future<void> restoreSnapshot(DatabaseSnapshot snapshot);

  /// Deletes all local data (used by "Reset progress" and restore).
  Future<void> wipe();

  /// Flushes and closes all boxes.
  Future<void> close();
}

/// Shared implementation of snapshot export/restore over [KeyValueStore]s.
mixin SnapshotSupport implements LocalDatabase {
  @override
  DatabaseSnapshot exportSnapshot() => {
    for (final box in StorageBox.backedUpBoxes)
      box.boxName: {
        for (final key in store(box).keys) key: store(box).read(key)!,
      },
  };

  @override
  Future<void> restoreSnapshot(DatabaseSnapshot snapshot) async {
    for (final box in StorageBox.backedUpBoxes) {
      final target = store(box);
      await target.clear();
      for (final MapEntry(:key, :value)
          in (snapshot[box.boxName] ?? const <String, String>{}).entries) {
        await target.write(key, value);
      }
    }
  }
}

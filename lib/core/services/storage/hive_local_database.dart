import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import '../../constants/app_constants.dart';
import '../../errors/app_exception.dart';
import '../logging/app_logger.dart';
import 'encryption_key_provider.dart';
import 'key_value_store.dart';
import 'local_database.dart';

/// [LocalDatabase] implemented with Hive CE, AES-256 encrypted at rest.
final class HiveLocalDatabase implements LocalDatabase {
  /// Creates the database. Call [init] before use.
  HiveLocalDatabase({required this._keyProvider, required this._logger});

  final EncryptionKeyProvider _keyProvider;
  final AppLogger _logger;
  final Map<StorageBox, Box<String>> _boxes = {};

  @override
  Future<void> init() async {
    // Fully open already: nothing to do. A partially opened database (from a
    // failed earlier attempt) is reopened from scratch.
    if (_boxes.length == StorageBox.values.length) return;
    _boxes.clear();
    try {
      await Hive.initFlutter(AppConstants.databaseDirectory);
      final cipher = HiveAesCipher(await _keyProvider.obtainKey());
      for (final box in StorageBox.values) {
        _boxes[box] = await _openBox(box, cipher);
      }
      _logger.info('Local database ready (${_boxes.length} boxes)');
    } on AppException {
      _boxes.clear();
      rethrow;
    } on Object catch (e, st) {
      _boxes.clear();
      throw StorageException(
        'Failed to open local database',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Opens [box]; if it cannot be decrypted (e.g. the keystore was wiped by
  /// the OS) the unreadable box is discarded so the app can still start.
  /// The user can then recover their data from a Drive backup.
  Future<Box<String>> _openBox(StorageBox box, HiveCipher cipher) async {
    try {
      return await Hive.openBox<String>(box.boxName, encryptionCipher: cipher);
    } on Object catch (e, st) {
      _logger.warning(
        'Box "${box.boxName}" unreadable; recreating it',
        error: e,
        stackTrace: st,
      );
      await Hive.deleteBoxFromDisk(box.boxName);
      return Hive.openBox<String>(box.boxName, encryptionCipher: cipher);
    }
  }

  @override
  KeyValueStore store(StorageBox box) {
    final opened = _boxes[box];
    if (opened == null) {
      throw StateError('LocalDatabase.init() must complete before use');
    }
    return _HiveKeyValueStore(opened);
  }

  @override
  Future<void> wipe() async {
    for (final box in _boxes.values) {
      await box.clear();
    }
    _logger.info('Local database wiped');
  }

  @override
  Future<void> close() async {
    await Hive.close();
    _boxes.clear();
  }
}

/// [KeyValueStore] adapter over a Hive [Box].
final class _HiveKeyValueStore implements KeyValueStore {
  const _HiveKeyValueStore(this._box);

  final Box<String> _box;

  @override
  String? read(String key) => _box.get(key);

  @override
  Future<void> write(String key, String value) =>
      _guard(() => _box.put(key, value), 'write "$key"');

  @override
  Future<void> delete(String key) =>
      _guard(() => _box.delete(key), 'delete "$key"');

  @override
  Future<void> clear() => _guard(_box.clear, 'clear');

  @override
  Iterable<String> get keys => _box.keys.cast<String>();

  Future<void> _guard(Future<Object?> Function() op, String what) async {
    try {
      await op();
    } on Object catch (e, st) {
      throw StorageException(
        'Failed to $what in ${_box.name}',
        cause: e,
        stackTrace: st,
      );
    }
  }
}

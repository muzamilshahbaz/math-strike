import 'dart:convert';

import '../../errors/app_exception.dart';

/// A minimal string key/value store — the storage primitive every
/// repository builds on.
///
/// Values are strings (usually JSON). Keeping the primitive this small means
/// the whole local state can be snapshotted into a single encrypted backup
/// file in Phase 13 without per-type adapters.
abstract interface class KeyValueStore {
  /// Returns the value for [key], or `null` if absent.
  String? read(String key);

  /// Stores [value] under [key], replacing any existing value.
  Future<void> write(String key, String value);

  /// Removes [key]. No-op if absent.
  Future<void> delete(String key);

  /// Removes every entry.
  Future<void> clear();

  /// All keys currently stored.
  Iterable<String> get keys;
}

/// JSON helpers layered on top of [KeyValueStore].
extension JsonKeyValueStore on KeyValueStore {
  /// Reads and decodes a JSON object stored under [key].
  ///
  /// Returns `null` if the key is absent. Throws [DataFormatException] if the
  /// stored value is not a JSON object.
  Map<String, dynamic>? readJson(String key) {
    final raw = read(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      throw DataFormatException('Value for "$key" is not a JSON object');
    } on FormatException catch (e, st) {
      throw DataFormatException(
        'Value for "$key" is not valid JSON',
        cause: e,
        stackTrace: st,
      );
    }
  }

  /// Encodes [json] and stores it under [key].
  Future<void> writeJson(String key, Map<String, dynamic> json) =>
      write(key, jsonEncode(json));
}

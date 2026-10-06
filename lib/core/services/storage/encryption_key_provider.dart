import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce/hive_ce.dart';

import '../../constants/app_constants.dart';
import '../../errors/app_exception.dart';

/// Supplies the 256-bit key used to encrypt the local database at rest.
abstract interface class EncryptionKeyProvider {
  /// Returns the existing key, creating and persisting one on first launch.
  Future<List<int>> obtainKey();
}

/// Keeps the database key in the platform keystore (Android Keystore,
/// iOS/macOS Keychain, Windows Credential Locker, libsecret on Linux,
/// WebCrypto-wrapped storage on the web).
final class SecureStorageEncryptionKeyProvider
    implements EncryptionKeyProvider {
  /// Creates a provider backed by [storage].
  const SecureStorageEncryptionKeyProvider(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<List<int>> obtainKey() async {
    try {
      final existing = await _storage.read(key: AppConstants.databaseKeyName);
      if (existing != null) return base64Url.decode(existing);

      final key = Hive.generateSecureKey();
      await _storage.write(
        key: AppConstants.databaseKeyName,
        value: base64UrlEncode(key),
      );
      return key;
    } on Object catch (e, st) {
      throw StorageException(
        'Unable to access secure key storage',
        cause: e,
        stackTrace: st,
      );
    }
  }
}

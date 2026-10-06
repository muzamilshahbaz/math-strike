import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/account_link.dart';
import '../../domain/repositories/account_link_repository.dart';

/// [AccountLinkRepository] stored in the device-local `device` box.
final class AccountLinkRepositoryImpl implements AccountLinkRepository {
  /// Creates the repository.
  const AccountLinkRepositoryImpl({
    required this._store,
    required this._logger,
  });

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  AccountLink? load() {
    try {
      final json = _store.readJson(DeviceKeys.accountLink);
      return json == null ? null : AccountLink.fromJson(json);
    } on Object catch (e, st) {
      // Unreadable: treat as unlinked; the player simply signs in again.
      _logger.warning('Account link unreadable', error: e, stackTrace: st);
      return null;
    }
  }

  @override
  Future<Result<void>> save(AccountLink link) => Result.guard(
    () => _store.writeJson(DeviceKeys.accountLink, link.toJson()),
  );

  @override
  Future<Result<void>> clear() =>
      Result.guard(() => _store.delete(DeviceKeys.accountLink));
}

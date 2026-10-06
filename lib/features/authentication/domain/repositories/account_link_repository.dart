import '../../../../core/errors/result.dart';
import '../entities/account_link.dart';

/// Persists which Google account this installation is linked to.
abstract interface class AccountLinkRepository {
  /// The saved link, or `null` if the device was never linked (or the
  /// record is unreadable).
  AccountLink? load();

  /// Saves [link].
  Future<Result<void>> save(AccountLink link);

  /// Removes the link (sign-out / reset).
  Future<Result<void>> clear();
}

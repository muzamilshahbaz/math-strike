import 'package:http/http.dart' as http;

import '../../../../core/errors/result.dart';
import '../entities/google_account.dart';

/// Google authentication for the whole app.
abstract interface class AuthRepository {
  /// Prepares the platform SDK. Call early (the splash does) so that
  /// interactive sign-in can start immediately from a button press, which
  /// browsers require for pop-ups.
  Future<Result<void>> prepare();

  /// Interactive sign-in: lets the user pick an account and grant access to
  /// the app's private Drive folder.
  ///
  /// Fails with `AuthCancelledFailure` when the user dismisses the prompt.
  Future<Result<GoogleAccount>> signIn();

  /// Silently restores a previous session, if possible without UI.
  Future<Result<GoogleAccount?>> restoreSession();

  /// Signs out of Google on this device.
  Future<Result<void>> signOut();
}

/// Supplies HTTP clients authorised to call Google APIs (Drive) as the
/// signed-in user. Implemented by the authentication feature and consumed
/// by the backup feature.
abstract interface class GoogleApiAuthorizer {
  /// A client authorised for the app's Drive folder, obtained without UI.
  ///
  /// Throws `AuthException` if the session has expired and the user has to
  /// sign in again. Callers must `close()` the client when done.
  Future<http.Client> authorizedClient();
}

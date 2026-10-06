import 'package:http/http.dart' as http;

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/google_account.dart';
import '../../domain/repositories/auth_repository.dart';
import '../gateways/google_auth_gateway.dart';

/// [AuthRepository] and [GoogleApiAuthorizer] over a platform
/// [GoogleAuthGateway].
final class AuthRepositoryImpl implements AuthRepository, GoogleApiAuthorizer {
  /// Creates the repository.
  const AuthRepositoryImpl(this._gateway);

  final GoogleAuthGateway _gateway;

  @override
  Future<Result<void>> prepare() => Result.guard(_gateway.initialize);

  @override
  Future<Result<GoogleAccount>> signIn() => Result.guard(_gateway.signIn);

  @override
  Future<Result<GoogleAccount?>> restoreSession() =>
      Result.guard(_gateway.restoreSession);

  @override
  Future<Result<void>> signOut() => Result.guard(_gateway.signOut);

  @override
  Future<http.Client> authorizedClient() async {
    final client =
        await _gateway.authorizedClient() ??
        // The plugin may have dropped the session (e.g. app restarted).
        await _gateway.restoreSession().then(
          (account) => account == null ? null : _gateway.authorizedClient(),
        );
    if (client == null) {
      throw const AuthException(
        'Your Google session has expired. Please sign in again.',
      );
    }
    return client;
  }
}

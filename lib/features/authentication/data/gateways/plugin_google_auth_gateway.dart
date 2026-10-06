import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/google_config.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/google_account.dart';
import 'google_auth_gateway.dart';

/// [GoogleAuthGateway] backed by the official `google_sign_in` plugin
/// (Android, iOS, macOS and web).
///
/// * Android/iOS/macOS: `authenticate()` shows the account picker, then
///   Drive access is requested separately (Google's recommended split).
/// * Web: `authenticate()` is unsupported, so a single authorisation pop-up
///   (which includes the account chooser) grants identity + Drive scopes,
///   and the identity is read from the userinfo endpoint. Must be invoked
///   from a user gesture.
final class PluginGoogleAuthGateway implements GoogleAuthGateway {
  /// Creates the gateway.
  PluginGoogleAuthGateway({
    required this._config,
    required this._platform,
    required this._isWeb,
  });

  final GoogleConfig _config;
  final TargetPlatform _platform;
  final bool _isWeb;
  final GoogleSignIn _sdk = GoogleSignIn.instance;

  Future<void>? _initialization;
  GoogleSignInAccount? _account;

  List<String> get _scopes =>
      _isWeb ? [...identityScopes, driveAppDataScope] : [driveAppDataScope];

  @override
  Future<void> initialize() => _initialization ??= _sdk
      .initialize(
        clientId: _isWeb
            ? _config.webClientId
            : switch (_platform) {
                TargetPlatform.iOS ||
                TargetPlatform.macOS => _config.appleClientId,
                _ => null,
              },
        serverClientId: !_isWeb && _platform == TargetPlatform.android
            ? _config.serverClientId
            : null,
      )
      .catchError((Object e) {
        _initialization = null; // allow a retry
        throw _map(e);
      });

  @override
  Future<GoogleAccount> signIn() async {
    await initialize();
    try {
      if (_sdk.supportsAuthenticate()) {
        final account = await _sdk.authenticate(scopeHint: _scopes);
        await account.authorizationClient.authorizeScopes(_scopes);
        _account = account;
        return _toDomain(account);
      }
      final authorization = await _sdk.authorizationClient.authorizeScopes(
        _scopes,
      );
      return await _identify(authorization.accessToken);
    } on Object catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<GoogleAccount?> restoreSession() async {
    await initialize();
    try {
      if (_sdk.supportsAuthenticate()) {
        final attempt = _sdk.attemptLightweightAuthentication();
        final account = attempt == null ? null : await attempt;
        _account = account;
        return account == null ? null : _toDomain(account);
      }
      final authorization = await _sdk.authorizationClient
          .authorizationForScopes(_scopes);
      return authorization == null
          ? null
          : await _identify(authorization.accessToken);
    } on Object catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<http.Client?> authorizedClient() async {
    await initialize();
    try {
      final client = _account?.authorizationClient ?? _sdk.authorizationClient;
      final authorization = await client.authorizationForScopes(_scopes);
      return authorization == null
          ? null
          : bearerTokenClient(authorization.accessToken, _scopes);
    } on Object catch (e) {
      throw _map(e);
    }
  }

  @override
  Future<void> signOut() async {
    await initialize();
    _account = null;
    await _sdk.signOut();
  }

  Future<GoogleAccount> _identify(String accessToken) async {
    final client = bearerTokenClient(accessToken, _scopes);
    try {
      return await fetchGoogleUserInfo(client);
    } finally {
      client.close();
    }
  }

  static GoogleAccount _toDomain(GoogleSignInAccount account) => GoogleAccount(
    id: account.id,
    email: account.email,
    displayName: account.displayName,
    photoUrl: account.photoUrl,
  );

  static Object _map(Object error) => switch (error) {
    AppException() => error,
    GoogleSignInException(code: GoogleSignInExceptionCode.canceled) ||
    GoogleSignInException(
      code: GoogleSignInExceptionCode.interrupted,
    ) => const AuthCancelledException(),
    GoogleSignInException(
      code: GoogleSignInExceptionCode.clientConfigurationError ||
          GoogleSignInExceptionCode.providerConfigurationError,
      :final description,
    ) =>
      AuthException('Google Sign-In is misconfigured: $description'),
    GoogleSignInException(:final description) => AuthException(
      description ?? 'Google Sign-In failed',
      cause: error,
    ),
    http.ClientException() => NetworkException(
      'Could not reach Google',
      cause: error,
    ),
    _ => AuthException('Google Sign-In failed', cause: error),
  };
}

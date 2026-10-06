import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/google_config.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../domain/entities/google_account.dart';
import 'google_auth_gateway.dart';

/// Creates the Windows/Linux gateway (see [DesktopGoogleAuthGateway]).
GoogleAuthGateway createDesktopGoogleAuthGateway({
  required GoogleConfig config,
  required AppLogger logger,
}) => DesktopGoogleAuthGateway(
  clientId: ClientId(config.desktopClientId, config.desktopClientSecret),
  storage: const FlutterSecureStorage(),
  logger: logger,
);

/// [GoogleAuthGateway] for Windows and Linux, where `google_sign_in` is not
/// available.
///
/// Uses Google's recommended flow for installed apps: the system browser
/// opens the consent page and redirects to a temporary loopback server.
/// The resulting refresh token is kept in the OS keystore, so later
/// launches restore the session silently — and offline.
final class DesktopGoogleAuthGateway implements GoogleAuthGateway {
  /// Creates the gateway.
  DesktopGoogleAuthGateway({
    required this._clientId,
    required this._storage,
    required this._logger,
    Future<bool> Function(Uri url)? openBrowser,
  }) : _openBrowser = openBrowser ?? _launchExternal;

  static const _credentialsKey = 'math_strike.google.credentials.v1';
  static const _accountKey = 'math_strike.google.account.v1';
  static const _consentTimeout = Duration(minutes: 5);
  static const _scopes = [...identityScopes, driveAppDataScope];

  final ClientId _clientId;
  final FlutterSecureStorage _storage;
  final AppLogger _logger;
  final Future<bool> Function(Uri url) _openBrowser;

  AccessCredentials? _credentials;
  GoogleAccount? _account;

  static Future<bool> _launchExternal(Uri url) =>
      launchUrl(url, mode: LaunchMode.externalApplication);

  @override
  Future<void> initialize() async {}

  @override
  Future<GoogleAccount> signIn() async {
    final base = http.Client();
    try {
      final credentials =
          await obtainAccessCredentialsViaUserConsent(
            _clientId,
            _scopes,
            base,
            (url) => unawaited(_openBrowser(Uri.parse(url))),
          ).timeout(
            _consentTimeout,
            onTimeout: () => throw const AuthCancelledException(
              'Sign-in timed out. Please try again.',
            ),
          );
      final account = await fetchGoogleUserInfo(
        authenticatedClient(base, credentials),
      );
      await _persist(credentials, account);
      return account;
    } on AppException {
      rethrow;
    } on UserConsentException {
      throw const AuthCancelledException();
    } on SocketException catch (e, st) {
      throw NetworkException(
        'Could not reach Google',
        cause: e,
        stackTrace: st,
      );
    } on Object catch (e, st) {
      throw AuthException('Google Sign-In failed', cause: e, stackTrace: st);
    } finally {
      base.close();
    }
  }

  @override
  Future<GoogleAccount?> restoreSession() async {
    if (_account != null) return _account;
    try {
      final credentials = await _storage.read(key: _credentialsKey);
      final account = await _storage.read(key: _accountKey);
      if (credentials == null || account == null) return null;
      _credentials = AccessCredentials.fromJson(
        jsonDecode(credentials) as Map<String, dynamic>,
      );
      return _account = GoogleAccount.fromJson(
        jsonDecode(account) as Map<String, dynamic>,
      );
    } on Object catch (e, st) {
      _logger.warning(
        'Stored Google session unreadable',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  @override
  Future<http.Client?> authorizedClient() async {
    if (_credentials == null) await restoreSession();
    final credentials = _credentials;
    if (credentials == null) return null;
    final client = autoRefreshingClient(_clientId, credentials, http.Client());
    // Keep the refreshed access token so the next launch can reuse it.
    client.credentialUpdates.listen((updated) {
      _credentials = updated;
      final account = _account;
      if (account != null) unawaited(_persist(updated, account));
    });
    return client;
  }

  @override
  Future<void> signOut() async {
    _credentials = null;
    _account = null;
    await _storage.delete(key: _credentialsKey);
    await _storage.delete(key: _accountKey);
  }

  Future<void> _persist(
    AccessCredentials credentials,
    GoogleAccount account,
  ) async {
    _credentials = credentials;
    _account = account;
    await _storage.write(
      key: _credentialsKey,
      value: jsonEncode(credentials.toJson()),
    );
    await _storage.write(key: _accountKey, value: jsonEncode(account.toJson()));
  }
}

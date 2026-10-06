import 'dart:convert';

import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/google_account.dart';

/// OAuth scope for the app's private, hidden Drive folder. The app can
/// never see the user's other Drive files.
const String driveAppDataScope =
    'https://www.googleapis.com/auth/drive.appdata';

/// Scopes needed to identify the user where the platform SDK does not do
/// it for us (web, desktop).
const List<String> identityScopes = ['openid', 'email', 'profile'];

/// Platform-specific Google sign-in mechanics.
///
/// Implementations throw [AuthCancelledException] when the user dismisses
/// a prompt, [NetworkException] when offline and [AuthException] otherwise.
abstract interface class GoogleAuthGateway {
  /// One-time SDK initialisation. Safe to call repeatedly.
  Future<void> initialize();

  /// Interactive sign-in including consent for [driveAppDataScope].
  Future<GoogleAccount> signIn();

  /// Restores a previous session without UI, or returns `null`.
  Future<GoogleAccount?> restoreSession();

  /// A client authorised for [driveAppDataScope], obtained without UI, or
  /// `null` if the user must interact first.
  Future<http.Client?> authorizedClient();

  /// Ends the session on this device.
  Future<void> signOut();
}

/// Gateway used when no credentials are configured in a production build:
/// every operation fails with a clear configuration error.
final class UnavailableGoogleAuthGateway implements GoogleAuthGateway {
  /// Creates the gateway.
  const UnavailableGoogleAuthGateway();

  static const _error = AuthException(
    'Google Sign-In is not configured for this build.',
  );

  @override
  Future<void> initialize() async {}

  @override
  Future<GoogleAccount> signIn() => Future.error(_error);

  @override
  Future<GoogleAccount?> restoreSession() async => null;

  @override
  Future<http.Client?> authorizedClient() async => null;

  @override
  Future<void> signOut() async {}
}

/// Wraps an OAuth [accessToken] in an HTTP client that sends it as a
/// bearer token.
http.Client bearerTokenClient(String accessToken, List<String> scopes) =>
    authenticatedClient(
      http.Client(),
      AccessCredentials(
        // The platform SDK owns refreshing; the expiry is only nominal.
        AccessToken(
          'Bearer',
          accessToken,
          DateTime.now().toUtc().add(const Duration(minutes: 55)),
        ),
        null,
        scopes,
      ),
      closeUnderlyingClient: true,
    );

/// Reads the signed-in user's identity from Google's OpenID userinfo
/// endpoint using an authorised [client].
Future<GoogleAccount> fetchGoogleUserInfo(http.Client client) async {
  final http.Response response;
  try {
    response = await client.get(
      Uri.parse('https://openidconnect.googleapis.com/v1/userinfo'),
    );
  } on http.ClientException catch (e, st) {
    throw NetworkException('Could not reach Google', cause: e, stackTrace: st);
  }
  if (response.statusCode != 200) {
    throw AuthException(
      'Google rejected the sign-in (HTTP ${response.statusCode})',
    );
  }
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final id = json['sub'] as String?;
  final email = json['email'] as String?;
  if (id == null || email == null) {
    throw const AuthException('Google did not return the account e-mail');
  }
  return GoogleAccount(
    id: id,
    email: email,
    displayName: json['name'] as String?,
    photoUrl: json['picture'] as String?,
  );
}

import 'package:http/http.dart' as http;
import 'package:math_strike/features/authentication/data/gateways/google_auth_gateway.dart';
import 'package:math_strike/features/authentication/domain/entities/google_account.dart';

/// Scriptable [GoogleAuthGateway] for tests.
class FakeGoogleAuthGateway implements GoogleAuthGateway {
  /// Creates the fake. By default every sign-in succeeds as
  /// [defaultAccount] and sessions restore.
  FakeGoogleAuthGateway({
    this.account = defaultAccount,
    this.signInError,
    this.restoreError,
  });

  /// The account returned by successful sign-ins.
  static const GoogleAccount defaultAccount = GoogleAccount(
    id: 'user-1',
    email: 'player@example.com',
    displayName: 'Test Player',
  );

  /// Account returned by [signIn] / [restoreSession].
  GoogleAccount account;

  /// When set, [signIn] throws it (e.g. `AuthCancelledException()`).
  Object? signInError;

  /// When set, [restoreSession] throws it (e.g. a `NetworkException`).
  Object? restoreError;

  /// Number of interactive sign-ins attempted.
  int signInCalls = 0;

  /// HTTP client handed out by [authorizedClient]; null = session expired.
  http.Client? client;

  @override
  Future<void> initialize() async {}

  @override
  Future<GoogleAccount> signIn() async {
    signInCalls++;
    final error = signInError;
    if (error != null) throw error;
    return account;
  }

  @override
  Future<GoogleAccount?> restoreSession() async {
    final error = restoreError;
    if (error != null) throw error;
    return account;
  }

  @override
  Future<http.Client?> authorizedClient() async => client;

  @override
  Future<void> signOut() async {}
}

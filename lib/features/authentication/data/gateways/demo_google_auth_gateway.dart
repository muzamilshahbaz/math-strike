import 'package:http/http.dart' as http;

import '../../domain/entities/google_account.dart';
import 'google_auth_gateway.dart';

/// Development-only gateway used when no Google credentials are configured,
/// so the first-launch flow can be exercised end to end. The UI labels this
/// mode clearly; it is never used in production builds.
final class DemoGoogleAuthGateway implements GoogleAuthGateway {
  /// Creates the gateway. [latency] simulates the account picker.
  DemoGoogleAuthGateway({this.latency = const Duration(milliseconds: 700)});

  /// The fictional account every demo sign-in returns.
  static const GoogleAccount demoAccount = GoogleAccount(
    id: 'demo-player',
    email: 'demo.player@example.com',
    displayName: 'Demo Player',
  );

  /// Simulated sign-in delay.
  final Duration latency;

  @override
  Future<void> initialize() async {}

  @override
  Future<GoogleAccount> signIn() async {
    await Future<void>.delayed(latency);
    return demoAccount;
  }

  @override
  Future<GoogleAccount?> restoreSession() async => demoAccount;

  /// The demo Drive is in memory and needs no HTTP client.
  @override
  Future<http.Client?> authorizedClient() async => null;

  @override
  Future<void> signOut() async {}
}

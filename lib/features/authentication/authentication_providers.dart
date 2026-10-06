/// Dependency-injection bindings for the authentication feature.
library;

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import 'data/gateways/demo_google_auth_gateway.dart';
import 'data/gateways/desktop_google_auth_gateway_stub.dart'
    if (dart.library.io) 'data/gateways/desktop_google_auth_gateway.dart';
import 'data/gateways/google_auth_gateway.dart';
import 'data/gateways/plugin_google_auth_gateway.dart';
import 'data/repositories/account_link_repository_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/account_link_repository.dart';
import 'domain/repositories/auth_repository.dart';

part 'authentication_providers.g.dart';

/// How Google services are provided in this build.
enum GoogleIntegrationMode {
  /// Real Google Sign-In and Drive.
  live,

  /// Development build without credentials: demo account + in-memory Drive.
  demo,

  /// Production build without credentials: sign-in reports a config error.
  unavailable,
}

/// Selects the integration mode from the build configuration.
@Riverpod(keepAlive: true)
GoogleIntegrationMode googleIntegrationMode(Ref ref) {
  final config = ref.watch(appConfigProvider);
  if (config.google.isConfiguredFor(defaultTargetPlatform, isWeb: kIsWeb)) {
    return GoogleIntegrationMode.live;
  }
  return config.isProduction
      ? GoogleIntegrationMode.unavailable
      : GoogleIntegrationMode.demo;
}

/// The platform sign-in gateway for this build.
@Riverpod(keepAlive: true)
GoogleAuthGateway googleAuthGateway(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return switch (ref.watch(googleIntegrationModeProvider)) {
    GoogleIntegrationMode.demo => DemoGoogleAuthGateway(),
    GoogleIntegrationMode.unavailable => const UnavailableGoogleAuthGateway(),
    GoogleIntegrationMode.live
        when !kIsWeb &&
            (defaultTargetPlatform == TargetPlatform.windows ||
                defaultTargetPlatform == TargetPlatform.linux) =>
      createDesktopGoogleAuthGateway(
        config: config.google,
        logger: ref.watch(appLoggerProvider),
      ),
    GoogleIntegrationMode.live => PluginGoogleAuthGateway(
      config: config.google,
      platform: defaultTargetPlatform,
      isWeb: kIsWeb,
    ),
  };
}

/// Concrete auth repository (also the Google API authorizer).
@Riverpod(keepAlive: true)
AuthRepositoryImpl _authRepositoryImpl(Ref ref) =>
    AuthRepositoryImpl(ref.watch(googleAuthGatewayProvider));

/// Google authentication.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    ref.watch(_authRepositoryImplProvider);

/// Authorised HTTP clients for Google APIs (used by Drive backup).
@Riverpod(keepAlive: true)
GoogleApiAuthorizer googleApiAuthorizer(Ref ref) =>
    ref.watch(_authRepositoryImplProvider);

/// Persisted account link. Requires an opened database.
@Riverpod(keepAlive: true)
AccountLinkRepository accountLinkRepository(Ref ref) =>
    AccountLinkRepositoryImpl(
      store: ref.watch(localDatabaseProvider).store(StorageBox.device),
      logger: ref.watch(appLoggerProvider),
    );

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Selects the integration mode from the build configuration.

@ProviderFor(googleIntegrationMode)
final googleIntegrationModeProvider = GoogleIntegrationModeProvider._();

/// Selects the integration mode from the build configuration.

final class GoogleIntegrationModeProvider
    extends
        $FunctionalProvider<
          GoogleIntegrationMode,
          GoogleIntegrationMode,
          GoogleIntegrationMode
        >
    with $Provider<GoogleIntegrationMode> {
  /// Selects the integration mode from the build configuration.
  GoogleIntegrationModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleIntegrationModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleIntegrationModeHash();

  @$internal
  @override
  $ProviderElement<GoogleIntegrationMode> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleIntegrationMode create(Ref ref) {
    return googleIntegrationMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleIntegrationMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleIntegrationMode>(value),
    );
  }
}

String _$googleIntegrationModeHash() =>
    r'4d15815f9b7e1a36f617b3e0f13985273b93aead';

/// The platform sign-in gateway for this build.

@ProviderFor(googleAuthGateway)
final googleAuthGatewayProvider = GoogleAuthGatewayProvider._();

/// The platform sign-in gateway for this build.

final class GoogleAuthGatewayProvider
    extends
        $FunctionalProvider<
          GoogleAuthGateway,
          GoogleAuthGateway,
          GoogleAuthGateway
        >
    with $Provider<GoogleAuthGateway> {
  /// The platform sign-in gateway for this build.
  GoogleAuthGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleAuthGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleAuthGatewayHash();

  @$internal
  @override
  $ProviderElement<GoogleAuthGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleAuthGateway create(Ref ref) {
    return googleAuthGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleAuthGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleAuthGateway>(value),
    );
  }
}

String _$googleAuthGatewayHash() => r'ae7de551e3910ed8d3abe129ed294cc63f65d330';

/// Concrete auth repository (also the Google API authorizer).

@ProviderFor(_authRepositoryImpl)
final _authRepositoryImplProvider = _AuthRepositoryImplProvider._();

/// Concrete auth repository (also the Google API authorizer).

final class _AuthRepositoryImplProvider
    extends
        $FunctionalProvider<
          AuthRepositoryImpl,
          AuthRepositoryImpl,
          AuthRepositoryImpl
        >
    with $Provider<AuthRepositoryImpl> {
  /// Concrete auth repository (also the Google API authorizer).
  _AuthRepositoryImplProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_authRepositoryImplProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_authRepositoryImplHash();

  @$internal
  @override
  $ProviderElement<AuthRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRepositoryImpl create(Ref ref) {
    return _authRepositoryImpl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepositoryImpl>(value),
    );
  }
}

String _$_authRepositoryImplHash() =>
    r'2520ee3891b68d662da9ac2d3221ba16faace3d8';

/// Google authentication.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Google authentication.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Google authentication.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'5dbdb4eb0a05079115425e9ef088bfe99b5ffa45';

/// Authorised HTTP clients for Google APIs (used by Drive backup).

@ProviderFor(googleApiAuthorizer)
final googleApiAuthorizerProvider = GoogleApiAuthorizerProvider._();

/// Authorised HTTP clients for Google APIs (used by Drive backup).

final class GoogleApiAuthorizerProvider
    extends
        $FunctionalProvider<
          GoogleApiAuthorizer,
          GoogleApiAuthorizer,
          GoogleApiAuthorizer
        >
    with $Provider<GoogleApiAuthorizer> {
  /// Authorised HTTP clients for Google APIs (used by Drive backup).
  GoogleApiAuthorizerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleApiAuthorizerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleApiAuthorizerHash();

  @$internal
  @override
  $ProviderElement<GoogleApiAuthorizer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleApiAuthorizer create(Ref ref) {
    return googleApiAuthorizer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleApiAuthorizer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleApiAuthorizer>(value),
    );
  }
}

String _$googleApiAuthorizerHash() =>
    r'152b7c62430d103ab8a01b2963de4f2d1cb1058d';

/// Persisted account link. Requires an opened database.

@ProviderFor(accountLinkRepository)
final accountLinkRepositoryProvider = AccountLinkRepositoryProvider._();

/// Persisted account link. Requires an opened database.

final class AccountLinkRepositoryProvider
    extends
        $FunctionalProvider<
          AccountLinkRepository,
          AccountLinkRepository,
          AccountLinkRepository
        >
    with $Provider<AccountLinkRepository> {
  /// Persisted account link. Requires an opened database.
  AccountLinkRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountLinkRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountLinkRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountLinkRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountLinkRepository create(Ref ref) {
    return accountLinkRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountLinkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountLinkRepository>(value),
    );
  }
}

String _$accountLinkRepositoryHash() =>
    r'3191f01148a37599dce258a667844c4e3d340555';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's [GoRouter].
///
/// Top-level tabs live in a [StatefulShellRoute] so each tab keeps its own
/// navigation stack and scroll position. Gameplay is a sibling route so it
/// renders full-screen without navigation chrome.
///
/// Every navigation passes through [appRedirect]: splash → mandatory
/// sign-in → backup check / restore → onboarding → app.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// The app's [GoRouter].
///
/// Top-level tabs live in a [StatefulShellRoute] so each tab keeps its own
/// navigation stack and scroll position. Gameplay is a sibling route so it
/// renders full-screen without navigation chrome.
///
/// Every navigation passes through [appRedirect]: splash → mandatory
/// sign-in → backup check / restore → onboarding → app.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// The app's [GoRouter].
  ///
  /// Top-level tabs live in a [StatefulShellRoute] so each tab keeps its own
  /// navigation stack and scroll position. Gameplay is a sibling route so it
  /// renders full-screen without navigation chrome.
  ///
  /// Every navigation passes through [appRedirect]: splash → mandatory
  /// sign-in → backup check / restore → onboarding → app.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'43f1db1012d9429373310b3208fa01530c2be2fd';

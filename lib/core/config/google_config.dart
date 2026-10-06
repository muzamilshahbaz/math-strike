import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_config.freezed.dart';

/// OAuth client identifiers for Google Sign-In and Drive, per platform.
///
/// Supplied at build time, typically with
/// `--dart-define-from-file=config/google.json` (see
/// `config/google.example.json` and `docs/google_setup.md`). None of these
/// values are secret in the OAuth sense: they ship inside every client.
@freezed
abstract class GoogleConfig with _$GoogleConfig {
  /// Creates a configuration. Empty strings mean "not configured".
  const factory GoogleConfig({
    /// Android: the *Web application* client ID, used as `serverClientId`.
    @Default('') String serverClientId,

    /// iOS and macOS client ID.
    @Default('') String appleClientId,

    /// Web client ID.
    @Default('') String webClientId,

    /// Windows/Linux *Desktop app* client ID.
    @Default('') String desktopClientId,

    /// Windows/Linux *Desktop app* client secret. Google documents that for
    /// installed apps this value is not treated as confidential.
    @Default('') String desktopClientSecret,
  }) = _GoogleConfig;

  const GoogleConfig._();

  /// Reads the `GOOGLE_*` compile-time defines.
  factory GoogleConfig.fromEnvironment() => const GoogleConfig(
    serverClientId: String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID'),
    appleClientId: String.fromEnvironment('GOOGLE_APPLE_CLIENT_ID'),
    webClientId: String.fromEnvironment('GOOGLE_WEB_CLIENT_ID'),
    desktopClientId: String.fromEnvironment('GOOGLE_DESKTOP_CLIENT_ID'),
    desktopClientSecret: String.fromEnvironment('GOOGLE_DESKTOP_CLIENT_SECRET'),
  );

  /// Whether the values needed on [platform] (or the web) are present.
  bool isConfiguredFor(TargetPlatform platform, {required bool isWeb}) {
    if (isWeb) return webClientId.isNotEmpty;
    return switch (platform) {
      TargetPlatform.android => serverClientId.isNotEmpty,
      TargetPlatform.iOS || TargetPlatform.macOS => appleClientId.isNotEmpty,
      TargetPlatform.windows || TargetPlatform.linux =>
        desktopClientId.isNotEmpty && desktopClientSecret.isNotEmpty,
      TargetPlatform.fuchsia => false,
    };
  }
}

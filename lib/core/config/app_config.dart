import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants/app_constants.dart';
import 'app_environment.dart';

part 'app_config.freezed.dart';

/// Immutable, build-time configuration for the running app.
///
/// Created once in `main.dart` and exposed through the DI container
/// (`appConfigProvider`). Nothing in here is secret: it is compiled into
/// the binary.
@freezed
abstract class AppConfig with _$AppConfig {
  /// Creates a configuration. Prefer [AppConfig.fromEnvironment] in app code.
  const factory AppConfig({
    required AppEnvironment environment,
    @Default(AppConstants.appName) String appName,

    /// When true, AdMob test unit IDs are used (Phase 12). Always true
    /// outside [AppEnvironment.production].
    @Default(true) bool useTestAds,

    /// Enables debug-level log output.
    @Default(false) bool verboseLogging,
  }) = _AppConfig;

  const AppConfig._();

  /// Reads configuration from `--dart-define` values:
  ///
  /// * `APP_ENV` – `development` (default), `staging` or `production`.
  factory AppConfig.fromEnvironment() {
    final environment = AppEnvironment.fromName(
      const String.fromEnvironment('APP_ENV'),
    );
    final isProduction = environment == AppEnvironment.production;
    return AppConfig(
      environment: environment,
      useTestAds: !isProduction,
      verboseLogging: !isProduction,
    );
  }

  /// Whether this is a store build.
  bool get isProduction => environment == AppEnvironment.production;
}

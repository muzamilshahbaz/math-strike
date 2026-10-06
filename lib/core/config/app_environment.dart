/// The deployment environment the app is running in.
///
/// Selected at build time with `--dart-define=APP_ENV=<name>`; see
/// [AppEnvironment.fromName].
enum AppEnvironment {
  /// Local development: verbose logging, test ads, debug tooling.
  development,

  /// Internal/beta builds: production services but test ads.
  staging,

  /// Store builds.
  production;

  /// Parses an environment name, falling back to [development] for unknown
  /// or empty values so a misconfigured build never ships live ads.
  static AppEnvironment fromName(String name) {
    return AppEnvironment.values.firstWhere(
      (env) => env.name == name.trim().toLowerCase(),
      orElse: () => AppEnvironment.development,
    );
  }
}

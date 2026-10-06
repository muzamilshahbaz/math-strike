/// Route paths. Use these constants instead of string literals so renames
/// are compile-checked.
abstract final class AppRoutes {
  /// Animated splash that runs start-up (Phase 2).
  static const String splash = '/splash';

  /// Query parameter on [splash] holding the originally requested location.
  static const String fromParam = 'from';

  /// Home dashboard (Phase 5).
  static const String home = '/home';

  /// Level map / mode selection (Phase 9).
  static const String play = '/play';

  /// Statistics and reports (Phase 14).
  static const String progress = '/progress';

  /// Shop and rewards (Phase 10).
  static const String shop = '/shop';

  /// Settings (Phase 11).
  static const String settings = '/settings';

  /// Full-screen gameplay, outside the navigation shell (Phase 7).
  static const String game = '/game';
}

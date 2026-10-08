/// Route paths. Use these constants instead of string literals so renames
/// are compile-checked.
abstract final class AppRoutes {
  /// Animated splash that runs start-up (Phase 2).
  static const String splash = '/splash';

  /// Query parameter on [splash] holding the originally requested location.
  static const String fromParam = 'from';

  /// Mandatory Google sign-in (Phase 3).
  static const String signIn = '/sign-in';

  /// First-launch backup check and restore (Phase 3).
  static const String accountSetup = '/account-setup';

  /// Profile creation for new players (Phase 4).
  static const String onboarding = '/onboarding';

  /// Home dashboard (Phase 5).
  static const String home = '/home';

  /// Level map / mode selection (Phase 9).
  static const String play = '/play';

  /// Statistics (Phase 5); reports and graphs (Phase 14).
  static const String progress = '/progress';

  /// Shop and rewards (Phase 10).
  static const String shop = '/shop';

  /// Settings (Phase 11).
  static const String settings = '/settings';

  /// Practice hub: topic picker (Phase 6).
  static const String practice = '/practice';

  /// A practice session; [topicParam] picks the topic (omitted for a
  /// recommended mix).
  static const String practiceSession = '/practice/session';

  /// Query parameter on [practiceSession] naming the topic.
  static const String topicParam = 'topic';

  /// Full-screen gameplay, outside the navigation shell (Phase 7).
  static const String game = '/game';
}

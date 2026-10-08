/// App-wide constant values that are not tied to the theme.
abstract final class AppConstants {
  /// User-facing product name.
  static const String appName = 'Math Strike';

  /// Name of the secure-storage entry that holds the local database key.
  ///
  /// Versioned so a future key-rotation can migrate cleanly.
  static const String databaseKeyName = 'math_strike.db_key.v1';

  /// Sub-directory (inside the platform app-support dir) for Hive files.
  static const String databaseDirectory = 'math_strike_db';
}

/// Storage keys used inside the `settings` box.
abstract final class SettingsKeys {
  /// Serialized appearance/accessibility settings.
  static const String appearance = 'appearance';

  /// Sound and music preferences.
  static const String audio = 'audio';
}

/// Storage keys used inside the `profile` box.
abstract final class ProfileKeys {
  /// The local player's profile.
  static const String player = 'player';
}

/// Storage keys used inside the device-local `device` box.
abstract final class DeviceKeys {
  /// Launch counter and last-run version.
  static const String launchInfo = 'launch_info';

  /// The Google account this installation is linked to.
  static const String accountLink = 'account_link';
}

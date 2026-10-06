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
}

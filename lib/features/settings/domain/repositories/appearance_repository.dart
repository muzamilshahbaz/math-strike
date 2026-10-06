import '../../../../core/errors/result.dart';
import '../entities/appearance_settings.dart';

/// Persists [AppearanceSettings].
abstract interface class AppearanceRepository {
  /// Returns the saved settings, or defaults if none are saved or the saved
  /// data is unreadable. Synchronous because it is needed for the very first
  /// frame (theme).
  AppearanceSettings load();

  /// Persists [settings].
  Future<Result<void>> save(AppearanceSettings settings);
}

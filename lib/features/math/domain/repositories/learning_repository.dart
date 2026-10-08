import '../../../../core/errors/result.dart';
import '../entities/topic_mastery.dart';

/// Persists the player's [LearningProgress].
abstract interface class LearningRepository {
  /// The saved progress, or empty progress if none exists (or it is
  /// unreadable).
  LearningProgress load();

  /// Saves [progress].
  Future<Result<void>> save(LearningProgress progress);
}

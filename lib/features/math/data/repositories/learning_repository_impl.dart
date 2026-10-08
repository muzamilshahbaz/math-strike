import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/topic_mastery.dart';
import '../../domain/repositories/learning_repository.dart';

/// [LearningRepository] stored in the backed-up `learning` box.
final class LearningRepositoryImpl implements LearningRepository {
  /// Creates the repository.
  const LearningRepositoryImpl({required this._store, required this._logger});

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  LearningProgress load() {
    try {
      final json = _store.readJson(LearningKeys.progress);
      return json == null
          ? const LearningProgress()
          : LearningProgress.fromJson(json);
    } on Object catch (e, st) {
      _logger.warning(
        'Learning progress unreadable; starting fresh',
        error: e,
        stackTrace: st,
      );
      return const LearningProgress();
    }
  }

  @override
  Future<Result<void>> save(LearningProgress progress) => Result.guard(
    () => _store.writeJson(LearningKeys.progress, progress.toJson()),
  );
}

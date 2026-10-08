/// Dependency-injection bindings for the math feature.
library;

import 'dart:math' as math;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import '../profile/domain/entities/age_group.dart';
import '../profile/domain/entities/difficulty.dart';
import '../profile/presentation/controllers/profile_controller.dart';
import 'data/repositories/learning_repository_impl.dart';
import 'domain/adaptive/adaptive_model.dart';
import 'domain/difficulty/difficulty_profile.dart';
import 'domain/engine/math_engine.dart';
import 'domain/repositories/learning_repository.dart';

part 'math_providers.g.dart';

/// Random source for question generation. Overridden with a seeded
/// generator in tests.
@Riverpod(keepAlive: true)
math.Random mathRandom(Ref ref) => math.Random();

/// The question generator.
@Riverpod(keepAlive: true)
MathEngine mathEngine(Ref ref) =>
    MathEngine(random: ref.watch(mathRandomProvider));

/// Adaptive-learning rules.
@Riverpod(keepAlive: true)
AdaptiveModel adaptiveModel(Ref ref) => const AdaptiveModel();

/// What the engine may ask this player, from their age group and
/// difficulty (adult/medium before a profile exists).
@Riverpod(keepAlive: true)
DifficultyProfile difficultyProfile(Ref ref) {
  final profile = ref.watch(profileControllerProvider);
  return DifficultyProfile.of(
    profile?.ageGroup ?? AgeGroup.adult,
    profile?.difficulty ?? Difficulty.medium,
  );
}

/// Learning-progress persistence. Requires an opened database.
@Riverpod(keepAlive: true)
LearningRepository learningRepository(Ref ref) => LearningRepositoryImpl(
  store: ref.watch(localDatabaseProvider).store(StorageBox.learning),
  logger: ref.watch(appLoggerProvider),
);

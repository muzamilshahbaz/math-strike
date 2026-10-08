// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Random source for question generation. Overridden with a seeded
/// generator in tests.

@ProviderFor(mathRandom)
final mathRandomProvider = MathRandomProvider._();

/// Random source for question generation. Overridden with a seeded
/// generator in tests.

final class MathRandomProvider
    extends $FunctionalProvider<math.Random, math.Random, math.Random>
    with $Provider<math.Random> {
  /// Random source for question generation. Overridden with a seeded
  /// generator in tests.
  MathRandomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mathRandomProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mathRandomHash();

  @$internal
  @override
  $ProviderElement<math.Random> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  math.Random create(Ref ref) {
    return mathRandom(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(math.Random value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<math.Random>(value),
    );
  }
}

String _$mathRandomHash() => r'30e38ae3a7e512f59a755af9c21de0eb89956941';

/// The question generator.

@ProviderFor(mathEngine)
final mathEngineProvider = MathEngineProvider._();

/// The question generator.

final class MathEngineProvider
    extends $FunctionalProvider<MathEngine, MathEngine, MathEngine>
    with $Provider<MathEngine> {
  /// The question generator.
  MathEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mathEngineProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mathEngineHash();

  @$internal
  @override
  $ProviderElement<MathEngine> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MathEngine create(Ref ref) {
    return mathEngine(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MathEngine value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MathEngine>(value),
    );
  }
}

String _$mathEngineHash() => r'4b3586581fa728658f10eb8ae4d65589a90d2b6f';

/// Adaptive-learning rules.

@ProviderFor(adaptiveModel)
final adaptiveModelProvider = AdaptiveModelProvider._();

/// Adaptive-learning rules.

final class AdaptiveModelProvider
    extends $FunctionalProvider<AdaptiveModel, AdaptiveModel, AdaptiveModel>
    with $Provider<AdaptiveModel> {
  /// Adaptive-learning rules.
  AdaptiveModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adaptiveModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adaptiveModelHash();

  @$internal
  @override
  $ProviderElement<AdaptiveModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdaptiveModel create(Ref ref) {
    return adaptiveModel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdaptiveModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdaptiveModel>(value),
    );
  }
}

String _$adaptiveModelHash() => r'8870e75d7aed1b26d8f22750fe11cd22b34ff8a8';

/// What the engine may ask this player, from their age group and
/// difficulty (adult/medium before a profile exists).

@ProviderFor(difficultyProfile)
final difficultyProfileProvider = DifficultyProfileProvider._();

/// What the engine may ask this player, from their age group and
/// difficulty (adult/medium before a profile exists).

final class DifficultyProfileProvider
    extends
        $FunctionalProvider<
          DifficultyProfile,
          DifficultyProfile,
          DifficultyProfile
        >
    with $Provider<DifficultyProfile> {
  /// What the engine may ask this player, from their age group and
  /// difficulty (adult/medium before a profile exists).
  DifficultyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'difficultyProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$difficultyProfileHash();

  @$internal
  @override
  $ProviderElement<DifficultyProfile> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DifficultyProfile create(Ref ref) {
    return difficultyProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DifficultyProfile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DifficultyProfile>(value),
    );
  }
}

String _$difficultyProfileHash() => r'fbcd07790ee58cf20530769114031c02b1b424cb';

/// Learning-progress persistence. Requires an opened database.

@ProviderFor(learningRepository)
final learningRepositoryProvider = LearningRepositoryProvider._();

/// Learning-progress persistence. Requires an opened database.

final class LearningRepositoryProvider
    extends
        $FunctionalProvider<
          LearningRepository,
          LearningRepository,
          LearningRepository
        >
    with $Provider<LearningRepository> {
  /// Learning-progress persistence. Requires an opened database.
  LearningRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningRepositoryHash();

  @$internal
  @override
  $ProviderElement<LearningRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LearningRepository create(Ref ref) {
    return learningRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningRepository>(value),
    );
  }
}

String _$learningRepositoryHash() =>
    r'a9dcab8964082601711d0306b737c2c6ac8381da';

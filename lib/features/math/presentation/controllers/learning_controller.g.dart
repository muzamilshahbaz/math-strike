// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The player's per-topic mastery, updated after every answer.
///
/// Requires an opened database: only read it after start-up completes.

@ProviderFor(LearningController)
final learningControllerProvider = LearningControllerProvider._();

/// The player's per-topic mastery, updated after every answer.
///
/// Requires an opened database: only read it after start-up completes.
final class LearningControllerProvider
    extends $NotifierProvider<LearningController, LearningProgress> {
  /// The player's per-topic mastery, updated after every answer.
  ///
  /// Requires an opened database: only read it after start-up completes.
  LearningControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningControllerHash();

  @$internal
  @override
  LearningController create() => LearningController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningProgress>(value),
    );
  }
}

String _$learningControllerHash() =>
    r'55d88ddb6c9b5eaf2eb58e6d04884e921d2b878d';

/// The player's per-topic mastery, updated after every answer.
///
/// Requires an opened database: only read it after start-up completes.

abstract class _$LearningController extends $Notifier<LearningProgress> {
  LearningProgress build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LearningProgress, LearningProgress>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LearningProgress, LearningProgress>,
              LearningProgress,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Summaries of every topic available to the player, in catalogue order.

@ProviderFor(topicSummaries)
final topicSummariesProvider = TopicSummariesProvider._();

/// Summaries of every topic available to the player, in catalogue order.

final class TopicSummariesProvider
    extends
        $FunctionalProvider<
          List<TopicSummary>,
          List<TopicSummary>,
          List<TopicSummary>
        >
    with $Provider<List<TopicSummary>> {
  /// Summaries of every topic available to the player, in catalogue order.
  TopicSummariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topicSummariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topicSummariesHash();

  @$internal
  @override
  $ProviderElement<List<TopicSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TopicSummary> create(Ref ref) {
    return topicSummaries(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TopicSummary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TopicSummary>>(value),
    );
  }
}

String _$topicSummariesHash() => r'0c1ebca8044231a2efca75a1ae6bcb3a130339e0';

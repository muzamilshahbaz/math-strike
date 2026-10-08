// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Runs a 10-question practice session on one topic, or a recommended mix
/// when [focus] is `null`. Every answer updates the adaptive model at once;
/// a finished session is also added to the statistics.

@ProviderFor(PracticeSessionController)
final practiceSessionControllerProvider = PracticeSessionControllerFamily._();

/// Runs a 10-question practice session on one topic, or a recommended mix
/// when [focus] is `null`. Every answer updates the adaptive model at once;
/// a finished session is also added to the statistics.
final class PracticeSessionControllerProvider
    extends $NotifierProvider<PracticeSessionController, PracticeSession> {
  /// Runs a 10-question practice session on one topic, or a recommended mix
  /// when [focus] is `null`. Every answer updates the adaptive model at once;
  /// a finished session is also added to the statistics.
  PracticeSessionControllerProvider._({
    required PracticeSessionControllerFamily super.from,
    required MathTopic? super.argument,
  }) : super(
         retry: null,
         name: r'practiceSessionControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$practiceSessionControllerHash();

  @override
  String toString() {
    return r'practiceSessionControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PracticeSessionController create() => PracticeSessionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PracticeSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PracticeSession>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PracticeSessionControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$practiceSessionControllerHash() =>
    r'4afeac2cd06ff53036f8932cfabdbaeb422c25db';

/// Runs a 10-question practice session on one topic, or a recommended mix
/// when [focus] is `null`. Every answer updates the adaptive model at once;
/// a finished session is also added to the statistics.

final class PracticeSessionControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PracticeSessionController,
          PracticeSession,
          PracticeSession,
          PracticeSession,
          MathTopic?
        > {
  PracticeSessionControllerFamily._()
    : super(
        retry: null,
        name: r'practiceSessionControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Runs a 10-question practice session on one topic, or a recommended mix
  /// when [focus] is `null`. Every answer updates the adaptive model at once;
  /// a finished session is also added to the statistics.

  PracticeSessionControllerProvider call(MathTopic? focus) =>
      PracticeSessionControllerProvider._(argument: focus, from: this);

  @override
  String toString() => r'practiceSessionControllerProvider';
}

/// Runs a 10-question practice session on one topic, or a recommended mix
/// when [focus] is `null`. Every answer updates the adaptive model at once;
/// a finished session is also added to the statistics.

abstract class _$PracticeSessionController extends $Notifier<PracticeSession> {
  late final _$args = ref.$arg as MathTopic?;
  MathTopic? get focus => _$args;

  PracticeSession build(MathTopic? focus);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PracticeSession, PracticeSession>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PracticeSession, PracticeSession>,
              PracticeSession,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

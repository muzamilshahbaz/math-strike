// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reward_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Today's [DailyRewardStatus]; rolls over automatically at midnight.
///
/// Requires an opened database: only read it after start-up completes.

@ProviderFor(DailyRewardController)
final dailyRewardControllerProvider = DailyRewardControllerProvider._();

/// Today's [DailyRewardStatus]; rolls over automatically at midnight.
///
/// Requires an opened database: only read it after start-up completes.
final class DailyRewardControllerProvider
    extends $NotifierProvider<DailyRewardController, DailyRewardStatus> {
  /// Today's [DailyRewardStatus]; rolls over automatically at midnight.
  ///
  /// Requires an opened database: only read it after start-up completes.
  DailyRewardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyRewardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyRewardControllerHash();

  @$internal
  @override
  DailyRewardController create() => DailyRewardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DailyRewardStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DailyRewardStatus>(value),
    );
  }
}

String _$dailyRewardControllerHash() =>
    r'97b845cab1340d911e8a5b84334e057697228416';

/// Today's [DailyRewardStatus]; rolls over automatically at midnight.
///
/// Requires an opened database: only read it after start-up completes.

abstract class _$DailyRewardController extends $Notifier<DailyRewardStatus> {
  DailyRewardStatus build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DailyRewardStatus, DailyRewardStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DailyRewardStatus, DailyRewardStatus>,
              DailyRewardStatus,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Wallet and daily-reward persistence. Requires an opened database.

@ProviderFor(rewardsRepository)
final rewardsRepositoryProvider = RewardsRepositoryProvider._();

/// Wallet and daily-reward persistence. Requires an opened database.

final class RewardsRepositoryProvider
    extends
        $FunctionalProvider<
          RewardsRepository,
          RewardsRepository,
          RewardsRepository
        >
    with $Provider<RewardsRepository> {
  /// Wallet and daily-reward persistence. Requires an opened database.
  RewardsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rewardsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rewardsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RewardsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RewardsRepository create(Ref ref) {
    return rewardsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RewardsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RewardsRepository>(value),
    );
  }
}

String _$rewardsRepositoryHash() => r'5281efabd2d414328a87bde5619c2268b080b43e';

/// The daily-reward cycle in effect.

@ProviderFor(dailyRewardSchedule)
final dailyRewardScheduleProvider = DailyRewardScheduleProvider._();

/// The daily-reward cycle in effect.

final class DailyRewardScheduleProvider
    extends
        $FunctionalProvider<
          DailyRewardSchedule,
          DailyRewardSchedule,
          DailyRewardSchedule
        >
    with $Provider<DailyRewardSchedule> {
  /// The daily-reward cycle in effect.
  DailyRewardScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyRewardScheduleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyRewardScheduleHash();

  @$internal
  @override
  $ProviderElement<DailyRewardSchedule> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DailyRewardSchedule create(Ref ref) {
    return dailyRewardSchedule(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DailyRewardSchedule value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DailyRewardSchedule>(value),
    );
  }
}

String _$dailyRewardScheduleHash() =>
    r'70cc90a7948c1af4aced7e2287c07064e27e0978';

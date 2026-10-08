// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The player's [PlayerStatistics].
///
/// Requires an opened database: only read it after start-up completes.

@ProviderFor(StatisticsController)
final statisticsControllerProvider = StatisticsControllerProvider._();

/// The player's [PlayerStatistics].
///
/// Requires an opened database: only read it after start-up completes.
final class StatisticsControllerProvider
    extends $NotifierProvider<StatisticsController, PlayerStatistics> {
  /// The player's [PlayerStatistics].
  ///
  /// Requires an opened database: only read it after start-up completes.
  StatisticsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsControllerHash();

  @$internal
  @override
  StatisticsController create() => StatisticsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerStatistics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerStatistics>(value),
    );
  }
}

String _$statisticsControllerHash() =>
    r'2d2d4b8f37473ffebf53a4e5cf5ccb781d51637f';

/// The player's [PlayerStatistics].
///
/// Requires an opened database: only read it after start-up completes.

abstract class _$StatisticsController extends $Notifier<PlayerStatistics> {
  PlayerStatistics build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PlayerStatistics, PlayerStatistics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayerStatistics, PlayerStatistics>,
              PlayerStatistics,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Totals for [period], ending today.

@ProviderFor(periodTotals)
final periodTotalsProvider = PeriodTotalsFamily._();

/// Totals for [period], ending today.

final class PeriodTotalsProvider
    extends $FunctionalProvider<StatTotals, StatTotals, StatTotals>
    with $Provider<StatTotals> {
  /// Totals for [period], ending today.
  PeriodTotalsProvider._({
    required PeriodTotalsFamily super.from,
    required StatisticsPeriod super.argument,
  }) : super(
         retry: null,
         name: r'periodTotalsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$periodTotalsHash();

  @override
  String toString() {
    return r'periodTotalsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<StatTotals> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StatTotals create(Ref ref) {
    final argument = this.argument as StatisticsPeriod;
    return periodTotals(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatTotals value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatTotals>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PeriodTotalsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$periodTotalsHash() => r'642430b1141202c25f2631e6f5d9383fa4525c22';

/// Totals for [period], ending today.

final class PeriodTotalsFamily extends $Family
    with $FunctionalFamilyOverride<StatTotals, StatisticsPeriod> {
  PeriodTotalsFamily._()
    : super(
        retry: null,
        name: r'periodTotalsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Totals for [period], ending today.

  PeriodTotalsProvider call(StatisticsPeriod period) =>
      PeriodTotalsProvider._(argument: period, from: this);

  @override
  String toString() => r'periodTotalsProvider';
}

/// Per-day totals for the last [days] days, oldest first.

@ProviderFor(activityHistory)
final activityHistoryProvider = ActivityHistoryFamily._();

/// Per-day totals for the last [days] days, oldest first.

final class ActivityHistoryProvider
    extends
        $FunctionalProvider<
          List<(CalendarDay, StatTotals)>,
          List<(CalendarDay, StatTotals)>,
          List<(CalendarDay, StatTotals)>
        >
    with $Provider<List<(CalendarDay, StatTotals)>> {
  /// Per-day totals for the last [days] days, oldest first.
  ActivityHistoryProvider._({
    required ActivityHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'activityHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityHistoryHash();

  @override
  String toString() {
    return r'activityHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<(CalendarDay, StatTotals)>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<(CalendarDay, StatTotals)> create(Ref ref) {
    final argument = this.argument as int;
    return activityHistory(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<(CalendarDay, StatTotals)> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<(CalendarDay, StatTotals)>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityHistoryHash() => r'a11066e6fc7c05fb01ac6fc581f66f3c3cbd38d1';

/// Per-day totals for the last [days] days, oldest first.

final class ActivityHistoryFamily extends $Family
    with $FunctionalFamilyOverride<List<(CalendarDay, StatTotals)>, int> {
  ActivityHistoryFamily._()
    : super(
        retry: null,
        name: r'activityHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Per-day totals for the last [days] days, oldest first.

  ActivityHistoryProvider call(int days) =>
      ActivityHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'activityHistoryProvider';
}

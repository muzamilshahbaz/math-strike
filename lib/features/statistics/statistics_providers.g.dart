// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Statistics persistence. Requires an opened database.

@ProviderFor(statisticsRepository)
final statisticsRepositoryProvider = StatisticsRepositoryProvider._();

/// Statistics persistence. Requires an opened database.

final class StatisticsRepositoryProvider
    extends
        $FunctionalProvider<
          StatisticsRepository,
          StatisticsRepository,
          StatisticsRepository
        >
    with $Provider<StatisticsRepository> {
  /// Statistics persistence. Requires an opened database.
  StatisticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StatisticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StatisticsRepository create(Ref ref) {
    return statisticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatisticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatisticsRepository>(value),
    );
  }
}

String _$statisticsRepositoryHash() =>
    r'de9b78b74632ecc4d11b9b2098272ad17b8b2075';

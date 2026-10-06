// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where backups live: the real Drive app folder, or an in-memory stand-in
/// in demo mode (optionally seeded with a sample backup).

@ProviderFor(backupRemoteDataSource)
final backupRemoteDataSourceProvider = BackupRemoteDataSourceProvider._();

/// Where backups live: the real Drive app folder, or an in-memory stand-in
/// in demo mode (optionally seeded with a sample backup).

final class BackupRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          BackupRemoteDataSource,
          BackupRemoteDataSource,
          BackupRemoteDataSource
        >
    with $Provider<BackupRemoteDataSource> {
  /// Where backups live: the real Drive app folder, or an in-memory stand-in
  /// in demo mode (optionally seeded with a sample backup).
  BackupRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<BackupRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupRemoteDataSource create(Ref ref) {
    return backupRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupRemoteDataSource>(value),
    );
  }
}

String _$backupRemoteDataSourceHash() =>
    r'69007a09cdeefd7618017192123f4cff1a252940';

/// Backup detection and restore.

@ProviderFor(backupRepository)
final backupRepositoryProvider = BackupRepositoryProvider._();

/// Backup detection and restore.

final class BackupRepositoryProvider
    extends
        $FunctionalProvider<
          BackupRepository,
          BackupRepository,
          BackupRepository
        >
    with $Provider<BackupRepository> {
  /// Backup detection and restore.
  BackupRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupRepositoryHash();

  @$internal
  @override
  $ProviderElement<BackupRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupRepository create(Ref ref) {
    return backupRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupRepository>(value),
    );
  }
}

String _$backupRepositoryHash() => r'dff13fee965122f557ece35dfd4b4c8d1af28e3f';

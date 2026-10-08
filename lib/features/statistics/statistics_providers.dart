/// Dependency-injection bindings for the statistics feature.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import 'data/repositories/statistics_repository_impl.dart';
import 'domain/repositories/statistics_repository.dart';

part 'statistics_providers.g.dart';

/// Statistics persistence. Requires an opened database.
@Riverpod(keepAlive: true)
StatisticsRepository statisticsRepository(Ref ref) => StatisticsRepositoryImpl(
  store: ref.watch(localDatabaseProvider).store(StorageBox.statistics),
  logger: ref.watch(appLoggerProvider),
);

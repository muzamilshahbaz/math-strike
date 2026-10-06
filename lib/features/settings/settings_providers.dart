/// Dependency-injection bindings for the settings feature.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import 'data/repositories/appearance_repository_impl.dart';
import 'domain/repositories/appearance_repository.dart';

part 'settings_providers.g.dart';

/// The appearance repository, bound to its implementation.
@Riverpod(keepAlive: true)
AppearanceRepository appearanceRepository(Ref ref) => AppearanceRepositoryImpl(
  store: ref.watch(localDatabaseProvider).store(StorageBox.settings),
  logger: ref.watch(appLoggerProvider),
);

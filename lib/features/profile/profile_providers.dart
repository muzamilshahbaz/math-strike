/// Dependency-injection bindings for the profile feature.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/profile_repository.dart';

part 'profile_providers.g.dart';

/// Player-profile persistence. Requires an opened database.
@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) => ProfileRepositoryImpl(
  store: ref.watch(localDatabaseProvider).store(StorageBox.profile),
  logger: ref.watch(appLoggerProvider),
);

/// Dependency-injection bindings for the rewards feature.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import 'data/repositories/rewards_repository_impl.dart';
import 'domain/entities/daily_reward.dart';
import 'domain/repositories/rewards_repository.dart';

part 'rewards_providers.g.dart';

/// Wallet and daily-reward persistence. Requires an opened database.
@Riverpod(keepAlive: true)
RewardsRepository rewardsRepository(Ref ref) => RewardsRepositoryImpl(
  store: ref.watch(localDatabaseProvider).store(StorageBox.rewards),
  logger: ref.watch(appLoggerProvider),
);

/// The daily-reward cycle in effect.
@Riverpod(keepAlive: true)
DailyRewardSchedule dailyRewardSchedule(Ref ref) =>
    DailyRewardSchedule.standard;

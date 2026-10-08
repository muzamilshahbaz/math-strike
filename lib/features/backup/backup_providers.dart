/// Dependency-injection bindings for the backup feature.
library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import '../../core/theme/game_theme_id.dart';
import '../../core/utils/calendar_day.dart';
import '../authentication/authentication_providers.dart';
import '../profile/domain/entities/age_group.dart';
import '../profile/domain/entities/difficulty.dart';
import '../profile/domain/entities/player_profile.dart';
import '../rewards/domain/entities/daily_reward.dart';
import '../rewards/domain/entities/wallet.dart';
import '../settings/domain/entities/appearance_settings.dart';
import '../statistics/domain/entities/game_session_summary.dart';
import '../statistics/domain/entities/player_statistics.dart';
import 'data/codec/backup_snapshot_codec.dart';
import 'data/datasources/backup_remote_data_source.dart';
import 'data/datasources/google_drive_backup_data_source.dart';
import 'data/datasources/in_memory_backup_data_source.dart';
import 'data/repositories/backup_repository_impl.dart';
import 'domain/repositories/backup_repository.dart';

part 'backup_providers.g.dart';

/// Where backups live: the real Drive app folder, or an in-memory stand-in
/// in demo mode (optionally seeded with a sample backup).
@Riverpod(keepAlive: true)
BackupRemoteDataSource backupRemoteDataSource(Ref ref) {
  if (ref.watch(googleIntegrationModeProvider) == GoogleIntegrationMode.live) {
    return GoogleDriveBackupDataSource(ref.watch(googleApiAuthorizerProvider));
  }
  final demoDrive = InMemoryBackupDataSource(
    latency: const Duration(milliseconds: 500),
  );
  if (ref.watch(appConfigProvider).seedDemoBackup) {
    demoDrive.seed(
      const BackupSnapshotCodec().encode(_demoSnapshot()),
      appVersion: '0.9.0',
      formatVersion: BackupSnapshotCodec.currentFormatVersion,
      modifiedAt: DateTime.now().toUtc().subtract(const Duration(days: 2)),
    );
  }
  return demoDrive;
}

/// Backup detection and restore.
@Riverpod(keepAlive: true)
BackupRepository backupRepository(Ref ref) => BackupRepositoryImpl(
  remote: ref.watch(backupRemoteDataSourceProvider),
  database: ref.watch(localDatabaseProvider),
  logger: ref.watch(appLoggerProvider),
);

/// A recognisable sample backup for demo mode: dark Neon theme, larger
/// text, a filled wallet and a week of play — easy to see that the restore
/// actually applied.
BackupSnapshot _demoSnapshot() {
  final today = CalendarDay.fromDateTime(DateTime.now());
  var statistics = const PlayerStatistics();
  // Games on most of the last week, skipping two days.
  for (final (daysAgo, questions, correct) in const [
    (6, 24, 19),
    (5, 30, 25),
    (3, 18, 16),
    (2, 36, 31),
    (1, 28, 26),
  ]) {
    final day = today.addDays(-daysAgo);
    statistics = statistics.record(
      GameSessionSummary(
        endedAt: day.startOfDayLocal.add(const Duration(hours: 18)),
        duration: Duration(minutes: questions ~/ 3),
        questionsAnswered: questions,
        correctAnswers: correct,
        totalReactionTime: Duration(milliseconds: questions * 2100),
        bestStreak: correct ~/ 2,
        highestCombo: correct ~/ 4,
        levelCompleted: correct > 20,
      ),
      day,
    );
  }
  return _demoSnapshotWith(
    statistics: statistics,
    // Claimed yesterday on day 2: today continues the streak.
    dailyReward: DailyRewardRecord(
      lastClaimDay: today.addDays(-1),
      streak: 2,
      longestStreak: 4,
      totalClaims: 9,
    ),
  );
}

BackupSnapshot _demoSnapshotWith({
  required PlayerStatistics statistics,
  required DailyRewardRecord dailyReward,
}) => BackupSnapshot(
  formatVersion: BackupSnapshotCodec.currentFormatVersion,
  createdAt: DateTime.now().toUtc().subtract(const Duration(days: 2)),
  appVersion: '0.9.0',
  boxes: {
    StorageBox.settings.boxName: {
      SettingsKeys.appearance: jsonEncode(
        const AppearanceSettings(
          themeMode: ThemeMode.dark,
          gameTheme: GameThemeId.neon,
          textScale: 1.1,
        ).toJson(),
      ),
    },
    StorageBox.profile.boxName: {
      ProfileKeys.player: jsonEncode(
        PlayerProfile(
          name: 'Nova',
          avatarId: 'nova',
          ageGroup: AgeGroup.latePrimary,
          difficulty: Difficulty.medium,
          createdAt: DateTime.utc(2026),
        ).toJson(),
      ),
    },
    StorageBox.rewards.boxName: {
      RewardsKeys.wallet: jsonEncode(
        const Wallet(coins: 1250, diamonds: 4, xp: 610).toJson(),
      ),
      RewardsKeys.dailyReward: jsonEncode(dailyReward.toJson()),
    },
    StorageBox.statistics.boxName: {
      StatisticsKeys.player: jsonEncode(statistics.toJson()),
    },
  },
);

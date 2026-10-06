/// Dependency-injection bindings for the backup feature.
library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/di/core_providers.dart';
import '../../core/services/storage/local_database.dart';
import '../../core/theme/game_theme_id.dart';
import '../authentication/authentication_providers.dart';
import '../settings/domain/entities/appearance_settings.dart';
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
/// text — easy to see that the restore actually applied.
BackupSnapshot _demoSnapshot() => BackupSnapshot(
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
  },
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/errors/failure.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/authentication/domain/entities/account_link.dart';
import 'package:math_strike/features/authentication/presentation/controllers/account_controller.dart';
import 'package:math_strike/features/backup/data/codec/backup_snapshot_codec.dart';
import 'package:math_strike/features/backup/data/datasources/in_memory_backup_data_source.dart';
import 'package:math_strike/features/backup/presentation/controllers/restore_flow_controller.dart';

import '../../helpers/test_app.dart';

void main() {
  late InMemoryLocalDatabase db;
  late InMemoryBackupDataSource drive;
  late ProviderContainer container;

  setUp(() async {
    db = InMemoryLocalDatabase();
    drive = InMemoryBackupDataSource();
    await linkTestAccount(db, stage: AccountSetupStage.restoreCheck);
    container = createTestContainer(database: db, drive: drive);
    // Keep the auto-dispose controller alive for the whole test.
    container.listen(restoreFlowControllerProvider, (_, _) {});
  });

  RestoreFlowState state() => container.read(restoreFlowControllerProvider);
  RestoreFlowController controller() =>
      container.read(restoreFlowControllerProvider.notifier);
  AccountSetupStage stage() => container.read(accountControllerProvider)!.stage;

  test('no backup → onboarding', () async {
    await controller().start();
    expect(state(), const RestoreFlowState.noBackup());

    await controller().finish();
    expect(stage(), AccountSetupStage.onboarding);
  });

  test('a backup is restored automatically → app', () async {
    drive.seed(
      const BackupSnapshotCodec().encode(
        BackupSnapshot(
          formatVersion: 1,
          createdAt: DateTime.utc(2026),
          appVersion: '1.0.0',
          boxes: {
            'settings': {SettingsKeys.appearance: '{"themeMode":"dark"}'},
          },
        ),
      ),
      appVersion: '1.0.0',
      formatVersion: 1,
    );
    final epochBefore = container.read(localDataEpochProvider);

    await controller().start();

    expect(state(), isA<RestoreSucceeded>());
    expect(
      db.store(StorageBox.settings).read(SettingsKeys.appearance),
      '{"themeMode":"dark"}',
    );
    expect(
      container.read(localDataEpochProvider),
      epochBefore + 1,
      reason: 'cached controllers must reload restored data',
    );

    await controller().finish();
    expect(stage(), AccountSetupStage.complete);
  });

  test('offline: fails, then retry succeeds', () async {
    drive.failWith = const NetworkException('offline');

    await controller().start();
    expect(
      state(),
      isA<RestoreFailed>()
          .having((s) => s.failure, 'failure', isA<NetworkFailure>())
          .having((s) => s.duringRestore, 'duringRestore', isFalse),
    );
    expect(stage(), AccountSetupStage.restoreCheck);

    drive.failWith = null;
    await controller().start();
    expect(state(), const RestoreFlowState.noBackup());
  });

  test('skipping after a failure continues to onboarding', () async {
    drive.failWith = const NetworkException('offline');
    await controller().start();

    await controller().finish();

    expect(stage(), AccountSetupStage.onboarding);
  });
}

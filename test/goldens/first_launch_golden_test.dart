@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/features/backup/data/codec/backup_snapshot_codec.dart';
import 'package:math_strike/features/backup/data/datasources/in_memory_backup_data_source.dart';

import '../helpers/fake_google_auth_gateway.dart';
import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

void main() {
  setUpAll(loadGoldenFonts);

  const phone = Size(400, 820);

  testWidgets('sign-in screen', (tester) async {
    await tester.pumpMathStrikeAppAtSplash(linked: false, size: phone);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/sign_in_phone.png'),
    );
  });

  testWidgets('sign-in screen after cancelling', (tester) async {
    await tester.pumpMathStrikeAppAtSplash(
      linked: false,
      size: phone,
      gateway: FakeGoogleAuthGateway(
        signInError: const AuthCancelledException(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/sign_in_cancelled_phone.png'),
    );
  });

  testWidgets('restore in progress', (tester) async {
    // Each simulated Drive call takes 2 s; the download reports progress in
    // quarters, so the screen can be captured mid-restore.
    final drive = InMemoryBackupDataSource(latency: const Duration(seconds: 2))
      ..seed(
        const BackupSnapshotCodec().encode(
          BackupSnapshot(
            formatVersion: 1,
            createdAt: DateTime.utc(2026),
            appVersion: '1.0.0',
            boxes: const {},
          ),
        ),
        appVersion: '1.0.0',
        formatVersion: 1,
        modifiedAt: DateTime.utc(2026, 9, 28, 18, 45),
      );
    await tester.pumpMathStrikeAppAtSplash(
      linked: false,
      size: phone,
      drive: drive,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pump(); // navigate to the restore screen
    await tester.pump(const Duration(seconds: 2)); // find the backup
    await tester.pump(const Duration(milliseconds: 3100)); // ~half downloaded
    await tester.pump(const Duration(milliseconds: 400)); // settle progress bar

    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/restore_in_progress_phone.png'),
    );

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('backup check failed', (tester) async {
    await tester.pumpMathStrikeAppAtSplash(
      linked: false,
      size: phone,
      drive: InMemoryBackupDataSource()
        ..failWith = const NetworkException('offline'),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/restore_failed_phone.png'),
    );
  });
}

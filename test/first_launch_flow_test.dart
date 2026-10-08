import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/theme/game_theme_id.dart';
import 'package:math_strike/features/backup/data/codec/backup_snapshot_codec.dart';
import 'package:math_strike/features/backup/data/datasources/in_memory_backup_data_source.dart';
import 'package:math_strike/features/settings/domain/entities/appearance_settings.dart';
import 'package:math_strike/routing/app_routes.dart';

import 'helpers/fake_google_auth_gateway.dart';
import 'helpers/test_app.dart';

void main() {
  Future<void> waitForOutcomeHold(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  }

  testWidgets('fresh install: sign in → no backup → onboarding → app', (
    tester,
  ) async {
    await tester.pumpMathStrikeAppAtSplash(linked: false);
    await tester.pumpAndSettle();

    expect(tester.currentLocation, AppRoutes.signIn);
    expect(find.text('Keep your progress safe'), findsOneWidget);

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(tester.currentLocation, AppRoutes.accountSetup);
    expect(find.text('No backup yet'), findsOneWidget);
    expect(find.text('player@example.com'), findsOneWidget);

    await waitForOutcomeHold(tester);
    expect(tester.currentLocation, AppRoutes.onboarding);

    await tester.completeOnboarding();
    expect(tester.currentLocation, AppRoutes.home);
  });

  testWidgets('an existing backup is restored automatically', (tester) async {
    final drive = InMemoryBackupDataSource()
      ..seed(
        const BackupSnapshotCodec().encode(
          BackupSnapshot(
            formatVersion: 1,
            createdAt: DateTime.utc(2026),
            appVersion: '1.0.0',
            boxes: {
              'settings': {
                SettingsKeys.appearance: jsonEncode(
                  const AppearanceSettings(
                    themeMode: ThemeMode.dark,
                    gameTheme: GameThemeId.neon,
                  ).toJson(),
                ),
              },
              'profile': {
                ProfileKeys.player: jsonEncode(
                  testProfile.copyWith(name: 'Nova').toJson(),
                ),
              },
            },
          ),
        ),
        appVersion: '1.0.0',
        formatVersion: 1,
      );
    await tester.pumpMathStrikeAppAtSplash(linked: false, drive: drive);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back, Nova!'), findsOneWidget);

    await waitForOutcomeHold(tester);
    expect(tester.currentLocation, AppRoutes.home);
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark, reason: 'restored settings applied');
  });

  testWidgets('cancelling sign-in explains why an account is needed', (
    tester,
  ) async {
    final gateway = FakeGoogleAuthGateway(
      signInError: const AuthCancelledException(),
    );
    await tester.pumpMathStrikeAppAtSplash(linked: false, gateway: gateway);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(tester.currentLocation, AppRoutes.signIn);
    expect(find.textContaining('A Google account is needed'), findsOneWidget);

    gateway.signInError = null;
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();
    expect(tester.currentLocation, AppRoutes.accountSetup);
  });

  testWidgets('offline sign-in shows a clear message', (tester) async {
    await tester.pumpMathStrikeAppAtSplash(
      linked: false,
      gateway: FakeGoogleAuthGateway(
        signInError: const NetworkException('offline'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(find.textContaining('internet connection'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('Drive unreachable: retry, or continue without restoring', (
    tester,
  ) async {
    final drive = InMemoryBackupDataSource()
      ..failWith = const NetworkException('offline');
    await tester.pumpMathStrikeAppAtSplash(linked: false, drive: drive);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(find.text("We couldn't check for a backup"), findsOneWidget);

    await tester.tap(find.text('Continue without restoring'));
    await tester.pumpAndSettle();
    expect(find.text('Continue without restoring?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(tester.currentLocation, AppRoutes.onboarding);
  });

  testWidgets('sign-in and restore screens fit 200% text on a small phone', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpMathStrikeAppAtSplash(
      linked: false,
      size: const Size(360, 640),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await waitForOutcomeHold(tester);
  });

  testWidgets('a backup from before profiles existed leads to onboarding', (
    tester,
  ) async {
    final drive = InMemoryBackupDataSource()
      ..seed(
        const BackupSnapshotCodec().encode(
          BackupSnapshot(
            formatVersion: 1,
            createdAt: DateTime.utc(2026),
            appVersion: '0.3.0',
            boxes: const {'settings': {}},
          ),
        ),
        appVersion: '0.3.0',
        formatVersion: 1,
      );
    await tester.pumpMathStrikeAppAtSplash(linked: false, drive: drive);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back!'), findsOneWidget);

    await waitForOutcomeHold(tester);
    expect(tester.currentLocation, AppRoutes.onboarding);
  });

  testWidgets('a linked player starts offline without signing in again', (
    tester,
  ) async {
    final gateway = FakeGoogleAuthGateway(
      restoreError: const NetworkException('offline'),
    );
    await tester.pumpMathStrikeAppAtSplash(gateway: gateway);
    await tester.pumpAndSettle();

    expect(tester.currentLocation, AppRoutes.home);
    expect(gateway.signInCalls, 0);
  });
}

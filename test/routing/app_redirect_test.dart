import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/features/authentication/domain/entities/account_link.dart';
import 'package:math_strike/routing/app_gate.dart';
import 'package:math_strike/routing/app_routes.dart';

void main() {
  String? redirect(String location, AppGate gate) =>
      appRedirect(uri: Uri.parse(location), gate: gate);

  const starting = AppGate();
  const unlinked = AppGate(startupCompleted: true);
  const restoreCheck = AppGate(
    startupCompleted: true,
    stage: AccountSetupStage.restoreCheck,
  );
  const onboarding = AppGate(
    startupCompleted: true,
    stage: AccountSetupStage.onboarding,
  );
  const ready = AppGate(
    startupCompleted: true,
    stage: AccountSetupStage.complete,
    hasProfile: true,
  );
  const completeWithoutProfile = AppGate(
    startupCompleted: true,
    stage: AccountSetupStage.complete,
  );

  group('during start-up', () {
    test('stays on the splash', () {
      expect(redirect(AppRoutes.splash, starting), isNull);
    });

    test('sends other locations to the splash, remembering them', () {
      expect(redirect('/settings', starting), '/splash?from=%2Fsettings');
    });
  });

  group('first launch', () {
    test('unlinked players must sign in, wherever they were going', () {
      for (final location in [
        '/splash?from=%2Fsettings',
        AppRoutes.home,
        AppRoutes.accountSetup,
      ]) {
        expect(
          redirect(location, unlinked),
          AppRoutes.signIn,
          reason: location,
        );
      }
      expect(redirect(AppRoutes.signIn, unlinked), isNull);
    });

    test('after sign-in the backup check is required', () {
      expect(redirect(AppRoutes.signIn, restoreCheck), AppRoutes.accountSetup);
      expect(redirect(AppRoutes.home, restoreCheck), AppRoutes.accountSetup);
      expect(redirect(AppRoutes.accountSetup, restoreCheck), isNull);
    });

    test('without a restored backup, onboarding is required', () {
      expect(
        redirect(AppRoutes.accountSetup, onboarding),
        AppRoutes.onboarding,
      );
      expect(redirect(AppRoutes.shop, onboarding), AppRoutes.onboarding);
      expect(redirect(AppRoutes.onboarding, onboarding), isNull);
    });
  });

  test('a missing profile (old backup, reset) leads to onboarding', () {
    expect(
      redirect(AppRoutes.home, completeWithoutProfile),
      AppRoutes.onboarding,
    );
    expect(redirect(AppRoutes.onboarding, completeWithoutProfile), isNull);
  });

  group('set-up complete', () {
    test('leaves app locations alone', () {
      expect(redirect(AppRoutes.shop, ready), isNull);
    });

    test('gate routes forward to the remembered location or home', () {
      expect(redirect('/splash?from=%2Fsettings', ready), '/settings');
      expect(redirect(AppRoutes.splash, ready), AppRoutes.home);
      expect(redirect(AppRoutes.signIn, ready), AppRoutes.home);
      expect(redirect(AppRoutes.onboarding, ready), AppRoutes.home);
    });

    test('rejects unsafe or looping return targets', () {
      for (final from in [
        'https://evil.example',
        '//evil.example',
        '/splash',
        '/sign-in?x=1',
      ]) {
        final location = Uri(
          path: AppRoutes.splash,
          queryParameters: {AppRoutes.fromParam: from},
        ).toString();
        expect(redirect(location, ready), AppRoutes.home, reason: from);
      }
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/errors/failure.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/features/authentication/authentication_providers.dart';
import 'package:math_strike/features/authentication/domain/entities/account_link.dart';
import 'package:math_strike/features/authentication/domain/entities/google_account.dart';
import 'package:math_strike/features/authentication/presentation/controllers/account_controller.dart';

import '../../helpers/fake_google_auth_gateway.dart';
import '../../helpers/test_app.dart';

void main() {
  test('starts unlinked on a fresh install', () {
    final container = createTestContainer();
    expect(container.read(accountControllerProvider), isNull);
  });

  test('sign-in links the device and starts the restore check', () async {
    final db = InMemoryLocalDatabase();
    final container = createTestContainer(database: db);

    final result = await container
        .read(accountControllerProvider.notifier)
        .signIn();

    expect(result.isSuccess, isTrue);
    final link = container.read(accountControllerProvider)!;
    expect(link.account, FakeGoogleAuthGateway.defaultAccount);
    expect(link.stage, AccountSetupStage.restoreCheck);
    // Persisted: a new container (= next launch) sees the link.
    final relaunched = createTestContainer(database: db);
    expect(relaunched.read(accountControllerProvider), link);
  });

  test('re-signing into the same account keeps setup progress', () async {
    final db = InMemoryLocalDatabase();
    await linkTestAccount(db);
    final container = createTestContainer(database: db);

    await container.read(accountControllerProvider.notifier).signIn();

    expect(
      container.read(accountControllerProvider)!.stage,
      AccountSetupStage.complete,
    );
  });

  test('a different account starts setup again', () async {
    final db = InMemoryLocalDatabase();
    await linkTestAccount(db);
    final container = createTestContainer(
      database: db,
      gateway: FakeGoogleAuthGateway(
        account: const GoogleAccount(id: 'other', email: 'other@example.com'),
      ),
    );

    await container.read(accountControllerProvider.notifier).signIn();

    final link = container.read(accountControllerProvider)!;
    expect(link.account.id, 'other');
    expect(link.stage, AccountSetupStage.restoreCheck);
  });

  test('a cancelled sign-in does not link the device', () async {
    final container = createTestContainer(
      gateway: FakeGoogleAuthGateway(
        signInError: const AuthCancelledException(),
      ),
    );

    final result = await container
        .read(accountControllerProvider.notifier)
        .signIn();

    expect(result.failureOrNull, isA<AuthCancelledFailure>());
    expect(container.read(accountControllerProvider), isNull);
  });

  test('advanceTo moves through the setup stages', () async {
    final container = createTestContainer();
    final controller = container.read(accountControllerProvider.notifier);
    await controller.signIn();

    await controller.advanceTo(AccountSetupStage.onboarding);

    expect(
      container.read(accountControllerProvider)!.stage,
      AccountSetupStage.onboarding,
    );
  });

  test('authorizer reports an expired session as an auth error', () async {
    final container = createTestContainer(); // fake gateway: no client
    await expectLater(
      container.read(googleApiAuthorizerProvider).authorizedClient(),
      throwsA(isA<AuthException>()),
    );
  });
}

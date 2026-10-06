import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../authentication_providers.dart';
import '../../domain/entities/account_link.dart';
import '../../domain/entities/google_account.dart';

part 'account_controller.g.dart';

/// The account this installation is linked to, and the first-launch setup
/// stage. Drives the router's sign-in / setup gates.
///
/// Requires an opened database: only read it after start-up completes.
@Riverpod(keepAlive: true)
class AccountController extends _$AccountController {
  @override
  AccountLink? build() => ref.watch(accountLinkRepositoryProvider).load();

  /// Interactive Google sign-in. On success the device is linked to the
  /// account; re-signing into the *same* account keeps its setup progress.
  Future<Result<GoogleAccount>> signIn() async {
    final result = await ref.read(authRepositoryProvider).signIn();
    if (result case Success(value: final account)) {
      final current = state;
      final link = current != null && current.account.id == account.id
          ? current.copyWith(account: account)
          : AccountLink(account: account, linkedAt: DateTime.now().toUtc());
      final saved = await _save(link);
      if (saved case Err(:final failure)) return Err(failure);
      ref
          .read(appLoggerProvider)
          .info('Linked Google account (stage ${link.stage.name})');
    }
    return result;
  }

  /// Moves first-launch setup to [stage].
  Future<Result<void>> advanceTo(AccountSetupStage stage) async {
    final current = state;
    if (current == null) return const Success(null);
    return _save(current.copyWith(stage: stage));
  }

  Future<Result<void>> _save(AccountLink link) async {
    final result = await ref.read(accountLinkRepositoryProvider).save(link);
    if (result.isSuccess && ref.mounted) state = link;
    return result;
  }
}

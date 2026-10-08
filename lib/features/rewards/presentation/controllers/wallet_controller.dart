import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/reward.dart';
import '../../domain/entities/wallet.dart';
import '../../rewards_providers.dart';

part 'wallet_controller.g.dart';

/// The player's coins, diamonds and experience.
///
/// Requires an opened database: only read it after start-up completes.
@Riverpod(keepAlive: true)
class WalletController extends _$WalletController {
  @override
  Wallet build() {
    // Reload when local data is replaced (restore / reset).
    ref.watch(localDataEpochProvider);
    return ref.watch(rewardsRepositoryProvider).loadWallet();
  }

  /// Adds [reward] to the wallet and saves it (gameplay, achievements).
  Future<Result<void>> credit(Reward reward) async {
    final updated = state.credit(reward);
    final result = await ref
        .read(rewardsRepositoryProvider)
        .saveWallet(updated);
    if (result.isSuccess && ref.mounted) state = updated;
    return result;
  }

  /// Publishes a wallet that has already been saved elsewhere (e.g. as part
  /// of a daily claim).
  void applySaved(Wallet wallet) => state = wallet;
}

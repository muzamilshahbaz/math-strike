import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/animated_count.dart';
import '../../domain/entities/reward.dart';
import '../controllers/wallet_controller.dart';

/// The kinds of value a [Reward] can contain, with their visual identity.
enum Currency {
  /// Soft currency, earned by playing.
  coins(Icons.monetization_on_rounded, 'coin', 'coins'),

  /// Premium currency.
  diamonds(Icons.diamond_rounded, 'diamond', 'diamonds'),

  /// Experience points.
  xp(Icons.bolt_rounded, 'XP', 'XP');

  const Currency(this.icon, this._singular, this._plural);

  /// Icon shown next to amounts.
  final IconData icon;

  final String _singular;
  final String _plural;

  /// The theme colour for this currency.
  Color color(BuildContext context) {
    final palette = context.gamePalette;
    return switch (this) {
      Currency.coins => palette.coin,
      Currency.diamonds => palette.diamond,
      Currency.xp => palette.xp,
    };
  }

  /// "1 coin", "250 coins".
  String describe(int amount) =>
      '${formatCount(amount)} ${amount == 1 ? _singular : _plural}';

  /// The amount of this currency in [reward].
  int amountIn(Reward reward) => switch (this) {
    Currency.coins => reward.coins,
    Currency.diamonds => reward.diamonds,
    Currency.xp => reward.xp,
  };
}

/// Describes a reward for people and screen readers: "100 coins, 25 XP".
String describeReward(Reward reward) => [
  for (final currency in Currency.values)
    if (currency.amountIn(reward) > 0)
      currency.describe(currency.amountIn(reward)),
].join(', ');

/// A pill showing a currency balance that counts up when it changes.
class CurrencyChip extends StatelessWidget {
  /// Creates the chip.
  const CurrencyChip({required this.currency, required this.amount, super.key});

  /// Which currency.
  final Currency currency;

  /// Balance to show.
  final int amount;

  @override
  Widget build(BuildContext context) {
    final color = currency.color(context);
    return Semantics(
      label: currency.describe(amount),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xs + 2,
          AppSpacing.xs,
          AppSpacing.smd,
          AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: const BorderRadius.all(AppRadii.pill),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(currency.icon, size: 20, color: color),
            const SizedBox(width: AppSpacing.xs),
            AnimatedCount(
              value: amount,
              style: context.textStyles.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The player's coin and diamond balances, for app bars.
class WalletBar extends ConsumerWidget {
  /// Creates the bar.
  const WalletBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletControllerProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurrencyChip(currency: Currency.coins, amount: wallet.coins),
        const SizedBox(width: AppSpacing.sm),
        CurrencyChip(currency: Currency.diamonds, amount: wallet.diamonds),
      ],
    );
  }
}

/// The non-zero parts of a [reward] as icon + amount pairs.
class RewardAmounts extends StatelessWidget {
  /// Creates the list.
  const RewardAmounts({
    required this.reward,
    this.iconSize = 18,
    this.style,
    this.direction = Axis.horizontal,
    super.key,
  });

  /// What to show.
  final Reward reward;

  /// Icon size.
  final double iconSize;

  /// Text style for the amounts.
  final TextStyle? style;

  /// Layout direction.
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        style ??
        context.textStyles.labelLarge?.copyWith(fontWeight: FontWeight.w700);
    return Semantics(
      label: describeReward(reward),
      excludeSemantics: true,
      child: Wrap(
        direction: direction,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.xs,
        children: [
          for (final currency in Currency.values)
            if (currency.amountIn(reward) > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    currency.icon,
                    size: iconSize,
                    color: currency.color(context),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    child: Text(
                      formatCount(currency.amountIn(reward)),
                      style: textStyle,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

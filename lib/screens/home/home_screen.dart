import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../features/rewards/presentation/widgets/currency.dart';
import '../../features/rewards/presentation/widgets/daily_reward_card.dart';
import 'widgets/player_header.dart';
import 'widgets/practice_card.dart';
import 'widgets/quick_play_card.dart';
import 'widgets/today_snapshot.dart';

/// The home dashboard: who you are, how far you've come, today's reward and
/// a one-tap way into a game.
///
/// One column on phones; two columns once there is room (≥ 840dp of
/// content width), so desktop windows don't stretch cards edge to edge.
class HomeScreen extends ConsumerWidget {
  /// Creates the dashboard.
  const HomeScreen({super.key});

  /// Content width from which the dashboard uses two columns.
  static const double twoColumnWidth = 840;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          // Large balances or text sizes shrink to fit beside the title.
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.6,
            ),
            child: const FittedBox(fit: BoxFit.scaleDown, child: WalletBar()),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const gap = SizedBox.square(dimension: AppSpacing.md);
          final content = constraints.maxWidth >= twoColumnWidth
              ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PlayerHeader(),
                          gap,
                          QuickPlayCard(),
                          gap,
                          PracticeCard(),
                        ],
                      ),
                    ),
                    gap,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [DailyRewardCard(), gap, TodaySnapshot()],
                      ),
                    ),
                  ],
                )
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PlayerHeader(),
                    gap,
                    QuickPlayCard(),
                    gap,
                    DailyRewardCard(),
                    gap,
                    PracticeCard(),
                    gap,
                    TodaySnapshot(),
                  ],
                );
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: content,
              ),
            ),
          );
        },
      ),
    );
  }
}

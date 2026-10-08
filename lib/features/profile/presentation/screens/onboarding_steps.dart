import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/game_theme_id.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/selectable_card.dart';
import '../../../settings/presentation/controllers/appearance_controller.dart';
import '../../domain/entities/age_group.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/entities/player_profile.dart';
import '../avatars/avatar_catalog.dart';
import '../avatars/avatar_view.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/player_card.dart';

/// Renders the content of one onboarding [step].
class OnboardingStepView extends StatelessWidget {
  /// Creates the view.
  const OnboardingStepView({required this.step, super.key});

  /// Step to show.
  final OnboardingStep step;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.xl,
      AppSpacing.lg,
      AppSpacing.lg,
    ),
    child: switch (step) {
      OnboardingStep.name => const _NameStep(),
      OnboardingStep.avatar => const _AvatarStep(),
      OnboardingStep.age => const _AgeStep(),
      OnboardingStep.difficulty => const _DifficultyStep(),
      OnboardingStep.theme => const _ThemeStep(),
      OnboardingStep.sound => const _SoundStep(),
      OnboardingStep.summary => const _SummaryStep(),
    },
  );
}

class _StepHeading extends StatelessWidget {
  const _StepHeading({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Semantics(
        header: true,
        child: Text(title, style: context.textStyles.headlineMedium),
      ),
      if (subtitle != null) ...[
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle!,
          style: context.textStyles.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
      const SizedBox(height: AppSpacing.lg),
    ],
  );
}

// ---------------------------------------------------------------- name ---

class _NameStep extends ConsumerStatefulWidget {
  const _NameStep();

  @override
  ConsumerState<_NameStep> createState() => _NameStepState();
}

class _NameStepState extends ConsumerState<_NameStep> {
  late final TextEditingController _text = TextEditingController(
    text: ref.read(onboardingControllerProvider).name,
  );
  final FocusNode _focus = FocusNode(debugLabel: 'player name');
  bool _edited = false;

  @override
  void initState() {
    super.initState();
    // Requested after the first frame so it wins over the screen-level
    // keyboard-shortcut focus.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _text.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: AvatarView(
            avatar: AvatarCatalog.byId(state.avatarId),
            size: 104,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _StepHeading(
          title: 'Welcome, space cadet!',
          subtitle: 'What should we call you?',
        ),
        TextField(
          controller: _text,
          focusNode: _focus,
          maxLength: PlayerProfile.maxNameLength,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.givenName],
          style: context.textStyles.titleLarge,
          decoration: InputDecoration(
            labelText: 'Player name',
            prefixIcon: const Icon(Icons.badge_rounded),
            errorText: _edited ? state.nameError : null,
          ),
          onChanged: (value) {
            setState(() => _edited = true);
            controller.setName(value);
          },
          onSubmitted: (_) {
            setState(() => _edited = true);
            controller.next();
          },
        ),
        Text(
          'Shown on your profile and leaderboards. You can change it later.',
          style: context.textStyles.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------- avatar ---

class _AvatarStep extends ConsumerWidget {
  const _AvatarStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      onboardingControllerProvider.select((s) => s.avatarId),
    );
    final controller = ref.read(onboardingControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeading(
          title: 'Pick your Striker',
          subtitle: 'More characters unlock as you play.',
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = (constraints.maxWidth / 110).floor().clamp(3, 6);
            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.smd,
              crossAxisSpacing: AppSpacing.smd,
              childAspectRatio: 0.82,
              children: [
                for (final avatar in AvatarCatalog.starters)
                  SelectableCard(
                    selected: avatar.id == selected,
                    semanticLabel: avatar.name,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    onTap: () => controller.setAvatar(avatar.id),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: LayoutBuilder(
                            builder: (context, box) => AvatarView(
                              avatar: avatar,
                              size: box.biggest.shortestSide,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          avatar.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textStyles.labelLarge,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ----------------------------------------------------------------- age ---

class _AgeStep extends ConsumerWidget {
  const _AgeStep();

  static const Map<AgeGroup, IconData> _icons = {
    AgeGroup.preschool: Icons.child_care_rounded,
    AgeGroup.earlyPrimary: Icons.backpack_rounded,
    AgeGroup.latePrimary: Icons.school_rounded,
    AgeGroup.teen: Icons.headphones_rounded,
    AgeGroup.adult: Icons.work_rounded,
    AgeGroup.custom: Icons.tune_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      onboardingControllerProvider.select((s) => s.ageGroup),
    );
    final controller = ref.read(onboardingControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeading(
          title: 'How old are you?',
          subtitle: 'So we can pick the right kind of math for you.',
        ),
        for (final group in AgeGroup.values)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.smd),
            child: SelectableCard(
              selected: group == selected,
              onTap: () => controller.setAgeGroup(group),
              child: _OptionRow(
                icon: _icons[group]!,
                title: group.label,
                subtitle: group.description,
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------- difficulty ---

class _DifficultyStep extends ConsumerWidget {
  const _DifficultyStep();

  static const Map<Difficulty, IconData> _icons = {
    Difficulty.easy: Icons.spa_rounded,
    Difficulty.medium: Icons.directions_run_rounded,
    Difficulty.hard: Icons.local_fire_department_rounded,
    Difficulty.expert: Icons.bolt_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final recommended = state.ageGroup?.recommendedDifficulty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeading(
          title: 'Choose your challenge',
          subtitle: "Don't worry — Math Strike adapts as you play.",
        ),
        for (final difficulty in Difficulty.values)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.smd),
            child: SelectableCard(
              selected: difficulty == state.difficulty,
              onTap: () => controller.setDifficulty(difficulty),
              child: _OptionRow(
                icon: _icons[difficulty]!,
                title: difficulty.label,
                subtitle: difficulty.description,
                badge: difficulty == recommended ? 'Recommended' : null,
              ),
            ),
          ),
      ],
    );
  }
}

// --------------------------------------------------------------- theme ---

class _ThemeStep extends ConsumerWidget {
  const _ThemeStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appearance = ref.watch(appearanceControllerProvider);
    final controller = ref.read(appearanceControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeading(
          title: 'Choose your look',
          subtitle: 'Changes apply instantly. Unlock more themes later.',
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.smd,
          crossAxisSpacing: AppSpacing.smd,
          childAspectRatio: 1.5,
          children: [
            for (final theme in GameThemeId.starters)
              SelectableCard(
                selected: appearance.gameTheme == theme,
                semanticLabel: '${theme.label} theme',
                padding: EdgeInsets.zero,
                onTap: () => unawaited(controller.setGameTheme(theme)),
                child: _ThemeSwatch(theme: theme),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_rounded),
                label: Text('Light'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_rounded),
                label: Text('Dark'),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto_rounded),
                label: Text('Auto'),
              ),
            ],
            selected: {appearance.themeMode},
            onSelectionChanged: (s) =>
                unawaited(controller.setThemeMode(s.first)),
          ),
        ),
      ],
    );
  }
}

/// A mini preview of a theme's generated colour scheme.
class _ThemeSwatch extends StatelessWidget {
  const _ThemeSwatch({required this.theme});

  final GameThemeId theme;

  @override
  Widget build(BuildContext context) {
    final scheme = AppTheme.build(
      seedColor: theme.seedColor,
      brightness: Theme.of(context).brightness,
    ).colorScheme;
    return ClipRRect(
      borderRadius: AppRadii.mdAll,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [scheme.primary, scheme.tertiary],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(theme.icon, color: scheme.onPrimary, size: 28),
                const Spacer(),
                Text(
                  theme.label,
                  style: context.textStyles.titleMedium?.copyWith(
                    color: scheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------- sound ---

class _SoundStep extends ConsumerWidget {
  const _SoundStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StepHeading(
          title: 'Sound check',
          subtitle: 'You can change these any time in Settings.',
        ),
        _ToggleCard(
          icon: Icons.volume_up_rounded,
          offIcon: Icons.volume_off_rounded,
          title: 'Sound effects',
          subtitle: 'Blasts, hits and power-ups',
          value: state.soundEnabled,
          onChanged: (v) => controller.setSound(enabled: v),
        ),
        const SizedBox(height: AppSpacing.smd),
        _ToggleCard(
          icon: Icons.music_note_rounded,
          offIcon: Icons.music_off_rounded,
          title: 'Music',
          subtitle: 'Background tracks while you play',
          value: state.musicEnabled,
          onChanged: (v) => controller.setMusic(enabled: v),
        ),
      ],
    );
  }
}

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.icon,
    required this.offIcon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final IconData offIcon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Card(
    child: SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      secondary: Icon(
        value ? icon : offIcon,
        size: 32,
        color: value ? context.colors.primary : context.colors.outline,
      ),
      title: Text(title, style: context.textStyles.titleMedium),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    ),
  );
}

// ------------------------------------------------------------- summary ---

class _SummaryStep extends ConsumerWidget {
  const _SummaryStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final theme = ref.watch(
      appearanceControllerProvider.select((a) => a.gameTheme),
    );
    final name = PlayerProfile.normalizeName(state.name);
    return Column(
      children: [
        Semantics(
          header: true,
          child: Text(
            "You're all set, $name!",
            textAlign: TextAlign.center,
            style: context.textStyles.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Here is your player card.',
          textAlign: TextAlign.center,
          style: context.textStyles.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.85, end: 1),
          duration: context.motion(const Duration(milliseconds: 700)),
          curve: Curves.elasticOut,
          builder: (context, scale, child) =>
              Transform.scale(scale: scale, child: child),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: PlayerCard(
              avatar: AvatarCatalog.byId(state.avatarId),
              name: name,
              ageGroup: state.ageGroup,
              difficulty: state.difficulty,
              avatarSize: 128,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            Chip(avatar: Icon(theme.icon, size: 18), label: Text(theme.label)),
            Chip(
              avatar: Icon(
                state.soundEnabled
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                size: 18,
              ),
              label: Text(state.soundEnabled ? 'Sound on' : 'Sound off'),
            ),
            Chip(
              avatar: Icon(
                state.musicEnabled
                    ? Icons.music_note_rounded
                    : Icons.music_off_rounded,
                size: 18,
              ),
              label: Text(state.musicEnabled ? 'Music on' : 'Music off'),
            ),
          ],
        ),
        if (state.errorMessage case final message?) ...[
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            liveRegion: true,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.colors.error),
            ),
          ),
        ],
      ],
    );
  }
}

// -------------------------------------------------------------- shared ---

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: const EdgeInsets.all(AppSpacing.smd),
        decoration: BoxDecoration(
          color: context.colors.secondaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: context.colors.onSecondaryContainer),
      ),
      const SizedBox(width: AppSpacing.md),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(title, style: context.textStyles.titleMedium),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.tertiaryContainer,
                      borderRadius: const BorderRadius.all(AppRadii.pill),
                    ),
                    child: Text(
                      badge!,
                      style: context.textStyles.labelSmall?.copyWith(
                        color: context.colors.onTertiaryContainer,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: context.textStyles.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      // Room for the selection badge.
      const SizedBox(width: AppSpacing.lg),
    ],
  );
}

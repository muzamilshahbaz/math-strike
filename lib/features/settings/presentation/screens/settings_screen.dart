import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/game_theme_id.dart';
import '../../../../core/theme/theme_context.dart';
import '../../domain/entities/appearance_settings.dart';
import '../controllers/appearance_controller.dart';

/// Settings screen.
///
/// Phase 1 ships the Appearance and Accessibility sections (they exercise
/// the theme system end-to-end). Audio, language, backup, privacy, about
/// and reset sections are added in Phase 11.
class SettingsScreen extends ConsumerWidget {
  /// Creates the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appearanceControllerProvider);
    final controller = ref.read(appearanceControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              const _SectionHeader('Appearance'),
              _SettingsCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
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
                      selected: {settings.themeMode},
                      onSelectionChanged: (s) =>
                          controller.setThemeMode(s.first),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final theme in GameThemeId.values)
                          ChoiceChip(
                            avatar: Icon(theme.icon, color: theme.seedColor),
                            label: Text(theme.label),
                            selected: settings.gameTheme == theme,
                            onSelected: (_) => controller.setGameTheme(theme),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const _SectionHeader('Accessibility'),
              _SettingsCard(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.contrast_rounded),
                    title: const Text('High contrast'),
                    value: settings.highContrast,
                    onChanged: (v) => controller.setHighContrast(enabled: v),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.animation_rounded),
                    title: const Text('Reduce motion'),
                    subtitle: const Text('Fewer animations and effects'),
                    value: settings.reduceMotion,
                    onChanged: (v) => controller.setReduceMotion(enabled: v),
                  ),
                  ListTile(
                    leading: const Icon(Icons.format_size_rounded),
                    title: const Text('Text size'),
                    trailing: Text('${(settings.textScale * 100).round()}%'),
                  ),
                  Slider(
                    value: settings.textScale,
                    min: AppearanceSettings.minTextScale,
                    max: AppearanceSettings.maxTextScale,
                    divisions: 15,
                    label: '${(settings.textScale * 100).round()}%',
                    semanticFormatterCallback: (v) =>
                        'Text size ${(v * 100).round()} percent',
                    onChanged: controller.setTextScale,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.sm,
      AppSpacing.lg,
      AppSpacing.sm,
      AppSpacing.sm,
    ),
    child: Semantics(
      header: true,
      child: Text(
        title,
        style: context.textStyles.titleSmall?.copyWith(
          color: context.colors.primary,
        ),
      ),
    ),
  );
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

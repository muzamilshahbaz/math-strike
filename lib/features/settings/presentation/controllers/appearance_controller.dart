import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/theme/game_theme_id.dart';
import '../../domain/entities/appearance_settings.dart';
import '../../settings_providers.dart';

part 'appearance_controller.g.dart';

/// Holds the current [AppearanceSettings] and persists every change.
///
/// Updates are optimistic: the UI changes immediately and reverts if the
/// write fails.
@Riverpod(keepAlive: true)
class AppearanceController extends _$AppearanceController {
  @override
  AppearanceSettings build() => ref.watch(appearanceRepositoryProvider).load();

  /// Sets light / dark / system mode.
  Future<void> setThemeMode(ThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  /// Applies a visual theme.
  Future<void> setGameTheme(GameThemeId theme) =>
      _update(state.copyWith(gameTheme: theme));

  /// Toggles the high-contrast colour scheme.
  Future<void> setHighContrast({required bool enabled}) =>
      _update(state.copyWith(highContrast: enabled));

  /// Toggles reduced motion.
  Future<void> setReduceMotion({required bool enabled}) =>
      _update(state.copyWith(reduceMotion: enabled));

  /// Sets the text scale, clamped to the supported range.
  Future<void> setTextScale(double scale) => _update(
    state.copyWith(
      textScale: scale.clamp(
        AppearanceSettings.minTextScale,
        AppearanceSettings.maxTextScale,
      ),
    ),
  );

  Future<void> _update(AppearanceSettings next) async {
    if (next == state) return;
    final previous = state;
    state = next;
    final result = await ref.read(appearanceRepositoryProvider).save(next);
    if (result case Err(:final failure)) {
      ref.read(appLoggerProvider).error('Saving appearance failed: $failure');
      state = previous;
    }
  }
}

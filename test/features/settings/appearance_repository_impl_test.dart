import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/errors/result.dart';
import 'package:math_strike/core/services/logging/app_logger.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/theme/game_theme_id.dart';
import 'package:math_strike/features/settings/data/repositories/appearance_repository_impl.dart';
import 'package:math_strike/features/settings/domain/entities/appearance_settings.dart';

void main() {
  AppearanceRepositoryImpl repo(InMemoryKeyValueStore store) =>
      AppearanceRepositoryImpl(store: store, logger: const SilentAppLogger());

  test('returns defaults when nothing is saved', () {
    expect(repo(InMemoryKeyValueStore()).load(), const AppearanceSettings());
  });

  test('saves and reloads settings', () async {
    final store = InMemoryKeyValueStore();
    const settings = AppearanceSettings(
      themeMode: ThemeMode.dark,
      gameTheme: GameThemeId.neon,
      highContrast: true,
      textScale: 1.3,
    );

    expect(await repo(store).save(settings), isA<Success<void>>());
    expect(repo(store).load(), settings);
  });

  test('falls back to defaults for corrupt data', () {
    final store = InMemoryKeyValueStore({SettingsKeys.appearance: '%%%'});
    expect(repo(store).load(), const AppearanceSettings());
  });

  test('tolerates unknown enum values from newer app versions', () {
    final store = InMemoryKeyValueStore({
      SettingsKeys.appearance:
          '{"themeMode":"sepia","gameTheme":"volcano","highContrast":true}',
    });
    final loaded = repo(store).load();
    expect(loaded.themeMode, ThemeMode.system);
    expect(loaded.gameTheme, GameThemeId.space);
    expect(loaded.highContrast, isTrue);
  });
}

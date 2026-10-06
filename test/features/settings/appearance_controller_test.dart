import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/failure.dart';
import 'package:math_strike/core/errors/result.dart';
import 'package:math_strike/core/theme/game_theme_id.dart';
import 'package:math_strike/features/settings/domain/entities/appearance_settings.dart';
import 'package:math_strike/features/settings/domain/repositories/appearance_repository.dart';
import 'package:math_strike/features/settings/presentation/controllers/appearance_controller.dart';
import 'package:math_strike/features/settings/settings_providers.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app.dart';

class _MockAppearanceRepository extends Mock implements AppearanceRepository {}

void main() {
  setUpAll(() => registerFallbackValue(const AppearanceSettings()));

  test('changes are applied and persisted', () async {
    final container = createTestContainer();
    final controller = container.read(appearanceControllerProvider.notifier);

    await controller.setThemeMode(ThemeMode.dark);
    await controller.setGameTheme(GameThemeId.ocean);

    expect(
      container.read(appearanceControllerProvider),
      const AppearanceSettings(
        themeMode: ThemeMode.dark,
        gameTheme: GameThemeId.ocean,
      ),
    );
    expect(
      container.read(appearanceRepositoryProvider).load().gameTheme,
      GameThemeId.ocean,
    );
  });

  test('text scale is clamped to the supported range', () async {
    final container = createTestContainer();
    await container.read(appearanceControllerProvider.notifier).setTextScale(5);
    expect(
      container.read(appearanceControllerProvider).textScale,
      AppearanceSettings.maxTextScale,
    );
  });

  test('reverts the optimistic update when saving fails', () async {
    final repo = _MockAppearanceRepository();
    when(repo.load).thenReturn(const AppearanceSettings());
    when(() => repo.save(any()))
        .thenAnswer((_) async => const Err(Failure.storage('disk full')));
    final container = createTestContainer(
      overrides: [appearanceRepositoryProvider.overrideWithValue(repo)],
    );

    await container
        .read(appearanceControllerProvider.notifier)
        .setReduceMotion(enabled: true);

    expect(container.read(appearanceControllerProvider).reduceMotion, isFalse);
  });
}

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../domain/entities/appearance_settings.dart';
import 'appearance_controller.dart';

part 'effective_appearance.g.dart';

/// The appearance the app should render with right now.
///
/// Defaults until the local database is open (the splash screen is drawn
/// with fixed brand colours, so the switch is not visible), then the
/// player's saved settings.
@Riverpod(keepAlive: true)
AppearanceSettings effectiveAppearance(Ref ref) {
  final database = ref.watch(openedLocalDatabaseProvider);
  return database.hasValue
      ? ref.watch(appearanceControllerProvider)
      : const AppearanceSettings();
}

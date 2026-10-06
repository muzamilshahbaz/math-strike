import 'package:flutter/material.dart';

import 'app_tokens.dart';
import 'game_palette.dart';

/// Builds the Material 3 [ThemeData] for the app.
///
/// A single design language is produced from three inputs â€” a seed colour
/// (the selected [GameThemeId]), brightness and a high-contrast flag â€” so
/// every theme, platform and accessibility mode shares the same component
/// styling.
abstract final class AppTheme {
  /// Builds a theme for [brightness] generated from [seedColor].
  static ThemeData build({
    required Color seedColor,
    required Brightness brightness,
    bool highContrast = false,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
      contrastLevel: highContrast ? 1.0 : 0.0,
    );
    final isDark = brightness == Brightness.dark;
    final textTheme = _textTheme(
      isDark
          ? Typography.material2021().white
          : Typography.material2021().black,
    ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: [
        if (isDark)
          GamePalette.dark(highContrast: highContrast)
        else
          GamePalette.light(highContrast: highContrast),
      ],
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (final platform in TargetPlatform.values)
            platform: const FadeForwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainer,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.lgAll),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(style: _buttonStyle(textTheme)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _buttonStyle(textTheme),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _buttonStyle(textTheme),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(
            AppSizes.minTouchTarget,
            AppSizes.minTouchTarget,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: const OutlineInputBorder(
          borderRadius: AppRadii.mdAll,
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.smd,
        ),
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(AppRadii.sm),
        ),
      ),
      dialogTheme: const DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadii.lgAll),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: AppRadii.lg),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.mdAll),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        indicatorColor: scheme.primaryContainer,
        selectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: scheme.onSurface,
        ),
        unselectedLabelTextStyle: textTheme.labelLarge?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      ),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 400),
      ),
    );
  }

  /// Heavier, more playful weights than the Material defaults. Fonts will
  /// be bundled (not downloaded) in Phase 17 to keep the app offline.
  static TextTheme _textTheme(TextTheme base) => base.copyWith(
    displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w800),
    displayMedium: base.displayMedium?.copyWith(fontWeight: FontWeight.w800),
    displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w800),
    headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
    headlineMedium: base.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
    headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
    titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w700),
  );

  static ButtonStyle _buttonStyle(TextTheme textTheme) => ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(
      Size(AppSizes.minTouchTarget * 2, AppSizes.minTouchTarget),
    ),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.smd),
    ),
    shape: const WidgetStatePropertyAll(StadiumBorder()),
    textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
  );
}

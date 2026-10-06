import 'package:flutter/material.dart';

/// Spacing scale (4-pt grid). Use these instead of magic numbers.
abstract final class AppSpacing {
  /// 4
  static const double xs = 4;

  /// 8
  static const double sm = 8;

  /// 12
  static const double smd = 12;

  /// 16
  static const double md = 16;

  /// 24
  static const double lg = 24;

  /// 32
  static const double xl = 32;

  /// 48
  static const double xxl = 48;
}

/// Corner radius scale.
abstract final class AppRadii {
  /// Chips, small controls.
  static const Radius sm = Radius.circular(8);

  /// Inputs, list tiles.
  static const Radius md = Radius.circular(16);

  /// Cards, sheets, dialogs.
  static const Radius lg = Radius.circular(24);

  /// Fully rounded (buttons, pills).
  static const Radius pill = Radius.circular(999);

  /// [md] on every corner.
  static const BorderRadius mdAll = BorderRadius.all(md);

  /// [lg] on every corner.
  static const BorderRadius lgAll = BorderRadius.all(lg);
}

/// Minimum interactive target sizes (accessibility).
abstract final class AppSizes {
  /// Minimum touch target (Material guideline is 48dp).
  static const double minTouchTarget = 48;

  /// Width of the extended desktop sidebar.
  static const double sidebarWidth = 248;
}

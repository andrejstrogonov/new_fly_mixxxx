import 'package:flutter/material.dart';

/// UI константы и паттерны
class UIConstants {
  // Paddings
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 12.0;
  static const double borderRadiusXLarge = 16.0;
  static const double borderRadiusCircle = 50.0;

  // Icon sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;

  // Screen breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1200;
  static const double desktopBreakpoint = 1920;

  // Colors
  static const Color primaryColor = Colors.deepPurple;
  static const Color secondaryColor = Colors.cyan;
  static const Color backgroundColor = Color(0xFF1a1a1a);
  static const Color surfaceColor = Color(0xFF2a2a2a);
  static const Color errorColor = Colors.redAccent;
  static const Color successColor = Colors.greenAccent;

  // Opacity
  static const double opacityDisabled = 0.5;
  static const double opacityHover = 0.8;
  static const double opacityActive = 1.0;

  // Durations
  static const Duration durationQuick = Duration(milliseconds: 100);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
}

/// Расширения для размеров экрана
extension ScreenSizeExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < UIConstants.mobileBreakpoint;
  bool get isTablet => MediaQuery.of(this).size.width >= UIConstants.mobileBreakpoint &&
      MediaQuery.of(this).size.width < UIConstants.tabletBreakpoint;
  bool get isDesktop => MediaQuery.of(this).size.width >= UIConstants.tabletBreakpoint;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}


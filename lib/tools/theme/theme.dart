// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:amazing_tools/tools/theme/theme/custom_mode/custom_theme.dart';
import 'package:amazing_tools/tools/theme/theme/dark_theme.dart';
import 'package:amazing_tools/tools/theme/theme/light_theme.dart';
import 'package:flutter/material.dart';



class ThemeClass {
  static String themeModeKey = 'Theme mode';
  static String primaryColorKey = 'Primary Color';
  static String colorContrastKey = 'Color contrast';
  static String colorPositionKey = 'Color position';
  Color? primaryColor = Colors.red;
  String? themeMode = 'Cdemy mode';
  double colorContrast;
  double? colorPosition;

  ThemeClass({
    this.primaryColor,
    this.themeMode,
    this.colorPosition,
    this.colorContrast = 3,
  });

  ThemeData get theme {
    if (themeMode == 'Custom mode') {
      return buildCustomTheme(primaryColor, colorContrast);
    }
    if (themeMode == 'Cdemy mode') {
      return buildCustomTheme(Colors.green, 4);
    }
    if (themeMode == 'Dark mode') {
      return buildDarkTheme(primaryColor);
    }
    return buildLightTheme(primaryColor);
  }

  ThemeClass copyWith({
    Color? primaryColor,
    String? themeMode,
    double? colorContrast,
    double? colorPosition,
  }) {
    return ThemeClass(
      primaryColor: primaryColor ?? this.primaryColor,
      themeMode: themeMode ?? this.themeMode,
      colorContrast: colorContrast ?? this.colorContrast,
      colorPosition: colorPosition ?? this.colorPosition,
    );
  }

  @override
  String toString() => 'ThemeClass(primaryColor: $primaryColor, themeMode: $themeMode, colorContrast: $colorContrast)';
}

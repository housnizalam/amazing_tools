import 'package:flutter/material.dart';

ThemeData buildLightTheme(Color? primaryColor) {
  primaryColor = primaryColor == null ? Colors.green.withOpacity(0.7) : primaryColor.withOpacity(0.7);
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
    appBarTheme: AppBarTheme(
      color: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: primaryColor,
    ),
  );
}

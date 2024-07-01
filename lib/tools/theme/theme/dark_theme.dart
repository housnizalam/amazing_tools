import 'package:flutter/material.dart';

// Function to create dark theme based on the primary color
ThemeData buildDarkTheme(Color? primaryColor) {
  primaryColor = primaryColor == null ? Colors.green.withOpacity(0.5) : primaryColor.withOpacity(0.5);
  return ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
    cardTheme: CardTheme(color: primaryColor),
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    
    appBarTheme: AppBarTheme(
      color: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      
      bodyLarge: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: primaryColor,
    ),
  );
}

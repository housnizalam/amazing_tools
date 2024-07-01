import 'package:amazing_tools/tools/theme/theme/custom_mode/custom_colors.dart';
import 'package:flutter/material.dart';

ThemeData buildCustomTheme(Color? primaryColor, double colorContrast) {
  final customColor = CustomColors(
    primaryColor: primaryColor ?? Colors.green,
    colorContrast: colorContrast,
  );
  return ThemeData(
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(customColor.textColor),
    ),
    textTheme: const TextTheme(bodyLarge: TextStyle(fontWeight: FontWeight.bold)),
    dividerTheme: DividerThemeData(color: customColor.textColor),
    cardColor: customColor.tertiaryColor,
    cardTheme: CardTheme(
      color: customColor.tertiaryColor,
    ),
    tabBarTheme: TabBarTheme(labelColor: customColor.primaryColor),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: _createMaterialColor(customColor.primaryColor),
      accentColor: customColor.tertiaryColor,
      backgroundColor: customColor.secondaryColor,
      cardColor: customColor.primaryColor,
      brightness: customColor.themeBritness,
      errorColor: Colors.red,
    ),
  );
}

//#############################################################
//#############################################################
//#############################################################
//#############################################################
//#############################################################
//#############################################################
MaterialColor _createMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

import 'package:flutter/material.dart';

enum ColorBritness { extremeDark, dark, normal, light, extremeLight }

class CustomColors {
  Color primaryColor;
  double colorContrast;
  CustomColors({
    required this.primaryColor,
    this.colorContrast = 5,
  });

  ColorBritness get primaryColorBritness {
    final primaryColorAsInt = (primaryColor.blue + primaryColor.red + primaryColor.green) ~/ 3;
    if (primaryColorAsInt < 40) return ColorBritness.extremeDark;
    if (primaryColorAsInt < 90) return ColorBritness.dark;
    if (primaryColorAsInt < 150) return ColorBritness.normal;
    if (primaryColorAsInt < 200) return ColorBritness.light;
    return ColorBritness.extremeLight;
  }

  ColorBritness get tertiaryColorBritness {
    final primaryColorAsInt = (primaryColor.blue + primaryColor.red + primaryColor.green) ~/ 3;
    if (primaryColorAsInt < 40) return ColorBritness.extremeDark;
    if (primaryColorAsInt < 90) return ColorBritness.dark;
    if (primaryColorAsInt < 150) return ColorBritness.normal;
    if (primaryColorAsInt < 200) return ColorBritness.light;
    return ColorBritness.extremeLight;
  }

  Color get secondaryColor {
    if (primaryColorBritness == ColorBritness.extremeDark) return lighterPrimary(2);
    if (primaryColorBritness == ColorBritness.dark) return lighterPrimary(colorContrast);
    if (primaryColorBritness == ColorBritness.normal) return lighterPrimary(colorContrast);
    if (primaryColorBritness == ColorBritness.light) return lighterPrimary(colorContrast);
    return lighterPrimary(colorContrast);
  }

  Color get tertiaryColor {
    if (primaryColorBritness == ColorBritness.extremeDark) return darkerPrimary(colorContrast);
    if (primaryColorBritness == ColorBritness.dark) return darkerPrimary(colorContrast);
    if (primaryColorBritness == ColorBritness.normal) return darkerPrimary(colorContrast);
    if (primaryColorBritness == ColorBritness.light) return darkerPrimary(colorContrast);
    return darkerPrimary(colorContrast);
  }

  Color lighterPrimary(double degree) {
    final red = primaryColor.red + (255 - primaryColor.red) * degree ~/ 10;
    final blue = primaryColor.blue + (255 - primaryColor.blue) * degree ~/ 10;
    final green = primaryColor.green + (255 - primaryColor.green) * degree ~/ 10;
    return Color.fromARGB(255, red, green, blue);
  }

  Color darkerPrimary(double degree) {
    final red = primaryColor.red * (10 - degree) ~/ 10;
    final blue = primaryColor.blue * (10 - degree) ~/ 10;
    final green = primaryColor.green * (10 - degree) ~/ 10;
    return Color.fromARGB(255, red, green, blue);
  }

  Color get textColor => primaryColorBritness == ColorBritness.dark || primaryColorBritness == ColorBritness.extremeDark
      ? Colors.white
      : Colors.black;

  Brightness get themeBritness =>
      primaryColorBritness == ColorBritness.dark || primaryColorBritness == ColorBritness.extremeDark
          ? Brightness.dark
          : Brightness.light;
}

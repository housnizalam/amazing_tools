// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazing_tools/tools/theme/theme/custom_mode/custom_colors.dart';
import 'package:flutter/material.dart';

class ColorPickerController {
  double width;
  double height;
  double horizentalPadding;
  double? colorContrast;
  double? colorPosition;
  double shadeSliderPosition;
  double contrastSliderPosition;
  double testBallRadius;
  double sliderBallRadius;
  double sliderheight;
  List<Color> colors;
  Color sliderBallColor;
  Color? startColor;
  ColorPickerController({
    required this.width,
    required this.height,
    required this.horizentalPadding,
    required this.colorContrast,
    required this.colorPosition,
    this.shadeSliderPosition = 0,
    this.contrastSliderPosition = 0,
    required this.testBallRadius,
    required this.sliderBallRadius,
    required this.sliderheight,
    required this.colors,
    required this.sliderBallColor,
    required this.startColor,
  });
  double get sliderWidth => width - 2 * horizentalPadding;
  double get colorSliderPosition => colorPosition ?? sliderWidth / 2 - horizentalPadding;
  Color get mainSelectedColor {
    double positionInColorArray = colorSliderPosition / ((sliderWidth - sliderBallRadius)) * (colors.length - 1);
    int index = positionInColorArray.truncate();
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      return colors[index];
    } else {
      //calculate new color
      int redValue = colors[index].red == colors[index + 1].red
          ? colors[index].red
          : (colors[index].red + (colors[index + 1].red - colors[index].red) * remainder).round();
      int greenValue = colors[index].green == colors[index + 1].green
          ? colors[index].green
          : (colors[index].green + (colors[index + 1].green - colors[index].green) * remainder).round();
      int blueValue = colors[index].blue == colors[index + 1].blue
          ? colors[index].blue
          : (colors[index].blue + (colors[index + 1].blue - colors[index].blue) * remainder).round();
      return Color.fromARGB(255, redValue, greenValue, blueValue);
    }
  }

  double get firstShadeSliderPosition {
    if (startColor == null) return sliderWidth / 2 - horizentalPadding;
    final colorPower = (startColor!.red + startColor!.blue + startColor!.green) / 3;
    final result = (colorPower / 255) * sliderWidth + 2 * horizentalPadding;
    return result;
  }

  Color get shadedColor {
    double ratio = shadeSliderPosition / (sliderWidth - sliderBallRadius);
    if (ratio > 0.5) {
      //Calculate new color (values converge to 255 to make the color lighter)
      int redVal = mainSelectedColor.red != 255
          ? (mainSelectedColor.red + (255 - mainSelectedColor.red) * (ratio - 0.5) / 0.5).round()
          : 255;
      int greenVal = mainSelectedColor.green != 255
          ? (mainSelectedColor.green + (255 - mainSelectedColor.green) * (ratio - 0.5) / 0.5).round()
          : 255;
      int blueVal = mainSelectedColor.blue != 255
          ? (mainSelectedColor.blue + (255 - mainSelectedColor.blue) * (ratio - 0.5) / 0.5).round()
          : 255;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else if (ratio < 0.5) {
      //Calculate new color (values converge to 0 to make the color darker)
      int redVal = mainSelectedColor.red != 0 ? (mainSelectedColor.red * ratio / 0.5).round() : 0;
      int greenVal = mainSelectedColor.green != 0 ? (mainSelectedColor.green * ratio / 0.5).round() : 0;
      int blueVal = mainSelectedColor.blue != 0 ? (mainSelectedColor.blue * ratio / 0.5).round() : 0;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else {
      //return the base color
      return mainSelectedColor;
    }
  }

  int get shadedColorAsInt {
    // Shift each color channel to its position in the 32-bit integer representation
    final alpha = shadedColor.alpha << 24;
    final red = shadedColor.red << 16;
    final green = shadedColor.green << 8;
    final blue = shadedColor.blue;

    // Combine the channels to get the final integer representation
    final result = alpha | red | green | blue;

    return result;
  }

  CustomColors get customColors => CustomColors(primaryColor: shadedColor, colorContrast: colorContrast ?? 0);

  double get firstContrastSliderPosition {
    if (colorContrast == null) return sliderWidth / 2 - horizentalPadding;
    final result = (colorContrast! / 9.853) * (sliderWidth + horizentalPadding);
    print(result);
    return result;
  }


}

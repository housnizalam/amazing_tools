// ignore_for_file: public_member_api_docs

import 'package:amazing_tools/tools/amazin_color_picker/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// This is a widget that allows the user to choose a color from a color slider.
/// This color can be obtained as a color value or as an integer.
/// Parameters:
/// - [color]: This is the selected color as a color. This value can be obtained as a static attribute of the class.
/// - [colorAsInt]: This is the selected color as an integer.This value can be obtained as a static attribute of the class.
/// - [width]: This is the width of the page. This attribute is required
/// - [height]: This is the height of the page.
/// - [colors]: This is the color list. It is optional because there is a default list.
/// - [horizentalPadding]: Default to 8.
/// - [horizentalPadding]: Default to 8.
/// - [testBallRadius]:This is the radius of the circle that showcases the selected color. Default to 50.
/// - [sliderBallRadius]:This is the radius of the slider circle. Default to 12.
/// - [sliderBallColor]:This is the color of the slider circle. Default to black.
/// - [sliderheight]:This is the height of the slider. Default to 15.

class AmazingColorPicker extends StatefulWidget {
  static Color? color;
  static int? colorAsInt;
  static double? colorConstrast;
  static double? colorPosition;
  final double? constrastPosition;
  final double? colorPositionIn;
  final double? colorContrastIn;
  final double width;
  final double height;
  final List<Color>? colors;
  final double horizentalPadding;
  final double testBallRadius;
  final double sliderBallRadius;
  final double sliderheight;
  final Color sliderBallColor;
  final Color? startColor;
  const AmazingColorPicker({
    Key? key,
    this.width = 300,
    this.colorPositionIn,
    this.colorContrastIn,
    this.constrastPosition,
    this.height = 250,
    this.colors,
    this.startColor,
    this.horizentalPadding = 8,
    this.testBallRadius = 50,
    this.sliderBallRadius = 12,
    this.sliderheight = 15,
    this.sliderBallColor = Colors.black,
  }) : super(key: key);
  @override
  AmazingColorPickerState createState() => AmazingColorPickerState();
}

class AmazingColorPickerState extends State<AmazingColorPicker> {
  late ColorPickerController controller;
  // definiert die Funktionalität vom benutzten Slider
  String message = '';
  @override
  void initState() {
    super.initState();
    //###############################################################
    // diese Controller kontrolliert diese Seite. es ist ein Object von erstellte Klasse
    controller = ColorPickerController(
      width: widget.width,
      height: widget.height,
      horizentalPadding: widget.horizentalPadding,
      colorContrast: widget.colorContrastIn,
      colorPosition: widget.colorPositionIn,
      testBallRadius: widget.testBallRadius,
      sliderBallRadius: widget.sliderBallRadius,
      sliderheight: widget.sliderheight,
      sliderBallColor: widget.sliderBallColor,
      startColor: widget.startColor,
      colors: widget.colors ?? colorsListe,
    );
    //###############################################################
    // AmazingColorPicker.colorConstrast = 3;
    controller.shadeSliderPosition = controller.firstShadeSliderPosition;
    // Ich habe die Farbe als static deffiniert, weil ich will diese AmazingColorPicker Code isollieren, 
    // dh mit mehrer Apps benutzen.
    AmazingColorPicker.color = controller.shadedColor;
    // die Farbe wird als int gespeichert
    AmazingColorPicker.colorAsInt = controller.shadedColorAsInt;
    controller.contrastSliderPosition = controller.firstContrastSliderPosition;
  }

  void _colorChangeHandler(double position) {
    // das indikator soll innnerhalb des Sliders bleiben 
    if (position > controller.sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius) {
      position = controller.sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius;
    }
    if (position < 0) position = 0;
    setState(() {
      // um die Position der Farbe zu speichern
      AmazingColorPicker.colorPosition = position;
      controller.colorPosition = position;
      AmazingColorPicker.color = controller.shadedColor;
      AmazingColorPicker.colorAsInt = controller.shadedColorAsInt;
    });
  }

  void _shadeChangeHandler(double position) {
    //handle out of bounds gestures
    if (position > controller.sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius) {
      position = controller.sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius;
    }
    if (position < 0) position = 0;
    setState(() {
      controller.shadeSliderPosition = position;

      AmazingColorPicker.color = controller.shadedColor;
      AmazingColorPicker.colorAsInt = controller.shadedColorAsInt;

    });
  }
 // Contrast deffiniert die zweite und dritte main Farbe 
  void _colorContrastHandler(double position) {
    //handle out of bounds gestures
    if (position > controller.sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius) {
      position = controller.sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius;
    }
    if (position < 0) position = 0;
    setState(() {
      controller.contrastSliderPosition = position;
      double value = (controller.contrastSliderPosition / (controller.sliderWidth - widget.sliderBallRadius)) * 10;
      print(value);
      AmazingColorPicker.colorConstrast = value;
      controller.colorContrast = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (DragStartDetails details) {
                    // print("_-------------------------STARTED DRAG");
                    _colorChangeHandler(details.localPosition.dx - widget.sliderBallRadius);
                    setState(() {
                      message = 'Set main color';
                    });
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    _colorChangeHandler(details.localPosition.dx - widget.sliderBallRadius);
                  },
                  onTapDown: (TapDownDetails details) {
                    _colorChangeHandler(details.localPosition.dx - widget.sliderBallRadius);
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      message = '';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: controller.sliderWidth,
                      height: widget.sliderheight,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey[800]!),
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: controller.colors),
                      ),
                      child: CustomPaint(
                        painter: _SliderIndicatorPainter(
                            controller.colorSliderPosition, widget.sliderBallRadius, widget.sliderBallColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (DragStartDetails details) {
                    // print("_-------------------------STARTED DRAG");
                    _shadeChangeHandler(details.localPosition.dx - widget.sliderBallRadius);
                    setState(() {
                      message = 'Set shade color';
                    });
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    _shadeChangeHandler(details.localPosition.dx - widget.sliderBallRadius);
                  },
                  onTapDown: (TapDownDetails details) {
                    _shadeChangeHandler(details.localPosition.dx - widget.sliderBallRadius);
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      message = '';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: controller.sliderWidth,
                      height: widget.sliderheight,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey[800] ?? Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [Colors.black, controller.shadedColor, Colors.white]),
                      ),
                      child: CustomPaint(
                        painter: _SliderIndicatorPainter(
                            controller.shadeSliderPosition, widget.sliderBallRadius, widget.sliderBallColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragStart: (DragStartDetails details) {
                    // print("_-------------------------STARTED DRAG");
                    _colorContrastHandler(details.localPosition.dx - widget.sliderBallRadius);
                    setState(() {
                      message = 'Set color contrast';
                    });
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    _colorContrastHandler(details.localPosition.dx - widget.sliderBallRadius);
                  },
                  onTapDown: (TapDownDetails details) {
                    _colorContrastHandler(details.localPosition.dx - widget.sliderBallRadius);
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      message = '';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: controller.sliderWidth,
                      height: widget.sliderheight,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        border: Border.all(width: 2, color: Colors.grey[800] ?? Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [Colors.transparent, controller.shadedColor, Colors.black]),
                      ),
                      child: CustomPaint(
                        painter: _SliderIndicatorPainter(
                            controller.contrastSliderPosition, widget.sliderBallRadius, widget.sliderBallColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.horizentalPadding),
                    height: widget.testBallRadius,
                    width: widget.testBallRadius,
                    decoration: BoxDecoration(
                      color: AmazingColorPicker.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.horizentalPadding),
                    height: widget.testBallRadius,
                    width: widget.testBallRadius,
                    decoration: BoxDecoration(
                      color: controller.customColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.horizentalPadding),
                    height: widget.testBallRadius,
                    width: widget.testBallRadius,
                    decoration: BoxDecoration(
                      color: controller.customColors.tertiaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SliderIndicatorPainter extends CustomPainter {
  final double position;
  final double sliderBallRadius;
  final Color sliderBallColor;
  _SliderIndicatorPainter(this.position, this.sliderBallRadius, this.sliderBallColor);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(position, size.height / 2), sliderBallRadius, Paint()..color = sliderBallColor);
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}

const List<Color> colorsListe = [
  Color.fromARGB(255, 255, 0, 0),
  Color.fromARGB(255, 255, 128, 0),
  Color.fromARGB(255, 255, 255, 0),
  Color.fromARGB(255, 128, 255, 0),
  Color.fromARGB(255, 0, 255, 0),
  Color.fromARGB(255, 0, 255, 128),
  Color.fromARGB(255, 0, 255, 255),
  Color.fromARGB(255, 0, 128, 255),
  Color.fromARGB(255, 0, 0, 255),
  Color.fromARGB(255, 127, 0, 255),
  Color.fromARGB(255, 255, 0, 255),
  Color.fromARGB(255, 255, 0, 127),
  Color.fromARGB(255, 128, 128, 128),
  Color.fromARGB(255, 80, 80, 80),
];

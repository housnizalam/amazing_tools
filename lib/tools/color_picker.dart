import 'package:flutter/material.dart';

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
  final double width;
  final double? height;
  final List<Color>? colors;
  final double horizentalPadding;
  final double testBallRadius;
  final double sliderBallRadius;
  final double sliderheight;
  final Color sliderBallColor;
  const AmazingColorPicker(
      {Key? key,
      required this.width,
      this.height,
      this.colors,
      this.horizentalPadding = 8,
      this.testBallRadius = 50,
      this.sliderBallRadius = 12,
      this.sliderheight = 15,
      this.sliderBallColor = Colors.black})
      : super(key: key);
  @override
  AmazingColorPickerState createState() => AmazingColorPickerState();
}

class AmazingColorPickerState extends State<AmazingColorPicker> {
  final List<Color> _colors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 128, 0),
    const Color.fromARGB(255, 255, 255, 0),
    const Color.fromARGB(255, 128, 255, 0),
    const Color.fromARGB(255, 0, 255, 0),
    const Color.fromARGB(255, 0, 255, 128),
    const Color.fromARGB(255, 0, 255, 255),
    const Color.fromARGB(255, 0, 128, 255),
    const Color.fromARGB(255, 0, 0, 255),
    const Color.fromARGB(255, 127, 0, 255),
    const Color.fromARGB(255, 255, 0, 255),
    const Color.fromARGB(255, 255, 0, 127),
    const Color.fromARGB(255, 128, 128, 128),
  ];
  double _colorSliderPosition = 0;
  late double _sliderWidth;
  late double _shadeSliderPosition;
  late Color _currentColor;
  @override
  initState() {
    super.initState();
    _sliderWidth = widget.width - 2 * widget.horizentalPadding;
    _currentColor = _calculateSelectedColor(_colorSliderPosition);
    _shadeSliderPosition = (_sliderWidth) / 2 - widget.horizentalPadding; //center the shader selector
    AmazingColorPicker.color = _calculateShadedColor(_shadeSliderPosition);
    AmazingColorPicker.colorAsInt = colorToInt(_calculateShadedColor(_shadeSliderPosition));
  }

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > _sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius) {
      position = _sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius;
    }
    if (position < 0) {
      position = 0;
    }
    // print("New pos: $position");
    setState(() {
      _colorSliderPosition = position;
      _currentColor = _calculateSelectedColor(_colorSliderPosition);
      AmazingColorPicker.color = _calculateShadedColor(_shadeSliderPosition);
      AmazingColorPicker.colorAsInt = colorToInt(_calculateShadedColor(_shadeSliderPosition));
    });
  }

  _shadeChangeHandler(double position) {
    //handle out of bounds gestures
    if (position > _sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius) {
      position = _sliderWidth - widget.horizentalPadding / 2 - widget.sliderBallRadius;
    }
    if (position < 0) position = 0;
    setState(() {
      _shadeSliderPosition = position;
      AmazingColorPicker.color = _calculateShadedColor(_shadeSliderPosition);
      AmazingColorPicker.colorAsInt = colorToInt(_calculateShadedColor(_shadeSliderPosition));

      // print("r: ${_shadedColor.red}, g: ${_shadedColor.green}, b: ${_shadedColor.blue}");
    });
  }

  Color _calculateShadedColor(double position) {
    double ratio = position / _sliderWidth;
    if (ratio > 0.5) {
      //Calculate new color (values converge to 255 to make the color lighter)
      int redVal = _currentColor.red != 255
          ? (_currentColor.red + (255 - _currentColor.red) * (ratio - 0.5) / 0.5).round()
          : 255;
      int greenVal = _currentColor.green != 255
          ? (_currentColor.green + (255 - _currentColor.green) * (ratio - 0.5) / 0.5).round()
          : 255;
      int blueVal = _currentColor.blue != 255
          ? (_currentColor.blue + (255 - _currentColor.blue) * (ratio - 0.5) / 0.5).round()
          : 255;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else if (ratio < 0.5) {
      //Calculate new color (values converge to 0 to make the color darker)
      int redVal = _currentColor.red != 0 ? (_currentColor.red * ratio / 0.5).round() : 0;
      int greenVal = _currentColor.green != 0 ? (_currentColor.green * ratio / 0.5).round() : 0;
      int blueVal = _currentColor.blue != 0 ? (_currentColor.blue * ratio / 0.5).round() : 0;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else {
      //return the base color
      return _currentColor;
    }
  }

  Color _calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray = (position / _sliderWidth * (_colors.length - 1));
    // print(positionInColorArray);
    int index = positionInColorArray.truncate();
    // print(index);
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentColor = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red + (_colors[index + 1].red - _colors[index].red) * remainder).round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green + (_colors[index + 1].green - _colors[index].green) * remainder).round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue + (_colors[index + 1].blue - _colors[index].blue) * remainder).round();
      _currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentColor;
  }

  int colorToInt(Color color) {
    // Shift each color channel to its position in the 32-bit integer representation
    int alpha = color.alpha << 24;
    int red = color.red << 16;
    int green = color.green << 8;
    int blue = color.blue;

    // Combine the channels to get the final integer representation
    int result = alpha | red | green | blue;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: widget.height ?? 150,
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
                    _colorChangeHandler(details.localPosition.dx);
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    _colorChangeHandler(details.localPosition.dx);
                  },
                  onTapDown: (TapDownDetails details) {
                    _colorChangeHandler(details.localPosition.dx);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: _sliderWidth,
                      height: widget.sliderheight,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey[800]!),
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: widget.colors ?? _colors),
                      ),
                      child: CustomPaint(
                        painter: _SliderIndicatorPainter(
                            _colorSliderPosition, widget.sliderBallRadius, widget.sliderBallColor),
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
                    _shadeChangeHandler(details.localPosition.dx);
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    _shadeChangeHandler(details.localPosition.dx);
                  },
                  onTapDown: (TapDownDetails details) {
                    _shadeChangeHandler(details.localPosition.dx);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: _sliderWidth,
                      height: widget.sliderheight,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey[800] ?? Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [Colors.black, _currentColor, Colors.white]),
                      ),
                      child: CustomPaint(
                        painter: _SliderIndicatorPainter(
                            _shadeSliderPosition, widget.sliderBallRadius, widget.sliderBallColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: widget.horizentalPadding),
                height: widget.testBallRadius,
                width: widget.testBallRadius,
                decoration: BoxDecoration(
                  color: AmazingColorPicker.color,
                  shape: BoxShape.circle,
                ),
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

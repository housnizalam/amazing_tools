import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This is a button that enables the user to control the screen with sweeping gestures.
/// Parameters:
/// - [child]:[child] is the widget representing the button. This widget is optional.
/// - [onPressed]: [onSwipRight] is a function that the button should perform after sweeping to right.
/// - [onPressed]: [onSwipLeft] is a function that the button should perform after sweeping to left.
/// - [onPressed]: [onSwipUp] is a function that the button should perform after sweeping to up.
/// - [onPressed]: [onSwipDown] is a function that the button should perform after sweeping to down.

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    super.key,
    this.onSwipRight,
    this.onSwipLeft,
    this.onSwipUp,
    this.onSwipDown,
    this.child,
  });
  final Function(DragEndDetails details)? onSwipRight;
  final Function(DragEndDetails details)? onSwipLeft;
  final Function(DragEndDetails details)? onSwipUp;
  final Function(DragEndDetails details)? onSwipDown;
  final Widget? child;
  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  double xStart = 0;
  double yStart = 0;
  double yDifference = 0;
  double xDifference = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        yStart = details.localPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          yDifference = details.localPosition.dy - yStart;
        });
      },
      onHorizontalDragStart: (details) {
        xStart = details.localPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          xDifference = details.localPosition.dx - xStart;
        });
      },
      onVerticalDragEnd: yDifference.abs() < 40
          ? (_) {
              if (kDebugMode) {}
            }
          : yDifference.isNegative
              ? widget.onSwipUp
              : widget.onSwipDown,
      onHorizontalDragEnd: xDifference.abs() < 40
          ? (_) {
              if (kDebugMode) {}
            }
          : xDifference.isNegative
              ? widget.onSwipRight
              : widget.onSwipLeft,
      child: widget.child,
    );
  }
}

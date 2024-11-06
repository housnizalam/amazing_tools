import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This is a button that enables the user to control the screen with sweeping gestures.
/// Parameters:
/// - [child]:[child] is the widget representing the button. This widget is optional.
/// - [onPressed]: [onSwipLeft] is a function that the button should perform after sweeping to right.
/// - [onPressed]: [onSwipRight] is a function that the button should perform after sweeping to left.
/// - [onPressed]: [onSwipUp] is a function that the button should perform after sweeping to up.
/// - [onPressed]: [onSwipDown] is a function that the button should perform after sweeping to down.

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    super.key,
    this.onSwipLeft,
    this.onSwipRight,
    this.onSwipUp,
    this.onSwipDown,
    this.onDoubleClick,
    this.onLongPressUp,
    this.onLongPressDown,
    this.onLongPress,
    this.child,
  });
  final Function(DragEndDetails details)? onSwipLeft;
  final Function(DragEndDetails details)? onSwipRight;
  final Function(DragEndDetails details)? onSwipUp;
  final Function(DragEndDetails details)? onSwipDown;
  final Function(DragEndDetails details)? onLongPressUp;
  final Function(DragEndDetails details)? onLongPressDown;
  final Function? onDoubleClick;
  final Function? onLongPress;
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
      onLongPress: () {
        if (widget.onLongPressUp == null) return;
        widget.onLongPress!.call();
      },
      onLongPressDown: (details) {
        yStart = details.localPosition.dy;
        xStart = details.localPosition.dx;
      },
      onLongPressMoveUpdate: (details) {
        yDifference = details.localPosition.dy - yStart;
        xDifference = details.localPosition.dx - xStart;
      },
      onLongPressUp: () {
        if (yDifference > 0) {
          if (widget.onLongPressDown == null) return;
          widget.onLongPressDown!.call(DragEndDetails());
        }
        if (yDifference < 0) {
          if (widget.onLongPressUp == null) return;
          widget.onLongPressUp!.call(DragEndDetails());
        }
      },
      onDoubleTap: () {
        if (widget.onDoubleClick == null) return;
        widget.onDoubleClick!.call();
      },
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
              ? widget.onSwipLeft
              : widget.onSwipRight,
      child: widget.child,
    );
  }
}

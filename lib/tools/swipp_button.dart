import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    super.key,
    this.onSwipRight,
    this.onSwipLeft,
    this.onSwipUp,
    this.onSwipDown,
    this.child,
  });
  final Function(DragEndDetails)? onSwipRight;
  final Function(DragEndDetails)? onSwipLeft;
  final Function(DragEndDetails)? onSwipUp;
  final Function(DragEndDetails)? onSwipDown;
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
              if (kDebugMode) {
                print('y swipe not work');
              }
            }
          : yDifference.isNegative
              ? widget.onSwipUp
              : widget.onSwipDown,
      onHorizontalDragEnd: xDifference.abs() < 40
          ? (_) {
              if (kDebugMode) {
                print('x swipe not work');
              }
            }
          : xDifference.isNegative
              ? widget.onSwipRight
              : widget.onSwipLeft,
      child: widget.child,
    );
  }
}

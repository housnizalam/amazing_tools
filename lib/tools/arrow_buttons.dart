import 'dart:math';

import 'package:flutter/material.dart';

class ArrowButtons extends StatelessWidget {
  const ArrowButtons._({
    super.key,
    required this.height,
    required this.width,
    this.onPressedUp,
    this.onPressedDown,
    this.onPressedLeft,
    this.onPressedRight,
    this.onLongPressedUp,
    this.onLongPressedDown,
    this.onLongPressedLeft,
    this.onLongPressedRight,
    required this.isVertical,
    this.arrowsColor = Colors.blue,
  });
  final double height;
  final double width;
  final VoidCallback? onPressedUp;
  final VoidCallback? onPressedDown;
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;
  final VoidCallback? onLongPressedUp;
  final VoidCallback? onLongPressedDown;
  final VoidCallback? onLongPressedLeft;
  final VoidCallback? onLongPressedRight;
  final Color arrowsColor;
  final bool isVertical;

  factory ArrowButtons.vertical({
    Key? key,
    required double height,
    required double width,
    VoidCallback? onPressedUp,
    VoidCallback? onPressedDown,
    VoidCallback? onLongPressedUp,
    VoidCallback? onLongPressedDown,
    Color arrowsColor = Colors.blue,
  }) {
    return ArrowButtons._(
      key: key,
      height: height,
      width: width,
      onPressedUp: onPressedUp,
      onPressedDown: onPressedDown,
      isVertical: true,
      arrowsColor: arrowsColor,
      onLongPressedUp: onLongPressedUp,
      onLongPressedDown: onLongPressedDown,
    );
  }

  factory ArrowButtons.horizontal({
    Key? key,
    required double height,
    required double width,
    VoidCallback? onPressedLeft,
    VoidCallback? onPressedRight,
    VoidCallback? onLongPressedLeft,
    VoidCallback? onLongPressedRight,
    arrowsColor = Colors.blue,
  }) {
    return ArrowButtons._(
      key: key,
      height: height,
      width: width,
      onPressedLeft: onPressedLeft,
      onPressedRight: onPressedRight,
      onLongPressedLeft: onLongPressedLeft,
      onLongPressedRight: onLongPressedRight,
      isVertical: false,
      arrowsColor: arrowsColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Center(
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onPressedUp,
                      onLongPress: onLongPressedUp,
                      // onLongPress: ,
                      child: Container(
                        decoration: ShapeDecoration(
                          color: arrowsColor,
                          shape: StarBorder.polygon(sides: 3),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onPressedDown,
                      onLongPress: onLongPressedDown,
                      // onLongPress: on,
                      child: Transform.rotate(
                        angle: pi,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: arrowsColor,
                            shape: StarBorder.polygon(sides: 3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: SizedBox(
              height: height,
              width: width,
              child: Row(    
                children: [   
                  Expanded( 
                    child: InkWell(  
                      onTap: onPressedLeft,
                      onLongPress: onLongPressedLeft,
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: arrowsColor,
                            shape: StarBorder.polygon(sides: 3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onPressedRight,
                      onLongPress: onLongPressedRight,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: arrowsColor,
                            shape: StarBorder.polygon(sides: 3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

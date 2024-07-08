import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

enum FlipDirection { down, up, left, right }

class FlippWidget extends StatefulWidget {
  const FlippWidget({
    Key? key,
    this.animationDuration,
    this.startChild,
    this.secondChild,
    this.onFirstPress,
    this.onSecondPress,
    this.onFirstAnimationComplete,
    this.onSecondAnimationComplete,
    this.height = 200,
    this.width = 200,
    this.flipWithTranslate = false,
    this.flipDirection,
    this.animationCurve,
  });
  final Duration? animationDuration;
  final double height;
  final double width;
  final bool flipWithTranslate;
  final Widget? startChild;
  final Widget? secondChild;
  final Curve? animationCurve;
  final FlipDirection? flipDirection;
  final Function? onFirstPress;
  final Function? onSecondPress;
  final Function? onFirstAnimationComplete;
  final Function? onSecondAnimationComplete;

  @override
  State<FlippWidget> createState() => _FlippWidgetState();
}

class _FlippWidgetState extends State<FlippWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: widget.animationCurve ?? Curves.easeInOutSine,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          if (widget.onFirstPress != null) widget.onFirstPress!.call();
        }
        if (status == AnimationStatus.reverse) {
          if (widget.onSecondPress != null) widget.onSecondPress!.call();
        }
        if (status == AnimationStatus.completed) {
          if (widget.onFirstAnimationComplete != null) widget.onFirstAnimationComplete!.call();
        }
        if (status == AnimationStatus.dismissed) {
          if (widget.onSecondAnimationComplete != null) widget.onSecondAnimationComplete!.call();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (animation.status == AnimationStatus.forward || animation.status == AnimationStatus.completed) {
            controller.reverse();
          } else if (animation.status == AnimationStatus.reverse || animation.status == AnimationStatus.dismissed) {
            controller.forward();
          }
        },
        child: widget.flipDirection == FlipDirection.left
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(-animation.value * pi)
                  ..translate(widget.flipWithTranslate ? widget.width * animation.value : 0.01, 0.00),
                child: animation.value < 0.5
                    ? SizedBox(
                        child: widget.startChild != null
                            ? SizedBox(
                                height: widget.height,
                                width: widget.width,
                                child: widget.startChild,
                              )
                            : Container(
                                height: widget.height,
                                width: widget.width,
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    'First side',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                      )
                    : SizedBox(
                        child: Center(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..rotateY(pi)
                              ..translate(-widget.width, 0),
                            child: widget.secondChild != null
                                ? SizedBox(
                                    height: widget.height,
                                    width: widget.width,
                                    child: widget.secondChild,
                                  )
                                : Container(
                                    height: widget.height,
                                    width: widget.width,
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        'Second side',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
              )
            : widget.flipDirection == FlipDirection.right
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.003)
                      ..rotateY(animation.value * pi)
                      ..translate(widget.flipWithTranslate ? -widget.width * animation.value : 0.01, 0.00),
                    child: animation.value < 0.5
                        ? SizedBox(
                            child: widget.startChild != null
                                ? SizedBox(
                                    height: widget.height,
                                    width: widget.width,
                                    child: widget.startChild,
                                  )
                                : Container(
                                    height: widget.height,
                                    width: widget.width,
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        'First side',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        : SizedBox(
                            child: Center(
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..rotateY(pi)
                                  ..translate(-widget.width, 0),
                                child: widget.secondChild != null
                                    ? SizedBox(
                                        height: widget.height,
                                        width: widget.width,
                                        child: widget.secondChild,
                                      )
                                    : Container(
                                        height: widget.height,
                                        width: widget.width,
                                        color: Colors.red,
                                        child: Center(
                                          child: Text(
                                            'Second side',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                  )
                : widget.flipDirection == FlipDirection.up
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateX(-animation.value * pi)
                          ..translate(0.00, widget.flipWithTranslate ? -widget.height * animation.value : 0),
                        child: animation.value < 0.5
                            ? SizedBox(
                                child: widget.startChild != null
                                    ? SizedBox(
                                        height: widget.height,
                                        width: widget.width,
                                        child: widget.startChild,
                                      )
                                    : Container(
                                        height: widget.height,
                                        width: widget.width,
                                        color: Colors.blue,
                                        child: Center(
                                          child: Text(
                                            'First side',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                              )
                            : SizedBox(
                                child: Center(
                                    child: Transform(
                                  transform: Matrix4.identity()
                                    ..rotateX(pi)
                                    ..translate(0.00, -widget.height),
                                  child: widget.secondChild != null
                                      ? SizedBox(
                                          height: widget.height,
                                          width: widget.width,
                                          child: widget.secondChild,
                                        )
                                      : Container(
                                          height: widget.height,
                                          width: widget.width,
                                          color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              'Second side',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                )),
                              ),
                      )
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.003)
                          ..rotateX(animation.value * pi)
                          ..translate(0.00, widget.flipWithTranslate ? widget.height * animation.value : 0),
                        child: animation.value < 0.5
                            ? SizedBox(
                                child: widget.startChild != null
                                    ? SizedBox(
                                        height: widget.height,
                                        width: widget.width,
                                        child: widget.startChild,
                                      )
                                    : Container(
                                        height: widget.height,
                                        width: widget.width,
                                        color: Colors.blue,
                                        child: Center(
                                          child: Text(
                                            'First side',
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                              )
                            : SizedBox(
                                child: Center(
                                    child: Transform(
                                  transform: Matrix4.identity()
                                    ..rotateX(pi)
                                    ..translate(0.00, -widget.height),
                                  child: widget.secondChild != null
                                      ? SizedBox(
                                          height: widget.height,
                                          width: widget.width,
                                          child: widget.secondChild,
                                        )
                                      : Container(
                                          height: widget.height,
                                          width: widget.width,
                                          color: Colors.red,
                                          child: Center(
                                            child: Text(
                                              'Second side',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                )),
                              ),
                      ),
      ),
    );
  }
}

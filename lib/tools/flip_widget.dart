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
    this.condition = true,
    this.flipDirection,
    this.animationCurve,
    this.beginnWithFirstState = true,
  });
  final Duration? animationDuration;
  final double height;
  final double width;
  final bool flipWithTranslate;
  final bool beginnWithFirstState;
  final bool condition;
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

class _FlippWidgetState extends State<FlippWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController unactiveController;
  late bool beginnWithFirstState;

  @override
  void initState() {
    super.initState();
    beginnWithFirstState = widget.beginnWithFirstState;
    unactiveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      upperBound: 0.5,
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) unactiveController.reverse();
        },
      );

    controller = AnimationController(
      duration: !beginnWithFirstState ? Duration.zero : widget.animationDuration ?? const Duration(seconds: 1),
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
    if (!beginnWithFirstState) {
      clickFunction();
      controller.duration = widget.animationDuration ?? const Duration(seconds: 1);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    unactiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          clickFunction();
        },
        child: widget.flipDirection == FlipDirection.left
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(-(animation.value + unactiveController.value) * pi)
                  ..translate(
                      widget.flipWithTranslate ? widget.width * (animation.value + unactiveController.value) : 0.01,
                      0.00),
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
                                child: const Center(
                                  child: FittedBox(
                                    child: Text(
                                      'First',
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
                                    child: const Center(
                                      child: FittedBox(
                                        child: Text(
                                          'Second',
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
                      ..rotateY((animation.value + unactiveController.value) * pi)
                      ..translate(
                          widget.flipWithTranslate
                              ? -widget.width * (animation.value + unactiveController.value)
                              : 0.01,
                          0.00),
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
                                    child: const Center(
                                      child: FittedBox(
                                        child: Text(
                                          'First',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
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
                                        child: const Center(
                                          child: FittedBox(
                                            child: Text(
                                              'Second',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
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
                          ..rotateX(-(animation.value + unactiveController.value) * pi)
                          ..translate(
                              0.00,
                              widget.flipWithTranslate
                                  ? -widget.height * (animation.value + unactiveController.value)
                                  : 0),
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
                                        child: const Center(
                                          child: FittedBox(
                                            child: Text(
                                              'First',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
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
                                          child: const Center(
                                            child: FittedBox(
                                              child: Text(
                                                'Second',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
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
                          ..rotateX((animation.value + unactiveController.value) * pi)
                          ..translate(
                              0.00,
                              widget.flipWithTranslate
                                  ? widget.height * (animation.value + unactiveController.value)
                                  : 0),
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
                                        child: const Center(
                                          child: FittedBox(
                                            child: Text(
                                              'First',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
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
                                          child: const Center(
                                            child: FittedBox(
                                              child: Text(
                                                'Second',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
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

  void clickFunction() {
    if (animation.status == AnimationStatus.forward || animation.status == AnimationStatus.completed) {
      if (!widget.condition) {
        unactiveController.forward();
        return;
      }
      controller.reverse();
    } else if (animation.status == AnimationStatus.reverse || animation.status == AnimationStatus.dismissed) {
      if (!widget.condition) {
        unactiveController.forward();
        return;
      }
      controller.forward();
    }
  }
}

// ignore_for_file:  sort_constructors_first
// ignore_for_file: prefer_const_constructors, public_member_api_docs

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amazing_tools/tools/flip_widget.dart';

enum SwitchingTyp { dualState, starSingleState, flipSingleState }

class AmazingSwitcher extends StatefulWidget {
  // Main Konstraktor
  const AmazingSwitcher._internal({
    super.key,
    this.switcherHeight = 40,
    this.switcherWidth = 80,
    this.indicatorRotationAngel = 360,
    this.indicatorChild,
    this.animationDuration,
    this.onFirstPress,
    this.onSecondPress,
    this.onFirstAnimationComplete,
    this.onSecondAnimationComplete,
    this.startText,
    this.secondText,
    this.switcherState2,
    required this.switcherState1,
    required this.switchingTyp,
    this.endStarInnerSize,
    this.startStarInnerSize,
    this.flipDirection,
    this.switcherBoxBorder,
    this.switcherBoxShadowList,
    this.switcherGradientColor,
  });

  // Public Hauptkonstruktor
  const AmazingSwitcher({
    super.key,
    this.switcherHeight = 40,
    this.switcherWidth = 80,
    this.indicatorRotationAngel = 360,
    this.indicatorChild,
    this.animationDuration,
    this.onFirstPress,
    this.onSecondPress,
    this.onFirstAnimationComplete,
    this.onSecondAnimationComplete,
    this.startText,
    this.secondText,
    required this.switcherState1,
    this.switcherState2,
    this.endStarInnerSize = 0.7,
    this.startStarInnerSize = 0.7,
    this.switcherBoxBorder,
    this.switcherBoxShadowList,
    this.switcherGradientColor,
  })  : switchingTyp = SwitchingTyp.dualState,
        flipDirection = null;

  final double switcherHeight;
  final double switcherWidth;
  final double indicatorRotationAngel;
  final double? startStarInnerSize;
  final double? endStarInnerSize;
  final Widget? indicatorChild;
  final Duration? animationDuration;
  final Function? onFirstPress;
  final Function? onSecondPress;
  final Function? onFirstAnimationComplete;
  final Function? onSecondAnimationComplete;
  final SwitchingTyp switchingTyp;
  final Widget? startText;
  final Widget? secondText;
  final AmazingSwitcherState switcherState1;
  final AmazingSwitcherState? switcherState2;
  final FlipDirection? flipDirection;
  final BoxBorder? switcherBoxBorder;
  final List<BoxShadow>? switcherBoxShadowList;
  final List<Color>? switcherGradientColor;

  // Single State Factory
  factory AmazingSwitcher.starSingleState({
    Key? key,
    Function? onFirstPress,
    Function? onSecondPress,
    Function? onFirstAnimationComplete,
    Function? onSecondAnimationComplete,
    double indicatorRotationAngel = 360,
    double starFirsInnerRadius = 0,
    double secondStarInnerRadius = 0.1,
    Color indicatorColor = Colors.blue,
    double starHeads = 7,
    double starHeadsRounding = 0,
    double starValleyRounding = 0,
    Widget? child,
    double? startStarInnerSize = 0.7,
    double? endStarInnerSize = 0.7,
    required AmazingSwitcherState switcherState1,
    AmazingSwitcherState? switcherState2,
  }) {
    return AmazingSwitcher._internal(
      switcherState2: switcherState2,
      switcherState1: switcherState1,
      startStarInnerSize: startStarInnerSize,
      endStarInnerSize: endStarInnerSize,
      switchingTyp: SwitchingTyp.starSingleState,
      key: key,
      indicatorChild: child,
      indicatorRotationAngel: indicatorRotationAngel,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      switcherHeight: 40,
      switcherWidth: 40,
    );
  }

  factory AmazingSwitcher.flipSingleState({
    Key? key,
    final Widget? startSide,
    final Widget? secondSide,
    double height = 40,
    double width = 40,
    Function? onFirstPress,
    Function? onSecondPress,
    Function? onFirstAnimationComplete,
    Function? onSecondAnimationComplete,
    Duration? animationDuration,
    FlipDirection? flipDirection,
  }) {
    return AmazingSwitcher._internal(
      flipDirection: flipDirection,
      animationDuration: animationDuration,
      switcherHeight: height,
      switcherWidth: width,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      startText: startSide,
      secondText: secondSide,
      switcherState1: AmazingSwitcherState(),
      switchingTyp: SwitchingTyp.flipSingleState,
    );
  }

  @override
  State<AmazingSwitcher> createState() => _AmazingSwitcherState();
}

class _AmazingSwitcherState extends State<AmazingSwitcher> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Widget child;
  late AmazingSwitcherState switcherState;

  @override
  void initState() {
    setState(() {
      switcherState = AmazingSwitcherState.copyFrom(state1: widget.switcherState1, state2: null)
          .copyWith(starInnerRadius: widget.startStarInnerSize);
    });
    child = switcherState.child ?? widget.indicatorChild ?? SizedBox();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 500),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener((status) {
        setState(() {
          if (status == AnimationStatus.forward) {
            child = SizedBox();
            switcherState = AmazingSwitcherState.copyFrom(state1: widget.switcherState1, state2: widget.switcherState2);
          } else if (status == AnimationStatus.reverse) {
            switcherState = AmazingSwitcherState.copyFrom(state1: widget.switcherState1, state2: null);
            child = SizedBox();
          }
          if (status == AnimationStatus.completed) {
            if (widget.onFirstAnimationComplete != null) widget.onFirstAnimationComplete!.call();
            if (widget.endStarInnerSize != null) switcherState.starInnerRadius = widget.endStarInnerSize!;
          } else if (status == AnimationStatus.dismissed) {
            if (widget.onSecondAnimationComplete != null) widget.onSecondAnimationComplete!.call();
            if (widget.startStarInnerSize != null) switcherState.starInnerRadius = widget.startStarInnerSize!;
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool presed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.switchingTyp == SwitchingTyp.flipSingleState) {
      return Center(
        child: FlippWidget(
          flipDirection: widget.flipDirection,
          animationDuration: widget.animationDuration,
          startChild: widget.startText,
          secondChild: widget.secondText,
          height: widget.switcherHeight,
          width: widget.switcherWidth,
          onFirstPress: () {
            widget.onFirstPress!.call();
          },
          onFirstAnimationComplete: () {
            widget.onFirstAnimationComplete!.call();
          },
          onSecondPress: () {
            widget.onSecondPress!.call();
          },
          onSecondAnimationComplete: () {
            widget.onSecondAnimationComplete!.call();
          },
        ),
      );
    }
    if (widget.switchingTyp == SwitchingTyp.starSingleState) {
      return Center(
        child: InkWell(
          onTap: () {
            if (!presed) {
              if (widget.onFirstPress != null) widget.onFirstPress!.call();

              _animationController.forward();
              presed = true;
            } else {
              if (widget.onSecondPress != null) widget.onSecondPress!.call();
              _animationController.reverse();
              presed = false;
            }
          },
          child: Transform.rotate(
            angle: widget.indicatorRotationAngel * (2 * pi / 360) * _animationController.value,
            child: AnimatedContainer(
              height: switcherState.indicatorSize,
              width: switcherState.indicatorSize,
              duration: widget.animationDuration ?? Duration(milliseconds: 500),
              decoration: ShapeDecoration(
                color: switcherState.indicatorColor,
                shadows: switcherState.indicatorBoxShadow ??
                    [
                      BoxShadow(
                        blurRadius: 2,
                        blurStyle: BlurStyle.normal,
                        color: Colors.grey[800]!,
                      ),
                    ],
                shape: StarBorder(
                  side: switcherState.indicatorBorder ?? BorderSide(color: Colors.transparent),
                  points: switcherState.starHeadsNumber,
                  innerRadiusRatio: switcherState.starInnerRadius,
                  pointRounding: switcherState.starHeadsRounding,
                  valleyRounding: switcherState.starValleyRounding,
                ),
              ),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: child,
                ),
              ),
              onEnd: () {
                setState(() {
                  child = switcherState.child ?? widget.indicatorChild ?? SizedBox();
                });
              },
            ),
          ),
        ),
      );
    }
    return Center(
      child: Stack(
        children: [
          Container(
            height: widget.switcherHeight,
            width: widget.switcherWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(widget.switcherHeight / 2)),
              boxShadow: widget.switcherBoxShadowList ??
                  [
                    BoxShadow(
                        blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[200]!, offset: Offset(-8, 8)),
                    BoxShadow(
                        blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[400]!, offset: Offset(-6, 6)),
                    BoxShadow(
                        blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[600]!, offset: Offset(-4, 4)),
                    BoxShadow(
                        blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[800]!, offset: Offset(-2, 2)),
                  ],
              border: widget.switcherBoxBorder ?? Border.all(color: Colors.transparent, width: 0),
              color: null,
              gradient: LinearGradient(
                colors: widget.switcherGradientColor != null && widget.switcherGradientColor!.length >= 2
                    ? widget.switcherGradientColor!
                    : [Colors.yellow[100]!, Colors.yellow[800]!],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: presed ? switcherState.child ?? widget.secondText ?? Text(' ') : Text(' '),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: !presed ? switcherState.child ?? widget.startText ?? Text(' ') : Text(' '),
                  ),
                ))
              ],
            ),
          ),
          Positioned(
            left: (widget.switcherWidth - widget.switcherHeight) * _animationController.value,
            height: widget.switcherHeight,
            width: widget.switcherHeight,
            child: SizedBox(
              child: InkWell(
                onTap: () {
                  if (!presed) {
                    if (widget.onFirstPress != null) widget.onFirstPress!.call();

                    _animationController.forward();
                    presed = true;
                  } else {
                    if (widget.onSecondPress != null) widget.onSecondPress!.call();
                    _animationController.reverse();
                    presed = false;
                  }
                },
                child: Transform.rotate(
                  angle: widget.indicatorRotationAngel * (2 * pi / 360) * _animationController.value,
                  child: AnimatedContainer(
                      duration: widget.animationDuration ?? Duration(milliseconds: 500),
                      decoration: ShapeDecoration(
                        color: switcherState.indicatorColor,
                        shadows: switcherState.indicatorBoxShadow ??
                            [
                              BoxShadow(
                                blurRadius: 2,
                                blurStyle: BlurStyle.normal,
                                color: Colors.grey[800]!,
                              ),
                            ],
                        shape: StarBorder(
                          side: switcherState.indicatorBorder ?? BorderSide(color: Colors.transparent),
                          points: switcherState.starHeadsNumber,
                          innerRadiusRatio: switcherState.starInnerRadius,
                          pointRounding: switcherState.starHeadsRounding,
                          valleyRounding: switcherState.starValleyRounding,
                        ),
                      ),
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: widget.indicatorChild ?? SizedBox(),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmazingSwitcherState {
  Color indicatorColor;
  double starHeadsNumber;
  double starInnerRadius;
  double starHeadsRounding;
  double starValleyRounding;
  double indicatorSize;
  Widget? child;
  List<BoxShadow>? indicatorBoxShadow;
  BorderSide? indicatorBorder;

  AmazingSwitcherState({
    this.indicatorColor = Colors.blue,
    this.starHeadsNumber = 7,
    this.starInnerRadius = 0.4,
    this.starHeadsRounding = 0,
    this.starValleyRounding = 0,
    this.indicatorSize = 40,
    this.child,
    this.indicatorBoxShadow,
    this.indicatorBorder,
  });

  factory AmazingSwitcherState.copyFrom({required AmazingSwitcherState state1, AmazingSwitcherState? state2}) {
    if (state2 == null) {
      return AmazingSwitcherState(
          indicatorColor: state1.indicatorColor,
          starHeadsNumber: inputHandeler(state1.starHeadsNumber, 2, 10000),
          starInnerRadius: inputHandeler(state1.starInnerRadius),
          starHeadsRounding: inputHandeler(state1.starHeadsRounding),
          starValleyRounding: inputHandeler(state1.starValleyRounding),
          indicatorSize: state1.indicatorSize,
          child: state1.child,
          indicatorBoxShadow: state1.indicatorBoxShadow,
          indicatorBorder: state1.indicatorBorder);
    } else {
      return AmazingSwitcherState(
        indicatorColor: state2.indicatorColor,
        starHeadsNumber: inputHandeler(state2.starHeadsNumber, 2, 10000),
        starInnerRadius: inputHandeler(state2.starInnerRadius),
        starHeadsRounding: inputHandeler(state2.starHeadsRounding),
        starValleyRounding: inputHandeler(state2.starValleyRounding),
        indicatorSize: state2.indicatorSize,
        child: state2.child,
        indicatorBoxShadow: state2.indicatorBoxShadow,
        indicatorBorder: state2.indicatorBorder,
      );
    }
  }
  AmazingSwitcherState copyWith({
    Color? indicatorColor,
    double? starHeadsNumber,
    double? starInnerRadius,
    double? starHeadsRounding,
    double? starValleyRounding,
    double? indicatorSize,
    Widget? child,
    List<BoxShadow>? indicatorBoxShadow,
    BorderSide? indicatorBorder,
  }) {
    return AmazingSwitcherState(
      indicatorColor: indicatorColor ?? this.indicatorColor,
      starHeadsNumber: starHeadsNumber ?? this.starHeadsNumber,
      starInnerRadius: starInnerRadius ?? this.starInnerRadius,
      starHeadsRounding: starHeadsRounding ?? this.starHeadsRounding,
      starValleyRounding: starValleyRounding ?? this.starValleyRounding,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      child: child ?? this.child,
      indicatorBoxShadow: indicatorBoxShadow ?? this.indicatorBoxShadow,
      indicatorBorder: indicatorBorder ?? this.indicatorBorder,
    );
  }
}

double inputHandeler(double number, [double min = 0, double max = 1]) {
  if (number < min) return min;
  if (number > max) return max;
  return number;
}

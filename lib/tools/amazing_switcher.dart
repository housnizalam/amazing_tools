// ignore_for_file:  sort_constructors_first
// ignore_for_file: prefer_const_constructors, public_member_api_docs

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amazing_tools/tools/flip_widget.dart';

enum SwitchingTyp { dualState, starSingleState, flipSingleState, dualStateVisibility }

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
    this.firstFlipCondition = true,
    this.secondFlipCondition = true,
    this.onFirstUnactive,
    this.onSecondUnactive,
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
    this.onFirstUnactive,
    this.onSecondUnactive,
  })  : switchingTyp = SwitchingTyp.dualState,
        flipDirection = null,
        firstFlipCondition = true,
        secondFlipCondition = true;

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
  final Function? onFirstUnactive;
  final Function? onSecondUnactive;
  final SwitchingTyp switchingTyp;
  final Widget? startText;
  final Widget? secondText;
  final AmazingSwitcherState switcherState1;
  final AmazingSwitcherState? switcherState2;
  final FlipDirection? flipDirection;
  final BoxBorder? switcherBoxBorder;
  final List<BoxShadow>? switcherBoxShadowList;
  final List<Color>? switcherGradientColor;
  final bool firstFlipCondition;
  final bool secondFlipCondition;

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
    final Function? onFirstUnactive,
    final Function? onSecondUnactive,
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
      onFirstUnactive: onFirstUnactive,
      onSecondUnactive: onSecondUnactive,
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
    bool firstFlipCondition = true,
    bool secondFlipCondition = true,
    final Function? onFirstUnactive,
    final Function? onSecondUnactive,
  }) {
    return AmazingSwitcher._internal(
      firstFlipCondition: firstFlipCondition,
      secondFlipCondition: secondFlipCondition,
      flipDirection: flipDirection,
      animationDuration: animationDuration,
      switcherHeight: height,
      switcherWidth: width,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      onFirstUnactive: onFirstUnactive,
      onSecondUnactive: onSecondUnactive,
      startText: startSide,
      secondText: secondSide,
      switcherState1: AmazingSwitcherState(),
      switchingTyp: SwitchingTyp.flipSingleState,
    );
  }
  factory AmazingSwitcher.dualStateVisibility({
    Key? key,
    required AmazingSwitcherState switcherState1,
    final double switcherHeight = 40,
    final double switcherWidth = 80,
    final double indicatorRotationAngel = 360,
    final double? startStarInnerSize = 0.7,
    final double? endStarInnerSize = 0.7,
    final Widget? indicatorChild,
    final Duration? animationDuration,
    final Function? onFirstPress,
    final Function? onSecondPress,
    final Function? onFirstAnimationComplete,
    final Function? onSecondAnimationComplete,
    final Function? onFirstUnactive,
    final Function? onSecondUnactive,
    final Widget? startText,
    final Widget? secondText,
    final AmazingSwitcherState? switcherState2,
  }) {
    return AmazingSwitcher._internal(
      switchingTyp: SwitchingTyp.dualStateVisibility,
      switcherState1: switcherState1,
      switcherState2: switcherState2,
      switcherHeight: switcherHeight,
      switcherWidth: switcherWidth,
      indicatorRotationAngel: indicatorRotationAngel,
      startStarInnerSize: startStarInnerSize,
      endStarInnerSize: endStarInnerSize,
      indicatorChild: indicatorChild,
      animationDuration: animationDuration,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      onFirstUnactive: onFirstUnactive,
      onSecondUnactive: onSecondUnactive,
      startText: startText,
      secondText: secondText,
    );
  }

  @override
  State<AmazingSwitcher> createState() => _AmazingSwitcherState();
}

class _AmazingSwitcherState extends State<AmazingSwitcher> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _unActiveAnimationController;
  late Widget child;
  late AmazingSwitcherState switcherState;

  @override
  void initState() {
    _unActiveAnimationController = AnimationController(
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
          if (status == AnimationStatus.completed) _unActiveAnimationController.reverse();
          if (status == AnimationStatus.dismissed) {
            if (presed && widget.onSecondUnactive != null) widget.onSecondUnactive!.call();
            if (!presed && widget.onFirstUnactive != null) widget.onFirstUnactive!.call();
          }
        },
      );

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
    _unActiveAnimationController.dispose();
    super.dispose();
  }

  bool presed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.switchingTyp == SwitchingTyp.dualStateVisibility) {
      return Center(
        child: Container(
          height: widget.switcherHeight,
          width: widget.switcherWidth < widget.switcherHeight * 2 ? widget.switcherHeight * 2 : widget.switcherWidth,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (presed && widget.secondText != null && _animationController.isCompleted)
                  ? Center(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Center(child: widget.secondText!),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          left: (_animationController.value + _unActiveAnimationController.value) *
                              widget.switcherHeight /
                              4),
                      child: InkWell(
                        onTap: () {
                          if (!presed) {
                            setState(() {
                              switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
                            });

                            if (!switcherState.condition) {
                              _unActiveAnimationController.forward();

                              return;
                            }
                            if (widget.onFirstPress != null) widget.onFirstPress!.call();

                            _animationController.forward();
                            presed = true;
                          } else {
                            setState(() {
                              switcherState =
                                  switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
                            });
                            if (!switcherState.condition) {
                              _unActiveAnimationController.forward();

                              return;
                            }
                            if (widget.onSecondPress != null) widget.onSecondPress!.call();
                            _animationController.reverse();
                            presed = false;
                          }
                        },
                        child: Transform.rotate(
                          angle: presed
                              ? widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value - _unActiveAnimationController.value)
                              : widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value + _unActiveAnimationController.value),
                          child: Container(
                            height: widget.switcherHeight -
                                widget.switcherHeight *
                                    (_animationController.value + _unActiveAnimationController.value),
                            width: widget.switcherHeight -
                                widget.switcherHeight *
                                    (_animationController.value + _unActiveAnimationController.value),
                            decoration: ShapeDecoration(
                              color: widget.switcherState1.indicatorColor,
                              shadows: widget.switcherState1.indicatorBoxShadow ??
                                  [
                                    BoxShadow(
                                      blurRadius: 2,
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.grey[800]!,
                                    ),
                                  ],
                              shape: StarBorder(
                                side: widget.switcherState1.indicatorBorder ?? BorderSide(color: Colors.transparent),
                                points: widget.switcherState1.starHeadsNumber ?? 7,
                                innerRadiusRatio: widget.switcherState1.starInnerRadius ?? 0.7,
                                pointRounding: widget.switcherState1.starHeadsRounding ?? 0,
                                valleyRounding: widget.switcherState1.starValleyRounding ?? 0,
                              ),
                            ),
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: widget.indicatorChild ?? SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              (!presed && widget.startText != null && _animationController.isDismissed)
                  ? Center(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Center(child: widget.startText!),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          right: widget.switcherHeight / 4 -
                              (_animationController.value - _unActiveAnimationController.value) *
                                  widget.switcherHeight /
                                  4),
                      child: InkWell(
                        onTap: () {
                          if (!presed) {
                            setState(() {
                              switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
                            });

                            if (!switcherState.condition) {
                              _unActiveAnimationController.forward();

                              return;
                            }
                            if (widget.onFirstPress != null) widget.onFirstPress!.call();

                            _animationController.forward();
                            presed = true;
                          } else {
                            setState(() {
                              switcherState =
                                  switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
                            });
                            if (!switcherState.condition) {
                              _unActiveAnimationController.forward();

                              return;
                            }
                            if (widget.onSecondPress != null) widget.onSecondPress!.call();
                            _animationController.reverse();
                            presed = false;
                          }
                        },
                        child: Transform.rotate(
                          angle: presed
                              ? widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value - _unActiveAnimationController.value)
                              : widget.indicatorRotationAngel *
                                  (2 * pi / 360) *
                                  (_animationController.value + _unActiveAnimationController.value),
                          child: Container(
                            height: widget.switcherHeight *
                                (_animationController.value - _unActiveAnimationController.value),
                            width: widget.switcherHeight *
                                (_animationController.value - _unActiveAnimationController.value),
                            decoration: ShapeDecoration(
                              color: widget.switcherState2?.indicatorColor ?? widget.switcherState1.indicatorColor,
                              shadows: widget.switcherState2?.indicatorBoxShadow ??
                                  widget.switcherState1.indicatorBoxShadow ??
                                  [
                                    BoxShadow(
                                      blurRadius: 2,
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.grey[800]!,
                                    ),
                                  ],
                              shape: StarBorder(
                                side: widget.switcherState2?.indicatorBorder ??
                                    widget.switcherState1.indicatorBorder ??
                                    BorderSide(color: Colors.transparent),
                                points: widget.switcherState2?.starHeadsNumber ??
                                    widget.switcherState1.starHeadsNumber ??
                                    7,
                                innerRadiusRatio: widget.switcherState2?.starInnerRadius ??
                                    widget.switcherState1.starInnerRadius ??
                                    0.7,
                                pointRounding: widget.switcherState2?.starHeadsRounding ??
                                    widget.switcherState1.starHeadsRounding ??
                                    0,
                                valleyRounding: widget.switcherState2?.starValleyRounding ??
                                    widget.switcherState1.starValleyRounding ??
                                    0,
                              ),
                            ),
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: widget.indicatorChild ?? SizedBox(),
                              ),
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
    if (widget.switchingTyp == SwitchingTyp.flipSingleState) {
      return Center(
        child: FlippWidget(
          condition: !presed ? widget.firstFlipCondition : widget.secondFlipCondition,
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
            switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
            if (!presed) {
              setState(() {
                switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
              });
              if (!switcherState.condition) {
                _unActiveAnimationController.forward();

                return;
              }
              if (widget.onFirstPress != null) widget.onFirstPress!.call();

              _animationController.forward();
              presed = true;
            } else {
              setState(() {
                switcherState = switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
              });
              if (!switcherState.condition) {
                _unActiveAnimationController.forward();

                return;
              }
              if (widget.onSecondPress != null) widget.onSecondPress!.call();
              _animationController.reverse();
              presed = false;
            }
          },
          child: Transform.rotate(
            angle: widget.indicatorRotationAngel * (2 * pi / 360) * _animationController.value +
                _unActiveAnimationController.value * widget.indicatorRotationAngel * (pi / 360),
            child: AnimatedContainer(
              height: switcherState.indicatorSize == null
                  ? 40 - _unActiveAnimationController.value * 40
                  : switcherState.indicatorSize! - _unActiveAnimationController.value * switcherState.indicatorSize!,
              width: switcherState.indicatorSize == null
                  ? 40 - _unActiveAnimationController.value * 40
                  : switcherState.indicatorSize! - _unActiveAnimationController.value * switcherState.indicatorSize!,
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
                  points: switcherState.starHeadsNumber ?? 7,
                  innerRadiusRatio: switcherState.starInnerRadius ?? 0.2,
                  pointRounding: switcherState.starHeadsRounding ?? 0,
                  valleyRounding: switcherState.starValleyRounding ?? 0,
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
            left: presed
                ? (widget.switcherWidth - widget.switcherHeight) *
                    (_animationController.value - _unActiveAnimationController.value)
                : (widget.switcherWidth - widget.switcherHeight) *
                    (_animationController.value + _unActiveAnimationController.value),
            height: widget.switcherHeight,
            width: widget.switcherHeight,
            child: InkWell(
              onTap: () {
                if (!presed) {
                  setState(() {
                    switcherState = switcherState.copyWith(condition: widget.switcherState1.condition);
                  });

                  if (!switcherState.condition) {
                    _unActiveAnimationController.forward();

                    return;
                  }
                  if (widget.onFirstPress != null) widget.onFirstPress!.call();

                  _animationController.forward();
                  presed = true;
                } else {
                  setState(() {
                    switcherState = switcherState.copyWith(condition: widget.switcherState2?.condition ?? true);
                  });
                  if (!switcherState.condition) {
                    _unActiveAnimationController.forward();

                    return;
                  }
                  if (widget.onSecondPress != null) widget.onSecondPress!.call();
                  _animationController.reverse();
                  presed = false;
                }
              },
              child: Transform.rotate(
                angle: presed
                    ? widget.indicatorRotationAngel *
                        (2 * pi / 360) *
                        (_animationController.value - _unActiveAnimationController.value)
                    : widget.indicatorRotationAngel *
                        (2 * pi / 360) *
                        (_animationController.value + _unActiveAnimationController.value),
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
                        points: switcherState.starHeadsNumber ?? 7,
                        innerRadiusRatio: switcherState.starInnerRadius ?? 0.7,
                        pointRounding: switcherState.starHeadsRounding ?? 0,
                        valleyRounding: switcherState.starValleyRounding ?? 0,
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
        ],
      ),
    );
  }
}

class AmazingSwitcherState {
  Color? indicatorColor;
  double? starHeadsNumber;
  double? starInnerRadius;
  double? starHeadsRounding;
  double? starValleyRounding;
  double? indicatorSize;
  bool condition;
  Widget? child;
  List<BoxShadow>? indicatorBoxShadow;
  BorderSide? indicatorBorder;

  AmazingSwitcherState({
    this.indicatorColor,
    this.starHeadsNumber,
    this.starInnerRadius,
    this.starHeadsRounding,
    this.starValleyRounding,
    this.indicatorSize,
    this.condition = true,
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
        indicatorBorder: state1.indicatorBorder,
        condition: state1.condition,
      );
    } else {
      return AmazingSwitcherState(
        indicatorColor: state2.indicatorColor ?? state1.indicatorColor,
        starHeadsNumber:
            inputHandeler(state2.starHeadsNumber, 2, 10000) ?? inputHandeler(state1.starHeadsNumber, 2, 10000),
        starInnerRadius: inputHandeler(state2.starInnerRadius) ?? inputHandeler(state1.starInnerRadius),
        starHeadsRounding: inputHandeler(state2.starHeadsRounding) ?? inputHandeler(state1.starHeadsRounding),
        starValleyRounding: inputHandeler(state2.starValleyRounding) ?? inputHandeler(state1.starValleyRounding),
        indicatorSize: state2.indicatorSize ?? state1.indicatorSize,
        child: state2.child,
        indicatorBoxShadow: state2.indicatorBoxShadow ?? state1.indicatorBoxShadow,
        indicatorBorder: state2.indicatorBorder ?? state1.indicatorBorder,
        condition: state2.condition,
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
    bool? condition,
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
      condition: condition ?? this.condition,
      child: child ?? this.child,
      indicatorBoxShadow: indicatorBoxShadow ?? this.indicatorBoxShadow,
      indicatorBorder: indicatorBorder ?? this.indicatorBorder,
    );
  }
}

double? inputHandeler(double? number, [double min = 0, double max = 1]) {
  if (number == null) return null;
  if (number < min) return min;
  if (number > max) return max;
  return number;
}

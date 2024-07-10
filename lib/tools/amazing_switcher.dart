// ignore_for_file:  sort_constructors_first
// ignore_for_file: prefer_const_constructors, public_member_api_docs

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amazing_tools/tools/flip_widget.dart';

enum SwitchingTyp { dualState, starSingleState, flipSingleState }

class AmazingSwitcher extends StatefulWidget {
  // Main Kontraktor
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
  });

  // Public Hauptkonstruktor
  const AmazingSwitcher(
      {super.key,
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
      this.endStarInnerSize,
      this.startStarInnerSize})
      : switchingTyp = SwitchingTyp.dualState;

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

  // Single State Factory
  factory AmazingSwitcher.starSingleState({
    Key? key,
    Function? onFirstPress,
    Function? onSecondPress,
    Function? onFirstAnimationComplete,
    Function? onSecondAnimationComplete,
    double indicatorRotationAngel = 360,
    double starFirsInnerRadius = 0.8,
    double secondStarInnerRadius = 0.1,
    Color indicatorColor = Colors.blue,
    double starHeads = 7,
    double starHeadsRounding = 0,
    double starValleyRounding = 0,
    Widget? child,
    double? startStarInnerSize,
    double? endStarInnerSize,
    required AmazingSwitcherState switcherState1,
    AmazingSwitcherState? switcherState2,
  }) {
    return AmazingSwitcher._internal(
      switcherState2: switcherState2?.copyWith(switcherGradientColors: <Color>[Colors.transparent, Colors.transparent]),
      switcherState1: switcherState1.copyWith(switcherGradientColors: <Color>[Colors.transparent, Colors.transparent]),
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

  factory AmazingSwitcher.flipSingleState({Key? key, final Widget? startSide}) {
    return AmazingSwitcher._internal(
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
    child = widget.indicatorChild ?? SizedBox();
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
        child: FlippWidget(),
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
                shape: StarBorder(
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
                  child = widget.indicatorChild ?? SizedBox();
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
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: null,
              gradient: LinearGradient(
                  colors: switcherState.switcherGradientColors ?? [Colors.yellow[100]!, Colors.yellow[800]!]),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: widget.secondText ?? Text(' '),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: widget.startText ?? Text(' '),
                  ),
                ))
              ],
            ),
          ),
          Positioned(
            left: (widget.switcherWidth - widget.switcherHeight) * _animationController.value,
            height: widget.switcherHeight,
            width: widget.switcherHeight,
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
                      shape: StarBorder(
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
        ],
      ),
    );
  }
}

class AmazingSwitcherState {
  Color indicatorColor;
  List<Color>? switcherGradientColors;
  double starHeadsNumber;
  double starInnerRadius;
  double starHeadsRounding;
  double starValleyRounding;
  double indicatorSize;
  AmazingSwitcherState({
    this.indicatorColor = Colors.blue,
    this.switcherGradientColors,
    this.starHeadsNumber = 7,
    this.starInnerRadius = 0.7,
    this.starHeadsRounding = 0,
    this.starValleyRounding = 0,
    this.indicatorSize = 40,
  });

  factory AmazingSwitcherState.copyFrom({required AmazingSwitcherState state1, AmazingSwitcherState? state2}) {
    if (state2 == null) {
      return AmazingSwitcherState(
          indicatorColor: state1.indicatorColor,
          switcherGradientColors: state1.switcherGradientColors,
          starHeadsNumber: state1.starHeadsNumber,
          starInnerRadius: state1.starInnerRadius,
          starHeadsRounding: state1.starHeadsRounding,
          starValleyRounding: state1.starValleyRounding,
          indicatorSize: state1.indicatorSize);
    } else {
      return AmazingSwitcherState(
          indicatorColor: state2.indicatorColor,
          switcherGradientColors: state2.switcherGradientColors,
          starHeadsNumber: state2.starHeadsNumber,
          starInnerRadius: state2.starInnerRadius,
          starHeadsRounding: state2.starHeadsRounding,
          starValleyRounding: state2.starValleyRounding,
          indicatorSize: state2.indicatorSize);
    }
  }
  AmazingSwitcherState copyWith({
    Color? indicatorColor,
    List<Color>? switcherGradientColors,
    double? starHeadsNumber,
    double? starInnerRadius,
    double? starHeadsRounding,
    double? starValleyRounding,
    double? indicatorSize,
  }) {
    return AmazingSwitcherState(
        indicatorColor: indicatorColor ?? this.indicatorColor,
        switcherGradientColors: switcherGradientColors ?? this.switcherGradientColors,
        starHeadsNumber: starHeadsNumber ?? this.starHeadsNumber,
        starInnerRadius: starInnerRadius ?? this.starInnerRadius,
        starHeadsRounding: starHeadsRounding ?? this.starHeadsRounding,
        starValleyRounding: starValleyRounding ?? this.starValleyRounding,
        indicatorSize: indicatorSize ?? this.indicatorSize);
  }
}

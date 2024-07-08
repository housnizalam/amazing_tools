// ignore_for_file: prefer_const_constructors, public_member_api_docs

import 'dart:math';
import 'package:flutter/material.dart';

class AmazingSwitcher extends StatefulWidget {
  // Main Kontraktor
  const AmazingSwitcher({
    super.key,
    this.switcherHeight = 40,
    this.switcherWidth = 80,
    this.indicatorRotationAngel = 360,
    this.indicatorColor = Colors.blue,
    this.switcherGradientColors,
    this.starHeads = 7,
    this.indicatorChild,
    this.animationDuration,
    this.starInnerRadius = 0.7,
    this.starHeadsRounding = 0,
    this.starValleyRounding = 0,
    this.onFirstPress,
    this.onSecondPress,
    this.onFirstAnimationComplete,
    this.onSecondAnimationComplete,
    bool singleState = false,
    double secondStarInnerRadius = 0.1,
  })  : _singleState = singleState,
        _secondStarInnerRadius = secondStarInnerRadius;

  final double switcherHeight;
  final double switcherWidth;
  final double indicatorRotationAngel;
  final Color indicatorColor;
  final List<Color>? switcherGradientColors;
  final double starHeads;
  final Widget? indicatorChild;
  final Duration? animationDuration;
  final double starInnerRadius;
  final double starHeadsRounding;
  final double starValleyRounding;
  final Function? onFirstPress;
  final Function? onSecondPress;
  final Function? onFirstAnimationComplete;
  final Function? onSecondAnimationComplete;
  final bool _singleState;
  final double _secondStarInnerRadius;

  // Single State Factory
  factory AmazingSwitcher.singleState({
    Key? key,
    double indicatorRadius = 40,
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
  }) {
    return AmazingSwitcher(
      key: key,
      indicatorChild: child,
      starHeadsRounding: starHeadsRounding,
      starValleyRounding: starValleyRounding,
      starHeads: starHeads,
      indicatorColor: indicatorColor,
      starInnerRadius: starFirsInnerRadius > 1
          ? 1
          : starFirsInnerRadius < 0
              ? 0
              : starFirsInnerRadius,
      indicatorRotationAngel: indicatorRotationAngel,
      onFirstPress: onFirstPress,
      onSecondPress: onSecondPress,
      onFirstAnimationComplete: onFirstAnimationComplete,
      onSecondAnimationComplete: onSecondAnimationComplete,
      switcherHeight: indicatorRadius,
      switcherWidth: indicatorRadius,
      switcherGradientColors: const [Colors.transparent, Colors.transparent],
      singleState: true,
      secondStarInnerRadius: secondStarInnerRadius,
    );
  }

  @override
  State<AmazingSwitcher> createState() => _AmazingSwitcherState();
}

class _AmazingSwitcherState extends State<AmazingSwitcher> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late double starInnerRadius;
  late Widget child;

  @override
  void initState() {
    child = widget.indicatorChild ?? SizedBox();
    starInnerRadius = widget.starInnerRadius;
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
          } else if (status == AnimationStatus.reverse) {
            child = SizedBox();
          }
          if (status == AnimationStatus.completed) {
            if (widget.onFirstAnimationComplete != null) widget.onFirstAnimationComplete!.call();
            starInnerRadius = widget.starInnerRadius;
          } else if (status == AnimationStatus.dismissed) {
            if (widget.onSecondAnimationComplete != null) widget.onSecondAnimationComplete!.call();
            starInnerRadius = widget.starInnerRadius;
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
    return Center(
      child: Stack(
        children: [
          Container(
            height: widget.switcherHeight,
            width: widget.switcherWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: null,
              gradient:
                  LinearGradient(colors: widget.switcherGradientColors ?? [Colors.yellow[100]!, Colors.yellow[800]!]),
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

                  starInnerRadius = widget._secondStarInnerRadius;
                  _animationController.forward();
                  presed = true;
                } else {
                  if (widget.onSecondPress != null) widget.onSecondPress!.call();
                  starInnerRadius = widget._secondStarInnerRadius;
                  _animationController.reverse();
                  presed = false;
                }
              },
              child: Transform.rotate(
                angle: widget.indicatorRotationAngel * (2 * pi / 360) * _animationController.value,
                child: AnimatedContainer(
                  duration: widget.animationDuration ?? Duration(milliseconds: 500),
                  decoration: ShapeDecoration(
                    color: widget.indicatorColor,
                    shape: widget._singleState
                        ? StarBorder(
                            points: widget.starHeads < 2 ? 2 : widget.starHeads,
                            innerRadiusRatio: starInnerRadius,
                            pointRounding: widget.starHeadsRounding,
                            valleyRounding: widget.starValleyRounding)
                        : StarBorder(
                            points: widget.starHeads < 2 ? 2 : widget.starHeads,
                            innerRadiusRatio: widget.starInnerRadius < 0
                                ? 0
                                : widget.starInnerRadius > 1
                                    ? 1
                                    : widget.starInnerRadius,
                            pointRounding: widget.starHeadsRounding < 0
                                ? 0
                                : widget.starHeadsRounding > 1
                                    ? 1
                                    : widget.starHeadsRounding,
                            valleyRounding: widget.starValleyRounding < 0
                                ? 0
                                : widget.starValleyRounding > 1
                                    ? 1
                                    : widget.starValleyRounding,
                          ),
                  ),
                  child: widget._singleState
                      ? FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: child,
                          ),
                        )
                      : FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: widget.indicatorChild ?? SizedBox(),
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
          ),
        ],
      ),
    );
  }
}

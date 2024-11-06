import 'package:flutter/material.dart';

enum AnimationForm { scale, rotate, slide, fade }

/// This is a live widget that moves continuously and repeatedly.
/// The user can easily and completely control the movement of this widget.
/// Parameters:
/// - [child]: [child] is the widget that you want to bring to life. This widget is required.
/// - [animateBegin]: [animateBegin] can determine the start size of the scale animation. Dafault to 0.5
/// - [animateEnd]: [animateEnd] can determine the end size of the scale animation. Dafault to 1
/// - [duration]: [duration]can determine the Duration of the Animation. Dafault to 500 ms
/// - [alignment]: Default to center.
/// - [pading]: Default to 0.
/// - [reverse]:[reverse] Can control the motion repetition, whether it's back and forth or only in one direction. Default to true: back and forth.
/// - [animationStyle]:[animationForm] Can determine the type of Animation(ritate,scale,fade ...) .Default to scale.
/// - [slidePoints]:[slidePoints] determine the points that the child folows. Default to [Offset(0, 0.5), Offset(0, -0.5)].
/// - [stop]:[stop] Enables the user to stop the movement of the widget. Default to false.
/// - [rotationCenter]:[rotationCenter] Enables the user to choose the rotation center of the widget. Default to center.

class LiveWidget extends StatefulWidget {
  final Widget child;
  final double animateBegin;
  final double animateEnd;
  final Duration? duration;
  final Alignment alignment;
  final EdgeInsets pading;
  final bool reverse;
  final AnimationForm animationForm;
  final List<Offset> slidePoints;
  final bool stop;
  final Alignment rotationCenter;

  const LiveWidget(
      {Key? key,
      required this.child,
      this.animateBegin = 0.5,
      this.animateEnd = 1,
      this.duration,
      this.alignment = Alignment.center,
      this.pading = const EdgeInsets.all(0),
      this.reverse = true,
      this.animationForm = AnimationForm.scale,
      this.slidePoints = const [Offset(0, 0.5), Offset(0, -0.5)],
      this.stop = false,
      this.rotationCenter = Alignment.center})
      : super(key: key);

  @override
  _LiveWidgetState createState() => _LiveWidgetState();
}

class _LiveWidgetState extends State<LiveWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationForm == AnimationForm.slide
        ? SlideTransition(
            position: TweenSequence<Offset>(
              List.generate(
                widget.slidePoints.length - 1,
                (index) => TweenSequenceItem(
                  tween: Tween(
                    begin: widget.slidePoints[index],
                    end: widget.slidePoints[index + 1],
                  ),
                  weight: 1.0,
                ),
              ),
            ).animate(
              _animationController
                ..repeat(
                  reverse: widget.reverse,
                  period:
                      widget.stop ? const Duration(days: 10000) : widget.duration ?? const Duration(milliseconds: 500),
                ),
            ),
            child: Container(
              padding: widget.pading,
              alignment: widget.alignment,
              child: widget.child,
            ),
          )
        : widget.animationForm == AnimationForm.rotate
            ? RotationTransition(
                alignment: widget.rotationCenter,
                turns: Tween(
                  begin: widget.animateBegin,
                  end: widget.animateEnd,
                ).animate(
                  _animationController
                    ..repeat(
                      reverse: widget.reverse,
                      period: widget.stop
                          ? const Duration(days: 10000)
                          : widget.duration ?? const Duration(milliseconds: 500),
                    ),
                ),
                child: Container(
                  padding: widget.pading,
                  alignment: widget.alignment,
                  child: widget.child,
                ),
              )
            : widget.animationForm == AnimationForm.fade
                ? FadeTransition(
                    opacity: Tween(
                      begin: widget.animateBegin,
                      end: widget.animateEnd,
                    ).animate(
                      _animationController
                        ..repeat(
                          reverse: widget.reverse,
                          period: widget.stop
                              ? const Duration(days: 10000)
                              : widget.duration ?? const Duration(milliseconds: 500),
                        ),
                    ),
                    child: Container(
                      padding: widget.pading,
                      alignment: widget.alignment,
                      child: widget.child,
                    ),
                  )
                : ScaleTransition(
                    scale: Tween(
                      begin: widget.animateBegin,
                      end: widget.animateEnd,
                    ).animate(
                      _animationController
                        ..repeat(
                          reverse: widget.reverse,
                          period: widget.stop
                              ? const Duration(days: 10000)
                              : widget.duration ?? const Duration(milliseconds: 500),
                        ),
                    ),
                    child: Container(
                      padding: widget.pading,
                      alignment: widget.alignment,
                      child: widget.child,
                    ),
                  );
  }
}

import 'package:flutter/material.dart';

enum AnimationStyle { scale, rotate, slide, fade }

class LifeWidget extends StatefulWidget {
  final Widget child;
  final double animateBeginn;
  final double animateEnd;
  final int duration;
  final Alignment alignment;
  final EdgeInsets pading;
  final bool reverse;
  final AnimationStyle animationStyle;
  final Offset slideBeginn;
  final Offset slideEnd;

  LifeWidget({
    required this.child,
    this.animateBeginn = 0.5,
    this.animateEnd = 1,
    this.duration = 500,
    this.alignment = Alignment.center,
    this.pading = const EdgeInsets.all(0),
    this.reverse = true,
    this.animationStyle = AnimationStyle.scale,
    this.slideBeginn = const Offset(0, 0.5),
    this.slideEnd = const Offset(0, -0.5),
  });
  @override
  _LifeWidget createState() => _LifeWidget();
}

class _LifeWidget extends State<LifeWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    )..repeat(reverse: widget.reverse);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationStyle == AnimationStyle.slide
        ? SlideTransition(
            position: Tween(
              begin: widget.slideBeginn,
              end: widget.slideEnd,
            ).animate(_animationController),
            child: Container(
              padding: widget.pading,
              alignment: widget.alignment,
              child: widget.child,
            ),
          )
        : widget.animationStyle == AnimationStyle.rotate
            ? RotationTransition(
                turns: Tween(
                  begin: widget.animateBeginn,
                  end: widget.animateEnd,
                ).animate(_animationController),
                child: Container(
                  padding: widget.pading,
                  alignment: widget.alignment,
                  child: widget.child,
                ),
              )
            : widget.animationStyle == AnimationStyle.fade
                ? FadeTransition(
                    opacity: Tween(
                      begin: widget.animateBeginn,
                      end: widget.animateEnd,
                    ).animate(_animationController),
                    child: Container(
                      padding: widget.pading,
                      alignment: widget.alignment,
                      child: widget.child,
                    ),
                  )
                : ScaleTransition(
                    scale: Tween(
                      begin: widget.animateBeginn,
                      end: widget.animateEnd,
                    ).animate(_animationController),
                    child: Container(
                      padding: widget.pading,
                      alignment: widget.alignment,
                      child: widget.child,
                    ),
                  );
  }
}

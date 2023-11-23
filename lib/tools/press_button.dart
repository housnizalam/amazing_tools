import 'package:flutter/material.dart';


class PressButton extends StatefulWidget {
  const PressButton({
    this.child,
    this.onPressed,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.style,
    this.onPressShrink,
    this.color,
    super.key,
  });
  final Widget? child;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final double? onPressShrink;
  final Color? color;

  @override
  State<PressButton> createState() => _PressButtonState();
}

class _PressButtonState extends State<PressButton> with TickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(milliseconds: 40),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        if (widget.onLongPress == null && widget.onPressed == null) return;
        _controller.forward();
      },
      onPanCancel: () {
        if (widget.onLongPress == null && widget.onPressed == null) return;
        _controller.reverse();
      },
      onPanEnd: (details) {
        if (widget.onLongPress == null && widget.onPressed == null) return;
        _controller.reverse();
      },
      onTap: () {},
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: widget.onPressShrink ?? 0.8,
        ).animate(_controller),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          onFocusChange: widget.onFocusChange,
          onHover: widget.onHover,
          onLongPress: widget.onLongPress,
          style: ElevatedButton.styleFrom().merge(widget.style).merge(
                ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  disabledBackgroundColor: widget.color == null
                      ? null
                      : Color.fromARGB(
                          0xFF,
                          (widget.color!.red ~/ 4) + 96,
                          (widget.color!.green ~/ 4) + 96,
                          (widget.color!.blue ~/ 4) + 96,
                        ),
                  side: const BorderSide(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                ),
              ),
          child: widget.child ?? Text(''),
        ),
      ),
    );
  }
}
//  Erklärung für die komplizierte Farb findungs logik
// 000 252 000 252
// 000 063 000 063
// 000 127 064 147
// 000 126 000 126
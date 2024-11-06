import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ValueBar {
  Color overTimeColor;
  Color lessTimeColor;
  Color fullTimeColor;
  double width;
  ValueBar({
    this.fullTimeColor = Colors.blue,
    this.lessTimeColor = Colors.yellow,
    this.overTimeColor = Colors.blue,
    this.width = 10,
  });
}

class IndicatorBar {
  Color color;
  Color indicatorBackgroungColor;

  double width;
  IndicatorBar({
    this.color = const Color.fromARGB(255, 143, 138, 138),
    this.indicatorBackgroungColor = Colors.grey,
    this.width = 7,
  });
}

class HorizentalBar {
  Color color;
  int overTime;
  double width;
  HorizentalBar({
    this.color = const Color.fromARGB(255, 143, 138, 138),
    this.width = 8,
    this.overTime = 0,
  });
}

class AnimatedCircularTimer extends StatefulWidget {
  final DateTime von;
  final DateTime bis;
  final Duration? duration;
  final TextStyle? textStyle;
  final double fullzeit;
  final double radius;
  final double widgetHeight;
  final double widgetWidth;
  final double translateX;
  final double translateY;
  final ValueBar? valueBar;
  final IndicatorBar? indicatorBar;
  final HorizentalBar? horizentalBar;
  final Color backgroundColor;
  const AnimatedCircularTimer({
    Key? key,
    required this.von,
    required this.bis,
    this.fullzeit = 8,
    this.radius = 200,
    this.widgetHeight = 400,
    this.widgetWidth = 300,
    this.translateX = 0,
    this.translateY = 0,
    this.textStyle,
    this.duration,
    this.valueBar,
    this.indicatorBar,
    this.horizentalBar,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  State<AnimatedCircularTimer> createState() => _AnimatedCircularTimerState();
}

class _AnimatedCircularTimerState extends State<AnimatedCircularTimer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _barController;
  late double arbeitszeit;
  late double overTime;

  @override
  void initState() {
    if (widget.duration != null) print(widget.duration!.inMilliseconds);
    super.initState();
    arbeitszeit = widget.bis.difference(widget.von).inMinutes / 60;
    if (arbeitszeit.isNegative) arbeitszeit = 0;
    if (arbeitszeit > 11) arbeitszeit = 11;
    overTime = arbeitszeit - widget.fullzeit <= 0 ? 0 : arbeitszeit - widget.fullzeit;
    print(overTime * widget.radius / 3);
    _controller = AnimationController(vsync: this, duration: widget.duration ?? const Duration(milliseconds: 800))
      ..addListener(() {
        setState(() {});
      });
    _barController = AnimationController(vsync: this, duration: widget.duration ?? const Duration(milliseconds: 800))
      ..addListener(() {
        setState(() {});
      });
    startAnimation();
  }

  @override
  void didUpdateWidget(AnimatedCircularTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.von != widget.von || oldWidget.bis != widget.bis) {
      startAnimation();
    }
  }

  void startAnimation() {
    arbeitszeit = widget.bis.difference(widget.von).inMinutes / 60;
    if (arbeitszeit.isNegative) arbeitszeit = 0;
    if (arbeitszeit > 11) arbeitszeit = 11;
    overTime = arbeitszeit - widget.fullzeit <= 0 ? 0 : arbeitszeit - widget.fullzeit;
    _controller.forward(from: 0.0).whenComplete(() => _barController.forward(from: 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    final String stringArbeitszeit = '${arbeitszeit.toInt()}:${((arbeitszeit - arbeitszeit.toInt()) * 60).toInt()}';
    final String stringFullzeit =
        '${widget.fullzeit.toInt()}:${((widget.fullzeit - widget.fullzeit.toInt()) * 60).toInt()}';
    return SizedBox(
      height: widget.widgetHeight,
      width: widget.widgetWidth,
      child: CustomPaint(
        size: Size(widget.widgetHeight, widget.widgetWidth),
        painter: MyPainter(
          barController: _barController,
          controller: _controller,
          translateX: widget.translateX,
          translateY: widget.translateY,
          backgroundColor: widget.backgroundColor,
          radius: widget.radius,
          value: arbeitszeit * 250 / widget.fullzeit,
          overTime: overTime * widget.radius / 3,
          valueBar: widget.valueBar ?? ValueBar(),
          indicatorBar: widget.indicatorBar ?? IndicatorBar(),
          horizentalBar: widget.horizentalBar ?? HorizentalBar(),
        ),
        child: Stack(
          children: [
            Positioned(
              height: widget.radius,
              width: widget.radius,
              top: widget.widgetHeight / 2 - widget.radius * 0.6 + widget.translateY,
              left: widget.widgetWidth / 2 - widget.radius * 0.5 + widget.translateX,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stringArbeitszeit,
                    style: widget.textStyle,
                  ),
                  Text(
                    ' --------',
                    style: widget.textStyle,
                  ),
                  Text(
                    stringFullzeit,
                    style: widget.textStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double value;
  final double radius;
  final double translateX;
  final double translateY;
  final double overTime;
  final AnimationController controller;
  final AnimationController barController;
  final ValueBar valueBar;
  final IndicatorBar indicatorBar;
  final HorizentalBar horizentalBar;
  final Color backgroundColor;
  MyPainter({
    required this.value,
    required this.radius,
    required this.translateX,
    required this.translateY,
    required this.controller,
    required this.barController,
    required this.valueBar,
    required this.indicatorBar,
    required this.horizentalBar,
    required this.backgroundColor,
    required this.overTime,
  }) : super(repaint: Listenable.merge([controller, barController]));
  @override
  void paint(Canvas canvas, Size size) {
    final Offset timerCenter = Offset(size.width / 2 + translateX, size.height / 2 + translateY);
    Color valueColor = value > 250
        ? valueBar.overTimeColor
        : value < 250
            ? valueBar.lessTimeColor
            : valueBar.fullTimeColor;
    final Paint paintIndicator = Paint()
      ..color = indicatorBar.color
      ..strokeWidth = indicatorBar.width
      ..style = PaintingStyle.stroke;
    final Paint paintPoint = Paint()
      ..color = Colors.red
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final Paint paintValue = Paint()
      ..color = valueColor
      ..strokeWidth = valueBar.width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint indicatorBackground = Paint()
      ..color = indicatorBar.indicatorBackgroungColor
      ..style = PaintingStyle.fill;
    final Paint backgorundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final Paint paintHorizentalBar = Paint()
      ..color = horizentalBar.color
      ..strokeWidth = horizentalBar.width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint paintOverTimeBar = Paint()
      ..color = Colors.red
      ..strokeWidth = horizentalBar.width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const double startPoint = 145;
    const double endPointIndecator = 250;
    final fullTimeValue = value > 250 ? 250 : value;
    final p1 = Offset(timerCenter.dx - radius / 2, timerCenter.dy + radius / pi * 0.92);
    final p2 = Offset(timerCenter.dx + radius / 2, timerCenter.dy + radius / pi * 0.92);
    final indicatorPath = Path()
      ..addArc(
          Rect.fromCenter(
            center: timerCenter,
            width: radius,
            height: radius,
          ),
          startPoint * pi / 180,
          endPointIndecator * pi / 180);
    final backgroundPath = Path()
      ..addArc(
          Rect.fromCenter(
            center: timerCenter,
            width: radius,
            height: radius,
          ),
          startPoint * pi / 180,
          endPointIndecator * pi / 180);

    final valuePath = Path()
      ..addArc(
          Rect.fromCenter(
            center: timerCenter,
            width: radius,
            height: radius,
          ),
          startPoint * pi / 180,
          controller.value * fullTimeValue * pi / 180);
    canvas.drawRect(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
      backgorundPaint,
    );
    canvas.drawPath(backgroundPath, indicatorBackground);
    canvas.drawPath(indicatorPath, paintIndicator);
    canvas.drawPath(valuePath, paintValue);
    canvas.drawLine(p1, p2, paintHorizentalBar);
    if (controller.isCompleted) {
      if (overTime > 0) canvas.drawLine(p1, Offset(p1.dx + overTime * (barController.value), p1.dy), paintOverTimeBar);
      canvas.drawPoints(PointMode.points, [Offset(p1.dx + overTime * (barController.value) - 5, p1.dy)], paintPoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

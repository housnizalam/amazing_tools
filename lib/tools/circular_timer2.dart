// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularTimer extends StatefulWidget {
  final DateTime von;
  final DateTime bis;
  final TextStyle? textStyle;
  final double fullzeit;
  final double radius;
  final double widgetHeight;
  final double widgetWidth;
  final double translateX;
  final double translateY;
  const CircularTimer({
    super.key,
    required this.von,
    required this.bis,
    this.fullzeit = 8.5,
    this.radius = 200,
    this.widgetHeight = 400,
    this.widgetWidth = 300,
    this.translateX = 0,
    this.translateY = 0,
    this.textStyle,
  });

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer> {
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    double arbeitszeit = widget.bis.difference(widget.von).inMinutes / 60;
    if (arbeitszeit.isNegative) arbeitszeit = 0;
    final String stringArbeitszeit = '${arbeitszeit.toInt()}:${((arbeitszeit - arbeitszeit.toInt()) * 60).toInt()}';
    final String stringFullzeit =
        '${widget.fullzeit.toInt()}:${((widget.fullzeit - widget.fullzeit.toInt()) * 60).toInt()}';
    return SizedBox(
      height: widget.widgetHeight,
      width: widget.widgetWidth,
      child: CustomPaint(
        size: Size(widget.widgetHeight, widget.widgetWidth),
        painter: MyPainter(
          translateX: widget.translateX,
          translateY: widget.translateY,
          radius: widget.radius,
          value: arbeitszeit > (widget.fullzeit - 0.5) * 1.5
              ? (widget.fullzeit - 0.5) * 1.5 * 250 / widget.fullzeit
              : arbeitszeit * 250 / widget.fullzeit,
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
  MyPainter({
    required this.value,
    required this.radius,
    required this.translateX,
    required this.translateY,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Offset timerCenter = Offset(size.width / 2 + translateX, size.height / 2 + translateY);
    Color valueColor = value > 250 ? Colors.red : Colors.blue;
    final Paint paintIndicator = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;
    final Paint paintValue = Paint()
      ..color = valueColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint indicatorBackground = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;
    final Paint backgorundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    final Paint paintLine = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const double startPoint = 145;
    const double endPointIndecator = 250;

    final double endPointValue = value;
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
          endPointValue * pi / 180);
    canvas.drawRect(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
      backgorundPaint,
    );
    canvas.drawPath(backgroundPath, indicatorBackground);
    canvas.drawPath(indicatorPath, paintIndicator);
    canvas.drawPath(valuePath, paintValue);
    canvas.drawLine(p1, p2, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

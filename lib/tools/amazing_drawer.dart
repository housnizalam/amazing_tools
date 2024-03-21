import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

enum Lines { strait, convex }

class arcPoint {
  final Offset offset;
  final bool glockwiseDirection;
  final double curveX;

  arcPoint({
    required this.offset,
    this.glockwiseDirection = true,
    this.curveX = 1,
  });
}

class AmazingDrawer extends StatefulWidget {
  final double? height;
  final double? width;
  final List<arcPoint> points;
  final Color? color;
  final bool circular;
  final double? horizentalRadius;
  final double? verticalRadius;
  final Offset? center;
  final Offset? centerlizedPoint;
  final Lines drawLine;
  final bool curveDirection;
  final bool border;
  final double borderWidth;
  final Color borderColor;
  final double rotationAngle;
  final double translateX;
  final double translateY;

  const AmazingDrawer({
    Key? key,
    this.horizentalRadius,
    this.verticalRadius,
    this.center,
    this.color,
    this.height,
    this.width,
    this.circular = false,
    this.curveDirection = true,
    this.border = false,
    this.drawLine = Lines.strait,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.rotationAngle = 0,
    this.translateX = 0,
    this.translateY = 0,
    this.centerlizedPoint,
    required this.points,
  }) : super(key: key);

  factory AmazingDrawer.equilaterals({
    Key? key,
    double? height,
    double? width,
    Color? color,
    Lines drawLine = Lines.strait,
    required double side,
    required Offset startPoint,
  }) {
    return AmazingDrawer(
      height: height,
      width: width,
      drawLine: drawLine,
      points: [
        arcPoint(offset: Offset(startPoint.dx, startPoint.dy)),
        arcPoint(offset: Offset(startPoint.dx + side, startPoint.dy)),
        arcPoint(offset: Offset(startPoint.dx + side / 2, startPoint.dy - side * sqrt(3) / 2)),
      ],
      color: color,
    );
  }
  factory AmazingDrawer.square({
    Key? key,
    double? height,
    double? width,
    Color? color,
    Lines drawLine = Lines.strait,
    required double side,
    required Offset startPoint,
  }) {
    return AmazingDrawer(
      height: height,
      width: width,
      drawLine: drawLine,
      points: [
        arcPoint(offset: Offset(startPoint.dx, startPoint.dy)),
        arcPoint(offset: Offset(startPoint.dx + side, startPoint.dy)),
        arcPoint(offset: Offset(startPoint.dx + side, startPoint.dy - side)),
        arcPoint(offset: Offset(startPoint.dx, startPoint.dy - side)),
      ],
      color: color,
    );
  }
  factory AmazingDrawer.oval({
    Key? key,
    double? height,
    double? width,
    Color? color,
    required double horizentalRadius,
    required double verticalRadius,
    required Offset center,
  }) {
    return AmazingDrawer(
      horizentalRadius: horizentalRadius,
      verticalRadius: verticalRadius,
      center: center,
      height: height,
      width: width,
      circular: true,
      points: const [],
      color: color,
    );
  }
  factory AmazingDrawer.circel({
    Key? key,
    double? height,
    double? width,
    Color? color,
    required double radius,
    required Offset center,
  }) {
    return AmazingDrawer(
      horizentalRadius: radius,
      verticalRadius: radius,
      center: center,
      height: height,
      width: width,
      circular: true,
      points: const [],
      color: color,
    );
  }

  @override
  State<AmazingDrawer> createState() => _AmazingDrawerState();
}

class _AmazingDrawerState extends State<AmazingDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Transform.rotate(
      angle: widget.rotationAngle * pi / 180,
      child: CustomPaint(
        size: Size(widget.width ?? width, widget.height ?? height),
        painter: ShapePainter(
          centerlizedPoint: widget.centerlizedPoint,
          translateX: widget.translateX,
          translateY: widget.translateY,
          rotationAngle: widget.rotationAngle,
          border: widget.border,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          drawline: widget.drawLine,
          circular: widget.circular,
          curveDirection: widget.curveDirection,
          center: widget.center,
          points: widget.points,
          color: widget.color ?? Colors.blue,
          horizentalRadius: widget.horizentalRadius,
          verticalRadius: widget.verticalRadius,
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  List<arcPoint> points;
  Color color;
  bool circular;
  bool curveDirection;
  bool border;
  Offset? center;
  Offset? centerlizedPoint;
  double? horizentalRadius;
  double? verticalRadius;
  Lines drawline;
  final double borderWidth;
  final Color borderColor;
  final double rotationAngle;
  final double translateX;
  final double translateY;

  ShapePainter(
      {required this.color,
      required this.circular,
      required this.curveDirection,
      required this.border,
      required this.points,
      required this.drawline,
      required this.borderColor,
      required this.borderWidth,
      required this.translateX,
      required this.translateY,
      this.horizentalRadius,
      this.verticalRadius,
      required this.rotationAngle,
      this.centerlizedPoint,
      this.center});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save(); // Speichern Sie den aktuellen Zustand des Canvas
    Offset centerPoint = Offset(size.width / 2, size.height / 2);
    if (centerlizedPoint != null) {
      Offset shapeCenter = Offset(centerPoint.dx - centerlizedPoint!.dx, centerPoint.dy - centerlizedPoint!.dy);
      canvas.translate(shapeCenter.dx, shapeCenter.dy);
    }

    canvas.translate(translateY, translateX);

    // Wenden Sie die Rotation an
    if (circular) {
      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawOval(Rect.fromCenter(center: center!, width: horizentalRadius!, height: verticalRadius!), paint);
    } else {
      // if (points.length < 2) return;
      Paint paint = Paint()
        ..color = color
        ..style = (points.length < 3) ? PaintingStyle.stroke : PaintingStyle.fill;
      Paint paintBorder = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;

      Path shapePath = Path();
      List<Offset> offsts = [];
      for (var point in points) {
        offsts.add(point.offset);
      }

      shapePath.moveTo(points[0].offset.dx, points[0].offset.dy);

      if (drawline == Lines.strait) {
        shapePath = Path()..addPolygon(offsts, true);
      } else {
        for (var point in points) {
          if (point.curveX == 0) {
            shapePath.lineTo(
              point.offset.dx,
              point.offset.dy,
            );
          } else {
            shapePath.arcToPoint(
              Offset(
                point.offset.dx,
                point.offset.dy,
              ),
              radius: Radius.elliptical(point.curveX, 1),
              clockwise: point.glockwiseDirection,
            );
          }
        }
      }

      shapePath.close();
      canvas.drawPath(shapePath, paint);
      if (border) {
        canvas.drawPath(shapePath, paintBorder);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

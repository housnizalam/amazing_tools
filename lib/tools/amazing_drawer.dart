// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArcPoint {
  final Offset offset;
  final bool glockwiseDirection;
  final double curveX;

  ArcPoint({
    required this.offset,
    this.glockwiseDirection = true,
    this.curveX = 0,
  });
}

class AmazingBorder {
  double width;
  Color color;
  AmazingBorder({
    this.width = 1,
    this.color = Colors.black,
  });
}

class AmazingDrawer extends StatefulWidget {
  final double? drawSheetHeight;
  final double? drawSheetWidth;
  final List<ArcPoint> points;
  final Color? color;
  final Color? backgroundColor;
  final bool _circular;
  final double? _horizentalRadius;
  final double? _verticalRadius;
  final Offset? _center;
  final Offset? rotateCenter;
  final AmazingBorder? border;
  final double shapeRotationAngle;
  final double seiteRotationAngle;
  final double translateX;
  final double translateY;
  final List<Widget>? children;
  static Offset? shapeCenter;
  final VoidCallback? onTap;

  const AmazingDrawer({
    bool circular = false,
    Key? key,
    double? horizentalRadius,
    double? verticalRadius,
    Offset? center,
    this.color,
    this.backgroundColor,
    this.drawSheetHeight,
    this.drawSheetWidth,
    this.border,
    this.shapeRotationAngle = 0,
    this.seiteRotationAngle = 0,
    this.translateY = 0,
    this.translateX = 0,
    this.rotateCenter,
    this.children,
    this.onTap,
    required this.points,
  })  : _center = center,
        _verticalRadius = verticalRadius,
        _horizentalRadius = horizentalRadius,
        _circular = circular,
        super(key: key);

  factory AmazingDrawer.equilaterals({
    Key? key,
    Color? color,
    Color? backgroundColor,
    double shapeRotationAngle = 0,
    double seiteRotationAngle = 0,
    double translateX = 0,
    double translateY = 0,
    Offset? rotateCenter,
    AmazingBorder? border,
    final List<Widget>? children,
    required double side,
    required Offset startPoint,
    final VoidCallback? onTap,
  }) {
    return AmazingDrawer(
      seiteRotationAngle: seiteRotationAngle,
      onTap: onTap,
      shapeRotationAngle: shapeRotationAngle,
      border: border,
      backgroundColor: backgroundColor,
      translateX: translateX,
      translateY: translateY,
      rotateCenter: rotateCenter,
      points: [
        ArcPoint(offset: Offset(startPoint.dx, startPoint.dy)),
        ArcPoint(offset: Offset(startPoint.dx + side, startPoint.dy)),
        ArcPoint(offset: Offset(startPoint.dx + side / 2, startPoint.dy - side * sqrt(3) / 2)),
      ],
      color: color,
      children: children,
    );
  }
  factory AmazingDrawer.square({
    Key? key,
    Color? color,
    Color? backgroundColor,
    AmazingBorder? border,
    double shapeRotationAngle = 0,
    double seiteRotationAngle = 0,
    double translateX = 0,
    double translateY = 0,
    Offset? rotateCenter,
    required double side,
    required Offset startPoint,
    final VoidCallback? onTap,
    final List<Widget>? children,
  }) {
    return AmazingDrawer(
      onTap: onTap,
      shapeRotationAngle: shapeRotationAngle,
      seiteRotationAngle: seiteRotationAngle,
      backgroundColor: backgroundColor,
      border: border,
      translateX: translateX,
      translateY: translateY,
      rotateCenter: rotateCenter,
      points: [
        ArcPoint(offset: Offset(startPoint.dx, startPoint.dy)),
        ArcPoint(offset: Offset(startPoint.dx + side, startPoint.dy)),
        ArcPoint(offset: Offset(startPoint.dx + side, startPoint.dy - side)),
        ArcPoint(offset: Offset(startPoint.dx, startPoint.dy - side)),
      ],
      color: color,
      children: children,
    );
  }
  factory AmazingDrawer.oval({
    Key? key,
    Color? color,
    Color? backgroundColor,
    AmazingBorder? border,
    double shapeRotationAngle = 0,
    double seiteRotationAngle = 0,
    double translateX = 0,
    double translateY = 0,
    Offset? rotateCenter,
    required double horizentalRadius,
    required double verticalRadius,
    required Offset center,
    final VoidCallback? onTap,
    final List<Widget>? children,
  }) {
    return AmazingDrawer(
      border: border,
      horizentalRadius: horizentalRadius,
      verticalRadius: verticalRadius,
      center: center,
      shapeRotationAngle: shapeRotationAngle,
      seiteRotationAngle: seiteRotationAngle,
      translateX: translateX,
      translateY: translateY,
      circular: true,
      points: const [],
      color: color,
      backgroundColor: backgroundColor,
      rotateCenter: rotateCenter,
      onTap: onTap,
      children: children,
    );
  }
  factory AmazingDrawer.circel({
    Key? key,
    Color? color,
    Color? backgroundColor,
    AmazingBorder? border,
    double translateX = 0,
    double translateY = 0,
    required double radius,
    required Offset center,
    final VoidCallback? onTap,
    final List<Widget>? children,
  }) {
    return AmazingDrawer(
      border: border,
      horizentalRadius: radius,
      verticalRadius: radius,
      translateX: translateX,
      translateY: translateY,
      center: center,
      circular: true,
      points: const [],
      color: color,
      backgroundColor: backgroundColor,
      onTap: onTap,
      children: children,
    );
  }

  @override
  State<AmazingDrawer> createState() => _AmazingDrawerState();
}

class _AmazingDrawerState extends State<AmazingDrawer> with TickerProviderStateMixin {
  ValueNotifier<Offset> tapPosition = ValueNotifier(Offset.zero);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Transform.rotate(
      angle: widget.seiteRotationAngle * pi / 180,
      child: GestureDetector(
        onTapDown: (details) {
          tapPosition.value = details.localPosition;
        },
        child: ColoredBox(
          color: widget.backgroundColor ?? Colors.transparent,
          child: CustomPaint(
            size: Size(widget.drawSheetWidth ?? width, widget.drawSheetHeight ?? height),
            painter: ShapePainter(
              onTap: widget.onTap,
              details: tapPosition,
              translateX: widget.translateX,
              translateY: widget.translateY,
              rotationAngle: widget.shapeRotationAngle,
              rotateCenter: widget.rotateCenter,
              border: widget.border,
              circular: widget._circular,
              center: widget._center,
              points: widget.points,
              color: widget.color ?? Colors.blue,
              horizentalRadius: widget._horizentalRadius,
              verticalRadius: widget._verticalRadius,
            ),
            child: Center(
              child: Stack(
                children: widget.children ?? [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  List<ArcPoint> points;
  Color color;
  bool circular;
  AmazingBorder? border;
  Offset? center;
  Offset? rotateCenter;
  double? horizentalRadius;
  double? verticalRadius;
  final double rotationAngle;
  double translateX;
  double translateY;
  final ValueNotifier<Offset> details;
  final VoidCallback? onTap;

  ShapePainter({
    required this.color,
    required this.circular,
    required this.border,
    required this.points,
    required this.translateX,
    required this.translateY,
    this.horizentalRadius,
    this.verticalRadius,
    required this.rotationAngle,
    required this.details,
    required this.onTap,
    this.rotateCenter,
    this.center,
  }) : super(repaint: details);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    Offset shapsCenter;
    Path shapePath = Path();
    if (circular) {
      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      shapsCenter = Offset(
        center!.dx + translateX,
        center!.dy + translateY,
      );
      AmazingDrawer.shapeCenter = shapsCenter;

      canvas.translate(shapsCenter.dx, shapsCenter.dy);
      canvas.rotate(rotationAngle * pi / 180);
      Path path = Path()
        ..addOval(
          Rect.fromCenter(
            center: Offset(
              center!.dx + translateX - shapsCenter.dx,
              center!.dy + translateY - shapsCenter.dy,
            ),
            width: horizentalRadius!,
            height: verticalRadius!,
          ),
        );

      Offset clickedPoint = Offset(
        details.value.dx + translateX - shapsCenter.dx,
        details.value.dy + translateY - shapsCenter.dy,
      );
      if (path.contains(clickedPoint) && onTap != null) {
        onTap!();
      }

      canvas.drawPath(path, paint);
    } else {
      shapsCenter = shapeCenter(points);
      shapsCenter = Offset(shapsCenter.dx + translateX, shapsCenter.dy + translateY);
      AmazingDrawer.shapeCenter = shapsCenter;

      rotateCenter ??= shapsCenter;
      Paint paint = Paint()
        ..color = color
        ..style = (points.length < 3) ? PaintingStyle.stroke : PaintingStyle.fill;

      shapePath = Path();

      shapePath.moveTo(
        points[0].offset.dx + translateX - rotateCenter!.dx,
        points[0].offset.dy + translateY - rotateCenter!.dy,
      );

      for (var point in points) {
        if (point.curveX == 0) {
          shapePath.lineTo(
            point.offset.dx + translateX - rotateCenter!.dx,
            point.offset.dy + translateY - rotateCenter!.dy,
          );
        } else {
          shapePath.arcToPoint(
            Offset(
              point.offset.dx + translateX - rotateCenter!.dx,
              point.offset.dy + translateY - rotateCenter!.dy,
            ),
            radius: Radius.elliptical(point.curveX, 1),
            clockwise: point.glockwiseDirection,
          );
        }
      }

      shapePath.close();
      Offset clickedPoint = Offset(
        details.value.dx + translateX - rotateCenter!.dx,
        details.value.dy + translateY - rotateCenter!.dy,
      );
      if (shapePath.contains(clickedPoint) && onTap != null) {
        onTap!();
      }
      canvas.translate(rotateCenter!.dx, rotateCenter!.dy);
      canvas.rotate(rotationAngle * pi / 180);

      canvas.drawPath(shapePath, paint);
    }
    if (border != null) {
      Paint paintBorder = Paint()
        ..color = border!.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = border!.width;
      if (circular) {
        canvas.drawOval(
          Rect.fromCenter(
              center: Offset(
                center!.dx + translateX - shapsCenter.dx,
                center!.dy + translateY - shapsCenter.dy,
              ),
              width: horizentalRadius!,
              height: verticalRadius!),
          paintBorder,
        );
      } else {
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

Offset shapeCenter(List<ArcPoint> points) {
  double shapeMaxX = 0;
  double shapeMaxY = 0;
  double shapeMiniX = 1000000;
  double shapeMiniY = 1000000;
  for (var point in points) {
    if (shapeMaxX < point.offset.dx) {
      shapeMaxX = point.offset.dx;
    }
    if (shapeMaxY < point.offset.dy) {
      shapeMaxY = point.offset.dy;
    }
    if (shapeMiniY > point.offset.dy) {
      shapeMiniY = point.offset.dy;
    }
    if (shapeMiniX > point.offset.dx) {
      shapeMiniX = point.offset.dx;
    }
  }
  return Offset(
    shapeMiniX + (shapeMaxX - shapeMiniX) / 2,
    shapeMiniY + (shapeMaxY - shapeMiniY) / 2,
  );
}

import 'package:amazing_tools/tools/amazing_drawer.dart';
import 'package:amazing_tools/tools/live_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<ArcPoint> points = [
  ArcPoint(
    offset: Offset(50, 80),
    curveX: 0,
  ),
  ArcPoint(
    offset: Offset(140, 80),
    curveX: 5,
  ),
  ArcPoint(offset: Offset(210, 80), curveX: 1.4, glockwiseDirection: true),
  ArcPoint(offset: Offset(300, 80), curveX: 5),
  ArcPoint(offset: Offset(300, 110), curveX: 0.6),
  ArcPoint(offset: Offset(50, 110), curveX: 0),
  ArcPoint(offset: Offset(50, 80), curveX: 0.6),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body:
          // AmazingDrawer.equilaterals(
          //   border: AmazingBorder(),
          //   onTap: () {
          //     print('hi');
          //   },
          //   side: 200,
          //   startPoint: Offset(100, 300),
          // )
          AmazingDrawer(
        backgroundColor: Colors.grey,
        seiteRotationAngle: -90,
        drawLine: Lines.convex,
        points: points,
        border: AmazingBorder(),
        onTap: () {
          print('hi');
        },
      ),
      //     AmazingDrawer.oval(
      //   border: AmazingBorder(),
      //   verticalRadius: 100,
      //   horizentalRadius: 200,
      //   center: Offset(200, 300),
      //   rotationAngle: 90,
      //   onTap: () {
      //     print('hi');
      //   },
      // ),
    );
  }
}

          //     AmazingDrawer(
          //   translateY: -50,
          //   translateX: 16,
          //   centerlizedPoint: Offset(175, 95),
          //   rotationAngle: 0,
          //   drawLine: Lines.convex,
          //   points: points,
          //   border: AmazingBorder(),
          //   children: [
          //     Positioned(
          //       top: height / 2,
          //       left: width / 2,
          //       child: LiveWidget(
          //         animateEnd: 3,
          //         child: Text('hallo'),
          //       ),
          //     ),
          //     Positioned(
          //       top: height / 1.5,
          //       left: width / 1.8,
          //       child: AmazingDrawer(
          //         translateY: -50,
          //         translateX: 16,
          //         centerlizedPoint: Offset(175, 95),
          //         rotationAngle: 180,
          //         drawLine: Lines.convex,
          //         points: points,
          //         border: AmazingBorder(),
          //       ),
          //     ),
          //     Positioned(
          //       top: height / 1.9,
          //       left: width / 1.44,
          //       child: AmazingDrawer(
          //         translateY: -50,
          //         translateX: 16,
          //         centerlizedPoint: Offset(175, 95),
          //         rotationAngle: 90,
          //         drawLine: Lines.convex,
          //         points: points,
          //         border: AmazingBorder(),
          //       ),
          //     ),
          //     Positioned(
          //       top: height / 1.73,
          //       left: width / 2.8,
          //       child: AmazingDrawer(
          //         translateY: -50,
          //         translateX: 16,
          //         centerlizedPoint: Offset(175, 95),
          //         rotationAngle: -90,
          //         drawLine: Lines.convex,
          //         points: points,
          //         border: AmazingBorder(),
          //       ),
          //     ),
          //   ],
          // ),

          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     SizedBox(),
          //     ElevatedButton(
          //       onPressed: () {
          //         AnimatedDialog.slide(
          //           titelDekoration: TitelDekoration.warnung,
          //           title: 'Slide Titel',
          //           titelSize: 30,
          //           child: Text('slide'),
          //           context: context,
          //           startOffset: Offset(1, 0),
          //         );
          //       },
          //       child: Text('Slide dialog'),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         AnimatedDialog.scale(child: SizedBox(height: 100, width: 100, child: Text('Scale')), context: context);
          //       },
          //       child: Text('Scale dialog'),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         AnimatedDialog.warnung(
          //           context: context,
          //           textStyle: TextStyle(color: Colors.blue),
          //         );
          //       },
          //       child: Text('Warning dialog'),
          //     ),
          //     SizedBox(),
          //     SizedBox(),
          //   ],
          // ),
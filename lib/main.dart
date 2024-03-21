import 'package:amazing_tools/tools/amazing_drawer.dart';
import 'package:amazing_tools/tools/live_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<arcPoint> points = [
  arcPoint(offset: Offset(50, 80), curveX: 0),
  arcPoint(offset: Offset(140, 80), curveX: 5),
  arcPoint(offset: Offset(210, 80), curveX: 1.4, glockwiseDirection: false),
  arcPoint(offset: Offset(300, 80), curveX: 5),
  arcPoint(offset: Offset(300, 110), curveX: 0.6),
  arcPoint(offset: Offset(50, 110), curveX: 0),
  arcPoint(offset: Offset(50, 80), curveX: 0.6),
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
  bool stop = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: LiveWidget(
          duration: Duration(seconds: 3),
          animationForm: AnimationForm.rotate,
          reverse: false,
          animateBegin: 0,
          animateEnd: 1,
          stop: false,
          child: AmazingDrawer(
            centerlizedPoint: Offset(175, 95),
            rotationAngle: -0,
            drawLine: Lines.convex,
            curveDirection: true,
            points: points,
            border: true,
            borderWidth: 2,
          ),
        ),
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
      ),
    );
  }
}

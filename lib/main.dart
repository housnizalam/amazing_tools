import 'package:amazing_tools/tools/life_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    return Scaffold(
      appBar: AppBar(),
      body: LifeWidget(
        animateBeginn: 0,
        animateEnd: 1,
        animationStyle: AnimationStyle.scale,
        slideBeginn: Offset(0, 0),
        slideEnd: Offset(1, 1),
        child: SizedBox(
          height: 200,
          width: 200,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

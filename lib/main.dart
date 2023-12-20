import 'package:amazing_tools/tools/animated_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            ElevatedButton(
              onPressed: () {
                AnimatedDialog.slide(
                  titelDekoration: TitelDekoration.warnung,
                  title: 'Slide Titel',
                  titelSize: 30,
                  child: Text('slide'),
                  context: context,
                  startOffset: Offset(1, 0),
                );
              },
              child: Text('Slide dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedDialog.scale(child: SizedBox(height: 100, width: 100, child: Text('Scale')), context: context);
              },
              child: Text('Scale dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                AnimatedDialog.warnung(
                  context: context,
                  textStyle: TextStyle(color: Colors.blue),
                );
              },
              child: Text('Warning dialog'),
            ),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

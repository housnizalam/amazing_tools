import 'package:amazing_tools/tools/calender/models/calendar_state_classe.dart';
import 'package:amazing_tools/tools/flip_widget.dart';

import 'package:flutter/material.dart';

void main() {
  CalendarState.getInstance(
    selectedMonth: DateTime.now(),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: FlippWidget(
        // flipWithTranslate: true,
        flipDirection: FlipDirection.left,
        height: 100,
        width: 150,
        startChild: Container(
          color: Colors.yellow,
          child: Center(
            child: Text(
              'First side',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
        secondChild: Container(
          color: Colors.green,
          child: Center(
            child: Text(
              'Second side',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
        // onFirstPress: () => print('first Press'),
        // onSecondPress: () => print('second Press'),
        // onFirstAnimationComplete: () => print('first Animation Complete'),
        // onSecondAnimationComplete: () => print('second Animation Complete'),
      ),

      // AmazingSwitcher.singleState(
      //   child: Text('Hallo'),
      //   starHeadsRounding: 0.4,
      //   secondStarInnerRadius: 0.1,
      //   starFirsInnerRadius: 0.8,
      //   onFirstPress: () {
      //     print('press1');
      //   },
      //   onSecondPress: () {
      //     print('press2');
      //   },
      //   onFirstAnimationComplete: () {
      //     print('on first Animation Complete');
      //   },
      //   onSecondAnimationComplete: () {
      //     print('on second Animation Complete');
      //   },
      // ),
      // AmazingSwitcher(
      //   onFirstPress: () {
      //     print('press1');
      //   },
      //   onSecondPress: () {
      //     print('press2');
      //   },
      //   onFirstAnimationComplete: () {
      //     print('on first Animation Complete');
      //   },
      //   onSecondAnimationComplete: () {
      //     print('on second Animation Complete');
      //   },
      // ),
    );
  }
}

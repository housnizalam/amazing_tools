import 'package:amazing_tools/tools/amazing_switcher.dart';
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
      body: AmazingSwitcher(
        // startSide: Text('one'),
        // secondSide: Text('two'),
        // flipDirection: FlipDirection.down,
        // startSide: Icon(
        //   Icons.star,
        //   size: 100,
        // ),

        // secondSide: Transform.rotate(
        //   angle: 3.14,
        //   child: Icon(
        //     Icons.star,
        //     size: 100,
        //     color: Colors.blue,
        //   ),
        // ),
        animationDuration: Duration(milliseconds: 300),
        startStarInnerSize: 0.4,
        endStarInnerSize: 0.4,
        indicatorRotationAngel: 360,
        switcherState1: AmazingSwitcherState(starInnerRadius: 0.4, starHeadsNumber: 9),
        switcherState2: AmazingSwitcherState(starInnerRadius: 0.4, starHeadsNumber: 4, starValleyRounding: 1),
        startText: Text(
          'one',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        secondText: Text(
          'Two',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        // AmazingSwitcher(
        onFirstPress: () {
          print('press1');
        },
        onSecondPress: () {
          print('press2');
        },
        onFirstAnimationComplete: () {
          print('on first Animation Complete');
        },
        onSecondAnimationComplete: () {
          print('on second Animation Complete');
        },
        // ),
      ),
    );
  }
}

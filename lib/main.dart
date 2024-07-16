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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switcher = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(switcher ? 'Active' : 'Unactive'),
        onPressed: () {
          setState(() {
            switcher = !switcher;
            print(switcher);
          });
        },
      ),
      body: AmazingSwitcher.dualStateVisibility(
        // flipDirection: FlipDirection.right,
        // height: 100,
        // width: 100,
        // firstFlipCondition: switcher,
        // secondFlipCondition: switcher,
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
        // onFirstUnactive: () {
        //   print('first unactive');
        // },
        // onSecondUnactive: null,
        // indicatorRotationAngel: 360,
        switcherState1: AmazingSwitcherState(
          starHeadsNumber: 4,
          indicatorColor: Colors.red,
          condition: switcher,
        ),
        // switcherState2: AmazingSwitcherState(condition: switcher, indicatorColor: Colors.black, indicatorSize: 30),
        // // startText: Text(
        // //   'one',
        // //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        // // ),
        // // secondText: Text(
        // //   'Two',
        // //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        // // ),
        // // AmazingSwitcher(
        // onFirstPress: () {
        //   print('press1');
        // },
        // onSecondPress: () {
        //   print('press2');
        // },
        // onFirstAnimationComplete: () {
        //   print('on first Animation Complete');
        // },
        // onSecondAnimationComplete: () {
        //   print('on second Animation Complete');
        // },
        // ),
      ),
    );
  }
}

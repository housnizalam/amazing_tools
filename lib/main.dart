import 'package:amazing_tools/tools/amazing_switcher.dart';
import 'package:amazing_tools/tools/calender/models/calendar_state_classe.dart';

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
        body: AmazingSwitcher.singleState(
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
        )
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

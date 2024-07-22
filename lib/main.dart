import 'dart:math';

import 'package:amazing_tools/tools/amazing-_list.dart';
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
  List<Widget> widgetitems = <Widget>[];
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
              widgetitems = items();
              print(switcher);
            });
          },
        ),
        body: Container(
          color: Colors.grey[400],
          child: AmazingList(
            addedItem: Center(child: Text('added Item')),
            items: items(),
            onSwipeLeft: () {
              print('swipe left');
            },
            onSwipeRight: () {
              print('swipe right');
            },
          ),
        )
        // AmazingSwitcher.dualScaleState(
        //   // beginnWithFirstState: false,
        //   switcherGradientColor: [Colors.black, Colors.blue, Colors.white],
        //   // flipDirection: FlipDirection.right,
        //   // switcherHeight: 90,
        //   // switcherWidth: 100,
        //   // firstFlipCondition: switcher,
        //   // secondFlipCondition: switcher,
        //   // startSide: Icon(
        //   //   Icons.star,
        //   //   size: 100,
        //   // ),

        //   // secondSide: Transform.rotate(
        //   //   angle: 3.14,
        //   //   child: Icon(
        //   //     Icons.star,
        //   //     size: 100,
        //   //     color: Colors.blue,
        //   //   ),
        //   // ),
        //   // onFirstUnactive: () {
        //   //   print('first unactive');
        //   // },
        //   // onSecondUnactive: null,
        //   indicatorRotationAngel: 180,
        //   switcherState1: AmazingSwitcherState(
        //     starHeadsNumber: 9,
        //     indicatorColor: Colors.white,
        //     condition: switcher,
        //   ),
        //   // switcherState2: AmazingSwitcherState(condition: switcher),
        //   switcherState2: AmazingSwitcherState(condition: switcher, indicatorColor: Colors.black, starHeadsNumber: 3),
        //   startText: Text(
        //     'One',
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //   ),
        //   secondText: Text(
        //     'Two',
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        //   ),
        //   // // secondText: Text(
        //   // //   'Two',
        //   // //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //   // // ),
        //   // // AmazingSwitcher(
        //   // switcherHeight: 30,
        //   // switcherWidth: 200,
        //   onFirstPress: () => print('press1'),
        //   onSecondPress: () => print('press2'),
        //   onFirstAnimationComplete: () => print('on first Animation Complete'),

        //   onSecondAnimationComplete: () => print('on second Animation Complete'),
        //   onSecondUnactive: () => print('onSecondUnactive'),
        //   onFirstUnactive: () => print('onFirstUnactive'),
        //   // ),
        // ),
        );
  }
}

List<Widget> items() {
  List<Widget> result = [];
  List<String> stringitems = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5'];
  for (var string in stringitems) {
    result.add(
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print(string);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 100,
              child: Center(child: Text(string)),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow:
                    // gradient Elevation geben
                    [
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[200]!,
                      offset: const Offset(-8, 8)),
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[400]!,
                      offset: const Offset(-6, 6)),
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[600]!,
                      offset: const Offset(-4, 4)),
                  BoxShadow(
                      blurRadius: 4,
                      blurStyle: BlurStyle.normal,
                      color: Colors.grey[800]!,
                      offset: const Offset(-2, 2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  return result;
}

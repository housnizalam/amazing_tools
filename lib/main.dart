import 'package:amazing_tools/tools/calender/models/calendar_state_classe.dart';
import 'package:amazing_tools/tools/calender/month_view.dart';
import 'package:amazing_tools/tools/amazing_tab_bar_view.dart';

import 'package:flutter/material.dart';

void main() {
  CalendarState.getInstance(
    selectedMonth: DateTime.now(),
  );
  runApp(const MyApp());
}

//

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
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
    return Center(
      child: AmazingTabBarView(
        pageHeitToBar: 6,
        labelWidgets: [
          Text('blue'),
          Text('red'),
        ],
        pageWidgets: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.red,
          )
        ],
      ),
    );
  }
}

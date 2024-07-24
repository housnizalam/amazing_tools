import 'package:amazing_tools/tools/amazing-_list.dart';
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
  int index = 0;
  final addedList = items();
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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AmazingList.scaleAnimation(
              backgroundBorder: Border.all(color: Colors.black, width: 4),
              backgroundGradientColors: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.red],
              ),
              // listBackgroundColor: Colors.blue[100]!,
              // addItemOffset:
              //     AnimatedOffset(begin: Offset(1, 0), end: Offset(0, 0), duration: Duration(milliseconds: 300)),
              // removeItemOffset:
              //     AnimatedOffset(begin: Offset(-1, 0), end: Offset(0, 0), duration: Duration(milliseconds: 300)),
              onAddItem: () {
                setState(() {
                  index++;
                });
              },
              addedItem: addedList[index % addedList.length],
              items: items(),
            ),
          ],
        ));
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
                      blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[200]!, offset: const Offset(0, 8)),
                  BoxShadow(
                      blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[400]!, offset: const Offset(0, 6)),
                  BoxShadow(
                      blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[600]!, offset: const Offset(0, 4)),
                  BoxShadow(
                      blurRadius: 4, blurStyle: BlurStyle.normal, color: Colors.grey[800]!, offset: const Offset(0, 2)),
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

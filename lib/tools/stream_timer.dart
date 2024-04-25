import 'dart:async';

import 'package:amazing_tools/tools/circular_timer2.dart';
import 'package:flutter/material.dart';

class TimeStreamer extends StatefulWidget {
  @override
  _TimeStreamerState createState() => _TimeStreamerState();
}

class _TimeStreamerState extends State<TimeStreamer> {
  final _streamController = StreamController<int>();
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = 0;
    _startSendingValues();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _startSendingValues() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      counter++;
      // Hier kannst du den Wert ändern, den du senden möchtest
      _streamController.sink.add(DateTime.now().millisecondsSinceEpoch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Stream Demo'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            return CircularTimer(von: DateTime(2024, 04, 25, 8, 0), bis: DateTime(2024, 04, 25, 8, 0 + counter));
          },
        ),
      ),
    );
  }
}

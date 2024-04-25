import 'dart:async';

import 'package:amazing_tools/tools/circular_timer2.dart';
import 'package:flutter/material.dart';

class TimeStreamer extends StatefulWidget {
  @override
  _TimeStreamerState createState() => _TimeStreamerState();
}

class _TimeStreamerState extends State<TimeStreamer> {
  final _streamController = StreamController<int>();
  late int minutes;
  late bool close;

  @override
  void initState() {
    super.initState();
    minutes = 0;
    close = false;
    _startSendingValues();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _startSendingValues() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (close) {
        timer.cancel(); // Stoppt den Timer
        _streamController.close(); // Schließt den StreamController
        return;
      }
      minutes++;

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
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        close = true;
                      });
                    },
                    child: Text('Stop')),
                CircularTimer(
                  von: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour,
                      DateTime.now().minute),
                  bis: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour,
                      DateTime.now().minute+minutes),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

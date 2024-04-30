import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Stream Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stream<DateTime> _dateTimeStream;
  late StreamController<DateTime> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<DateTime>();
    _dateTimeStream = _streamController.stream;

    // Start emitting current date every second
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      _streamController.add(DateTime.now());
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Stream Example'),
      ),
      body: Center(
        child: StreamBuilder<DateTime>(
          stream: _dateTimeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${snapshot.data}',
                style: TextStyle(fontSize: 24.0),
              );
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}

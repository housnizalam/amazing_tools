import 'dart:async';

import 'package:amazing_tools/tools/animated_circular_timer.dart';
import 'package:flutter/material.dart';

class AttemdanceIndicator extends StatefulWidget {
  final DateTime? von;
  final DateTime? bis;

  const AttemdanceIndicator({super.key, this.von, this.bis});
  @override
  _AttemdanceIndicatorState createState() => _AttemdanceIndicatorState();
}

class _AttemdanceIndicatorState extends State<AttemdanceIndicator> {
  late int durationCounter;
  late DateTime von;
  late DateTime bis;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    von = widget.von ?? DateTime(now.year, now.month, now.day, now.hour, now.minute);
    bis = widget.bis ?? DateTime(now.year, now.month, now.day, now.hour, now.minute);
    durationCounter = (now.millisecondsSinceEpoch - von.millisecondsSinceEpoch) ~/ 60000;
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        durationCounter++;
      });
    });
  }

  @override
  void didUpdateWidget(AttemdanceIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.von != widget.von || oldWidget.bis != widget.bis) {
      bis = widget.bis ?? DateTime.now();
      von = widget.von ?? DateTime.now();
      durationCounter = (DateTime.now().millisecondsSinceEpoch - von.millisecondsSinceEpoch) ~/ 60000;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.von == null || widget.bis != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Time Streamer'),
        ),
        body: Center(
          child: AnimatedCircularTimer(
            backgroundColor: Colors.transparent,
            von: von,
            bis: bis.subtract(Duration(minutes: 30)),
          ),
        ),
      );
    } else {
      // Only update von attribute, not the entire widget
      // von = widget.von ?? DateTime.now();
      return Scaffold(
        appBar: AppBar(
          title: Text('Time Streamer'),
        ),
        body: Center(
          child: AnimatedCircularTimer(
            duration: Duration.zero,
            von: von,
            bis: von.add(Duration(minutes: durationCounter)),
          ),
        ),
      );
    }
  }
}

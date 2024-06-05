import 'package:flutter/material.dart';

class HiddenView extends StatefulWidget {
  final double height;
  const HiddenView({
    super.key,
    this.height = 0,
  });

  @override
  State<HiddenView> createState() => _HiddenViewState();
}

class _HiddenViewState extends State<HiddenView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.height,
      duration: Duration(milliseconds: 500),
      child: Text('Hidden widget'),
    );
  }
}

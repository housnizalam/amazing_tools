import 'package:flutter/material.dart';

class AnimationRepete extends StatefulWidget {
  const AnimationRepete({super.key});

  @override
  State<AnimationRepete> createState() => _AnimationRepeteState();
}

class _AnimationRepeteState extends State<AnimationRepete> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
  
    )..addListener(
        () {
          setState(() {});
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.red,
              height: 100 + _controller.value * 100,
              width: 200,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                _controller.repeat(reverse:true );
              },
              child: Text('Press'))
        ],
      ),
    );
  }
}

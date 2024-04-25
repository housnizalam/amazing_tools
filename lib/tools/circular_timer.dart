// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class CircullarTimer extends StatefulWidget {
//   final double radius;
//   final double? height;
//   final double? width;
//   final Color backgroundColr;
//   const CircullarTimer({super.key, required this.radius, this.height, this.width, this.backgroundColr = Colors.black});

//   @override
//   State<CircullarTimer> createState() => _CircullarTimerState();
// }

// class _CircullarTimerState extends State<CircullarTimer> {
//   @override
//   Widget build(BuildContext context) {
//     double height = widget.height ?? MediaQuery.of(context).size.height;
//     double width = widget.width ?? MediaQuery.of(context).size.width;
//     return ColoredBox(
//       color: Colors.black,
//       child: SizedBox(
//         height: height,
//         width: width,
//         child: Stack(
//           children: [
//             Positioned(
//               left: (width - 2 * widget.radius) / 2,
//               top: (height - 2 * widget.radius) / 2,
//               child: CircularPercentIndicator(
//                 radius: widget.radius,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

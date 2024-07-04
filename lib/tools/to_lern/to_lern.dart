import 'package:flutter/material.dart';

class AmazingShape extends StatefulWidget {
  const AmazingShape({super.key});

  @override
  State<AmazingShape> createState() => _AmazingShapeState();
}

class _AmazingShapeState extends State<AmazingShape> {
  double buttonPressCount = 2;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final double pointCount = buttonPressCount;

    return Scaffold(
      // An AnimatedContainer makes the decoration changes entertaining.
      body: Center(
        child: AnimatedContainer(
          height: 500,
          width: 500,
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            gradient: RadialGradient(
              colors: [const Color.fromARGB(255, 5, 29, 65), Colors.blue, Colors.blue, Colors.white],
            ),
            shape:
                // StarBorder.polygon(
                //   side: BorderSide(width: 10),
                //   sides: pointCount,
                //   pointRounding: 0.5,
                // ),
                StarBorder(
              points: pointCount,
              innerRadiusRatio: 0.2,
              pointRounding: 0.3,
              valleyRounding: 0.5,
              rotation: 0,
              squash: 0,
              side: BorderSide(width: 9, color: colorScheme.tertiary),
            ),
          ),
          child: Text(
            '${pointCount.toInt()} Points',
            style: theme.textTheme.headlineMedium!.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                buttonPressCount += 1;
              });
            },
            tooltip: "Change the shape's point count",
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (buttonPressCount > 2) buttonPressCount -= 1;
              });
            },
            tooltip: "Change the shape's point count",
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

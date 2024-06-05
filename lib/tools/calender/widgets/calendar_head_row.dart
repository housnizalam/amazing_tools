import 'package:flutter/material.dart';

class CalenderHeaderView extends StatelessWidget {
  final String dateName;
  const CalenderHeaderView({required this.dateName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 2, right: 1, bottom: 1, left: 1),
      decoration: BoxDecoration(
        color: Colors.blueGrey[300],
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        dateName,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class CalenderHeadRow extends StatelessWidget {
  const CalenderHeadRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          for (var i = 0; i <= weekDayShort.length; i++)
            if (i == 0)
              const Expanded(flex: 1, child: CalenderHeaderView(dateName: 'KW'))
            else
              Expanded(flex: 2, child: CalenderHeaderView(dateName: weekDayShort[i].toString())),
        ],
      ),
    );
  }
}

Map<int, String> get weekDayShort => {
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun',
    };

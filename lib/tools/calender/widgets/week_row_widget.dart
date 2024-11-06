import 'package:amazing_tools/tools/calender/models/calender_weak.dart';
import 'package:amazing_tools/tools/calender/widgets/day_widget.dart';
import 'package:flutter/material.dart';

class WeekRowWidget extends StatelessWidget {
  final CalendarWeek week;
  final DateTime selectedMonth;
  const WeekRowWidget({required this.week, super.key, required this.selectedMonth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: WeekNrView(
            kwNumber: week.weekNumber,
          ),
        ),
        for (var day in week.weekDays)
          Expanded(
            flex: 2,
            child: DayViewWidget(
              selectedMonth: selectedMonth,
              day,
            ),
          ),
      ],
    );
  }
}

class WeekNrView extends StatelessWidget {
  final int kwNumber;

  const WeekNrView({super.key, required this.kwNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueGrey[500],
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        kwNumber.toString(),
        // calenderContent.weeks[weekIndex],
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );
  }
}


import 'package:amazing_tools/tools/calender/widgets/calendar.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  final DateTime selectedMonth;
  const CalendarView({required this.selectedMonth, super.key});
  @override
  Widget build(BuildContext context) {
    List<DateTime> Monthes = [
      selectedMonth,
      DateTime(
        selectedMonth.year,
        selectedMonth.month + 1,
        1,
      ),
      DateTime(
        selectedMonth.year,
        selectedMonth.month + 2,
        1,
      ),
      DateTime(
        selectedMonth.year,
        selectedMonth.month + 3,
        1,
      ),
    ];
    return Container(
      height: 500,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [for (final month in Monthes) Calendar(selectedMonth: month)],
        ),
      ),
    );
  }
}

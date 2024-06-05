import 'package:amazing_tools/tools/calender/models/calender_month.dart';
import 'package:amazing_tools/tools/calender/models/calender_weak.dart';
import 'package:amazing_tools/tools/calender/widgets/calendar_head_row.dart';
import 'package:amazing_tools/tools/calender/widgets/week_row_widget.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  final CalendarMonth calendarContent;
  const Calendar({super.key, required this.calendarContent, required this.selectedMonth});
  final DateTime selectedMonth;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: [
          const Expanded(flex: 1, child: CalenderHeadRow()),
          for (CalendarWeek week in calendarContent.weeks)
            week.weekDays.first.inSelectedMonth
                ? Expanded(
                    flex: 1,
                    child: WeekRowWidget(
                      selectedMonth: selectedMonth,
                      week: week,
                    ),
                  )
                : week.weekDays.last.inSelectedMonth
                    ? Expanded(
                        flex: 1,
                        child: WeekRowWidget(
                          selectedMonth: selectedMonth,
                          week: week,
                        ),
                      )
                    : const SizedBox(),
        ],
      ),
    );
  }
}

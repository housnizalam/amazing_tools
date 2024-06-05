import 'package:amazing_tools/tools/calender/models/calender_month.dart';
import 'package:amazing_tools/tools/calender/models/calender_weak.dart';
import 'package:amazing_tools/tools/calender/widgets/calendar_head_row.dart';
import 'package:amazing_tools/tools/calender/widgets/week_row_widget.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedMonth;
  const Calendar({
    super.key,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    CalendarMonth calenderContent1 = CalendarMonth.fromDateTime(selectedMonth);
    CalendarMonth calenderContent2 = CalendarMonth.fromDateTime(DateTime(2024, 7, 1));

    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: [
          for (CalendarWeek week in calenderContent1.weeks)
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
          Divider()
        ],
      ),
    );
  }
}

import 'package:amazing_tools/tools/calender/models/calendar_state_classe.dart';
import 'package:amazing_tools/tools/calender/models/caender_day.dart';
import 'package:amazing_tools/tools/calender/month_view.dart';
import 'package:flutter/material.dart';

class DayViewWidget extends StatefulWidget {
  final CalendarDay day;
  final bool inThisMonth;
  final DateTime selectedMonth;
  DayViewWidget(
    this.day, {
    required this.selectedMonth,
    super.key,
  }) : inThisMonth = day.inSelectedMonth;
  @override
  State<DayViewWidget> createState() => _DayViewWidgetState();
}

class _DayViewWidgetState extends State<DayViewWidget> {
  bool firstBuild = true;
  bool isHolyday = false;
  @override
  Widget build(BuildContext context) {
    var calendarState = CalendarState.getInstance();
    return InkWell(
      onDoubleTap: () {},
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: _shadows(widget.day),
          color: _getDayColor(widget.day, isHolyday),
          border: Border.all(
              color: widget.day.inSelectedMonth && widget.day.dayNumber == calendarState.selectedMonth?.day
                  ? Colors.blue
                  : Colors.black,
              width: widget.day.inSelectedMonth && widget.day.dayNumber == calendarState.selectedMonth?.day ? 3 : 1),
          borderRadius: BorderRadius.circular(3),
        ),
        child: SizedBox(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded(
                      //   child: calendarState.selectedMonth?.day == widget.day.dayNumber && widget.day.inSelectedMonth
                      //       ? Shimmer.fromColors(
                      //           period: const Duration(seconds: 6),
                      //           baseColor: Colors.blue,
                      //           highlightColor: Colors.white,
                      //           child: Text(
                      //             widget.day.dayNumber.toString(),
                      //             style: const TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.w900,
                      //             ),
                      //             textAlign: TextAlign.end,
                      //           ),
                      //         )
                      //       : Text(
                      //           widget.day.dayNumber.toString(),
                      //           style: const TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w900,
                      //           ),
                      //           textAlign: TextAlign.end,
                      //         ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color? _getDayColor(
  CalendarDay calendarDay,
  bool isHolyday,
) {
  final calendarState = CalendarState.getInstance();
  if (calendarDay.dayNumber == DateTime.now().day &&
      calendarState.selectedMonth?.month == DateTime.now().month &&
      calendarState.selectedMonth?.year == DateTime.now().year &&
      calendarDay.inSelectedMonth) {
    return Colors.blue[300]; //Today
  }
  if (isHolyday) {
    return const Color.fromARGB(255, 231, 190, 214); //When its an Holiday
  }
  if (!calendarDay.inSelectedMonth) {
    return Colors.grey[400]; //Is not in the selected Month
  }
  // : day.appointments.isEmpty
  //     ? Colors.green[100]
  return const Color.fromARGB(255, 238, 238, 238); //Default day color
}

List<BoxShadow> _shadows(CalendarDay day) {
  final calendarState = CalendarState.getInstance();
  double shadow = 6;
  BoxShadow shadow1 = BoxShadow(
    color: Colors.white, // Farbe des Schattens
    offset: calendarState.selectedMonth?.day == day.dayNumber || !day.inSelectedMonth
        ? const Offset(0, 0)
        : Offset(shadow, shadow), // Versatz des Schattens nach links oben
    blurRadius: shadow, // Unschärferadius
  );
  BoxShadow shadow2 = BoxShadow(
    color: Colors.black, // Farbe des Schattens
    offset: calendarState.selectedMonth?.day == day.dayNumber || !day.inSelectedMonth
        ? const Offset(0, 0)
        : Offset(shadow, shadow), // Versatz des Schattens nach rechts unten
    blurRadius: shadow, // Unschärferadius
  );
  return [shadow1, shadow2];
}

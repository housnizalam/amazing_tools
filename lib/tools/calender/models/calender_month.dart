import 'package:amazing_tools/tools/calender/models/caender_day.dart';
import 'package:amazing_tools/tools/calender/models/calender_weak.dart';

class CalendarMonth {
  final String monthName;
  final int month;
  final int year;
  final List<CalendarWeek> weeks;

  CalendarMonth._internal({required this.monthName, required this.month, required this.year, List<CalendarWeek>? days})
      : weeks = days ?? <CalendarWeek>[];

  ///  Gibt eine Liste Aller Tage des Monats aus
  List<CalendarDay> get monthDays {
    final List<CalendarDay> days = [];
    for (final week in weeks) {
      days.addAll(week.weekDays);
    }
    return days;
  }

  int get realWeaks {
    int result = 6;
    for (CalendarWeek thisWeek in weeks) {
      bool fakeWeek = true;
      for (CalendarDay day in thisWeek.weekDays) {
        if (day.inSelectedMonth) {
          fakeWeek = false;
        }
      }
      if (fakeWeek) {
        result--;
      }
    }
    return result;
  }

  factory CalendarMonth.fromDateTime(DateTime selectedDate) {
    CalendarMonth calendarMonth =
        CalendarMonth._internal(monthName: '', month: selectedDate.month, year: selectedDate.year);
    //Erster Tag des Monats
    final thisMonthFirstDay = DateTime(selectedDate.year, selectedDate.month, 1);

    var currentWeek = thisMonthFirstDay;
    //Füge 5 Wochen hinzu die in diesen Monat sind.
    for (var i = 0; i < 6; i++) {
      calendarMonth.weeks.add(CalendarWeek.fromDateTime(dayOfWeek: currentWeek, thisMonth: selectedDate.month));
      currentWeek = currentWeek.add(const Duration(days: 7));
    }
    return calendarMonth;
  }
}

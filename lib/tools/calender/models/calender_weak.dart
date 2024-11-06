import 'package:amazing_tools/tools/calender/models/caender_day.dart';

class CalendarWeek {
  int _weekNumber;
  List<CalendarDay> _weekDays;

  CalendarWeek._internal({required int weekNumber, List<CalendarDay>? days})
      : _weekNumber = weekNumber,
        _weekDays = days ?? [];

  int get weekNumber => _weekNumber;
  List<CalendarDay> get weekDays => _weekDays;

  bool addDay(CalendarDay day) {
    if (_weekDays.length >= 7) return false;
    _weekDays.add(day);
    return true;
  }

  factory CalendarWeek.fromDateTime({required DateTime dayOfWeek, required int thisMonth}) {
    var currentDay = dayOfWeek;
    final newWeek = CalendarWeek._internal(weekNumber: _weekNumberOfDate(dayOfWeek));

    //Wir suchen den vorrigen Montag wenn uns kein Montag gegeben wurde.
    while (currentDay.weekday != 1) {
      currentDay = currentDay.subtract(const Duration(days: 1));
    }
    // Fügen alle Tage bis zum nächsten Sonntag hinzu
    while (currentDay.weekday != 7) {
      final newDay = CalendarDay(
        dayNumber: currentDay.day,
        inSelectedMonth: currentDay.month == thisMonth,
      );
      newWeek.addDay(newDay);
      currentDay = currentDay.add(const Duration(days: 1));
    }
    // // Die hintergrund Farben von heute und gewählter Tag für den letzten Tag der Woche fügen
    final newDay = CalendarDay(
      dayNumber: currentDay.day,
      inSelectedMonth: currentDay.month == thisMonth,
    );
    newWeek.addDay(newDay);
    return newWeek;
  }

  //Berechne die Wochennummer des gegebenen Tages
  static int _weekNumberOfDate(DateTime date) {
    date = DateTime.utc(date.year, date.month, date.day);
    //Wir brauchen die Anzahl der tage seit dem ersten Montag des Jahres
    var daysThisYear = _numberDaysSinceFirstMondayOfYear(date, date.year);
    //Wenn eine negative Zahl kommt wissen wir, dass der genannte tag VOR dem ersten Montag ist
    if (daysThisYear < 0) {
      //Dann brauchen wir die Anzahl der Tage bis zum ersten Montag des Vorjahres
      daysThisYear = _numberDaysSinceFirstMondayOfYear(date, date.year - 1);
    }
    var kw = (daysThisYear / 7).floor() + 1;
    return kw;
  }

  static int _numberDaysSinceFirstMondayOfYear(DateTime date, int year) {
    DateTime firstDay = DateTime(year, 1, 1);
    int days = date.difference(firstDay).inDays;
    if (firstDay.weekday != 1) {
      days = days + firstDay.weekday - 8;
    }
    return days;
  }
}

class CalendarState {
  DateTime? selectedMonth;

  // Private statische Instanzvariable
  static CalendarState? _instance;

  // Privater Konstruktor
  CalendarState._({
    this.selectedMonth,
  });

  // Statische Methode zur Instanzerstellung
  factory CalendarState.getInstance({
    DateTime? selectedMonth,
  }) {
    // Wenn keine Instanz vorhanden ist, wird eine neue erstellt
    _instance ??= CalendarState._(
      selectedMonth: selectedMonth,
    );
    print(_instance!.selectedMonth?.day);
    // Die vorhandene Instanz wird zurückgegeben
    return _instance!;
  }

  // Gibt das ausgewählte Datum als formatierter String zurück
  String get stringSelectedMonth {
    if (this.selectedMonth == null) return '';
    String year = selectedMonth!.year.toString();
    String month = selectedMonth!.month < 10 ? '0${selectedMonth!.month}' : selectedMonth!.month.toString();
    String day = selectedMonth!.day < 10 ? '0${selectedMonth!.day}' : selectedMonth!.day.toString();
    return '$day-$month-$year';
  }

  // Setzt das ausgewählte Datum auf null
  void setNull() {
    this.selectedMonth = null;
  }

  // Setzt ein neues ausgewähltes Datum
  void setNewDate(DateTime selectedMonth) {
    this.selectedMonth = selectedMonth;
  }
}

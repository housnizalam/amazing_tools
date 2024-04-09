import 'package:flutter/material.dart';

@immutable
/// Represents a date in our application.
class Datum {
  final String _data;
  /// Creates a new instance of [Datum].
  const Datum._(this._data);
  /// Creates a new instance of [Datum].
  /// This constructor does not do any checking on the data in order to produce
  /// a const [Datum]. Use with caution. Prefer using [Datum.fromSaved] instead.
  const Datum.withoutChecks(this._data);
  /// The day of this [Datum].
  int get day => int.parse(_data.substring(6));
  /// The [Datum] of the first day of the month of this [Datum].
  Datum get firstOfMonth => fromDate(DateTime(toDate.year, toDate.month));
  @override
  int get hashCode => _data.hashCode;
  /// The [Datum] of the last day of the month of this [Datum].
  Datum get lastOfMonth {
    final firstOfNextMonth = DateTime(toDate.year, toDate.month + 1, 1);
    final lastOfThisMonth = firstOfNextMonth.subtract(const Duration(days: 1));
    final result = Datum.fromDate(lastOfThisMonth);
    return result;
  }
  /// The month of this [Datum].
  int get month => int.parse(_data.substring(4, 6));
  DateTime get toDate {
    final date = DateTime(
      int.parse(_data.substring(0, 4)),
      int.parse(_data.substring(4, 6)),
      int.parse(_data.substring(6)),
    );
    return date;
  }
  String get toFormatted => toFormat();
  String get toSaved => _data;
  int get year => int.parse(_data.substring(0, 4));
  String get monthName =>
      {
        1: 'Januar',
        2: 'Februar',
        3: 'März',
        4: 'April',
        5: 'Mai',
        6: 'Juni',
        7: 'Juli',
        8: 'August',
        9: 'September',
        10: 'Oktober',
        11: 'November',
        12: 'Dezember',
      }[month] ??
      '(unbekannt)';
  @override
  bool operator ==(Object other) {
    if (other is Datum) {
      return _data == other._data;
    }
    return false;
  }
  /// Returns the number of days that this [Datum] is after [Datum].
  /// If this [Datum] is before [Datum], a negative number is returned.
  int afterInDays(Datum other) {
    final thisDate = toDate;
    final otherDate = other.toDate;
    final difference = thisDate.difference(otherDate);
    final result = difference.inDays;
    return result;
  }
  /// Returns the number of days that this [Datum] is before [Datum].
  /// If this [Datum] is after [Datum], a negative number is returned.
  int beforeInDays(Datum other) {
    final afterInDays = this.afterInDays(other);
    return -afterInDays;
  }
  /// Compares this [Datum] to another [Datum].
  /// Returns a negative number if this [Datum] is before [other], 0 if they are equal, and a positive number if this [Datum] is after [other].
  int compareTo(Datum other) {
    final result = _data.compareTo(other._data);
    return result;
  }
  /// Checks if this [Datum] is after [other].
  bool isAfter(Datum other) {
    final result = _data.compareTo(other._data) > 0;
    return result;
  }
  /// Checks if this [Datum] is after or equal to [other].
  bool isAfterOrEqual(Datum other, {bool nullFirst = false}) {
    final result = _data.compareTo(other._data) >= 0;
    return result;
  }
  /// Checks if this [Datum] is before [other].
  bool isBefore(Datum other, {bool nullFirst = false}) {
    final result = _data.compareTo(other._data) < 0;
    return result;
  }
  /// Checks if this [Datum] is before or equal to [other].
  bool isBeforeOrEqual(Datum other, {bool nullFirst = false}) {

    final result = _data.compareTo(other._data) <= 0;
    return result;
  }
  /// Translates this [Datum] to a formatted string.
  ///
  /// The format is 'd.m.Y' by default.
  ///
  /// The following format characters are supported:
  /// d:	Day of the month, 2 digits with leading zeros	01 to 31.
  /// D:	A textual representation of a day, two letters.	Mo through So.
  /// j:	Day of the month without leading zeros.	1 to 31.
  /// l:	A full textual representation of the day of the week.	Montag through Samstag.
  /// S:	English ordinal suffix for the day of the month, 2 characters	st, nd, rd or th. Works well with j.
  /// W:	Week number of year, weeks starting on Monday.
  /// F:	A full textual representation of a month, such as Januar or Juli.
  /// m:	Numeric representation of a month, with leading zeros	01 through 12.
  /// M:	A short textual representation of a month, three letters.	Jan through Dez.
  /// n:	Numeric representation of a month, without leading zeros	1 through 12
  /// t:	Number of days in the given month	28 through 31
  /// Y:	A full numeric representation of a year, at least 4 digits, with - for years BCE.	Examples: -0055, 0787, 2024
  /// A: two digit representation of a year	Examples: 99 or 03
  String toFormat([String format = 'd.m.Y']) {

    var formatted = format;
    formatted = formatted.replaceAll('d', _data.substring(6));
    formatted = formatted.replaceAll('m', _data.substring(4, 6));
    formatted = formatted.replaceAll('Y', _data.substring(0, 4));
    formatted = formatted.replaceAll(
      'l',
      switch (toDate.weekday) {
        1 => 'Montag',
        2 => 'Dienstag',
        3 => 'Mittwoch',
        4 => 'Donnerstag',
        5 => 'Freitag',
        6 => 'Samstag',
        _ => 'Sonntag',
      },
    );
    // TODO: Implement the other format characters.
    return formatted;
  }
  @override
  String toString() => _data;
  /// Creates a new [Datum] from a [DateTime].
  static Datum fromDate(DateTime date) {

    final saved = '${date.year}${date.month < 10 ? '0' : ''}${date.month}${date.day < 10 ? '0' : ''}${date.day}';
    return Datum._(saved);
  }
  /// Creates a new [Datum] from a formatted string.
  static Datum? fromFormatted(String formatted) {
    final regexFormatted = RegExp(r'^[0123]\d.[01]\d.\d\d\d\d$');
    if (!regexFormatted.hasMatch(formatted)) {
      return null;
    }
    final date = DateTime(
      int.parse(formatted.substring(6)),
      int.parse(formatted.substring(3, 5)),
      int.parse(formatted.substring(0, 2)),
    );
    return fromDate(date);
  }
  /// Creates a new [Datum] from a saved value (String).
  static Datum fromSaved(String data) {
    assert(data.length == 8, 'Datum must have 8 characters.');
    assert(RegExp(r'^\d\d\d\d[01]\d[0123]\d$').hasMatch(data), 'Datum must match the pattern "YYYYMMDD".');
    final date = DateTime(
      int.parse(data.substring(0, 4)),
      int.parse(data.substring(4, 6)),
      int.parse(data.substring(6)),
    );
    return fromDate(date);
  }
  /// Creates the current [Datum].
  static Datum today() => Datum.fromDate(DateTime.now());
}
/// Converts a [Datum] to and from a json value.
// class DatumConverter implements JsonConverter<Datum, String> {
//   /// Converts a [Datum] to and from a json value.
//   const DatumConverter();
//   @override
//   Datum fromJson(String string) {
//     return Datum.fromSaved(string);
//   }
//   @override
//   String toJson(Datum datum) => datum.toSaved;
// }
// class DatumConverterNullable implements JsonConverter<Datum?, String?> {
//   /// Converts a [Datum] or null to and from a json value (including null).
//   const DatumConverterNullable();
//   @override
//   Datum? fromJson(String? string) {
//     return string == null ? null : Datum.fromSaved(string);
//   }
//   @override
//   String? toJson(Datum? datum) => datum?.toSaved;
// }
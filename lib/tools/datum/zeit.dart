import 'package:flutter/material.dart';

@immutable
/// Represents a time in our application.
class Zeit {
  final int _data;
  /// Creates a new instance of [Zeit].
  /// This constructor does not do any checking on the data in order to produce
  /// a const [Zeit]. Use with caution. Prefer using [Zeit.fromSaved] instead.
  const Zeit.withoutChecks(this._data);
  // Should only be called from Zeit.fromSaved!
  const Zeit._(this._data);
  /// Returns true if this [Zeit] is negative.
  bool get isNegative => _data < 0;
  /// Returns a '-' if this [Zeit] is negative, otherwise an empty string.
  String get sign => _data < 0 ? '-' : '';
  /// Translates this [Zeit] to a standard formatted string.
  String? get toFormatted => toFormat();
  /// The save value of this [Zeit].
  int get toSaved => _data;
  /// Translates this [Zeit] to a [TimeOfDay].
  TimeOfDay? get toTime {

    final absData = _data.abs();
    final time = TimeOfDay(hour: absData ~/ 60, minute: absData % 60);
    return time;
  }
  Zeit operator +(Zeit other) => Zeit.fromSaved(_data + other._data);
  Zeit operator -(Zeit other) => Zeit.fromSaved(_data - other._data);
  /// Calculates the difference in minutes between this [Zeit] and another [Zeit].
  /// If this [Zeit] is before [other], a negative number is returned.
  int? afterInMinutes(Zeit other) {
    final result = _data - other._data;
    return result;
  }
  /// Calculates the difference in minutes between this [Zeit] and another [Zeit].
  /// If this [Zeit] is after [other], a negative number is returned.
  int? beforeInMinutes(Zeit other) {

    final result = other._data - _data;
    return result;
  }
  /// Comapres this [Zeit] to another [Zeit].
  /// Returns a negative number if this [Zeit] is before [other],
  /// 0 if they are equal, and a positive number if this [Zeit]
  /// is after [other].
  int compareTo(Zeit other, {bool nullFirst = false}) {

    final result = _data.compareTo(other._data);
    return result;
  }
  /// Checks if this [Zeit] is after [other].
  bool isAfter(Zeit other, {bool nullFirst = false}) {

    final result = _data.compareTo(other._data) > 0;
    return result;
  }
  /// Checks if this [Zeit] is after or equal to [other].
  bool isAfterOrEqual(Zeit other, {bool nullFirst = false}) {

    final result = _data.compareTo(other._data) >= 0;
    return result;
  }
  /// Checks if this [Zeit] is before [other].
  bool isBefore(Zeit other) {

    final result = _data.compareTo(other._data) < 0;
    return result;
  }
  /// Checks if this [Zeit] is before or equal to [other].
  bool isBeforeOrEqual(Zeit other) {

    final result = _data.compareTo(other._data) <= 0;
    return result;
  }
  /// Translates this [Zeit] to a formatted string.
  ///
  /// The format is 'H:i' by default.
  ///
  /// The following format characters are supported:
  /// a:	Lowercase Ante meridiem and Post meridiem	am or pm
  /// A:	Uppercase Ante meridiem and Post meridiem	AM or PM
  /// g:	12-hour format of an hour without leading zeros.	1 through 12
  /// G:	24-hour format of an hour without leading zeros.	0 through 23.
  /// h:	12-hour format of an hour with leading zeros.	01 through 12
  /// H:	24-hour format of an hour with leading zeros.	00 through 23
  /// i:	Minutes with leading zeros	00 to 59
  String? toFormat([String format = 'H:i']) {

    final sign = _data < 0 ? '-' : '';
    final timeUnsigned = _data.abs();
    final hours = timeUnsigned ~/ 60;
    final minutes = timeUnsigned % 60;
    var result = format;
    result = result.replaceAll('a', hours < 12 ? 'am' : 'pm');
    result = result.replaceAll('A', hours < 12 ? 'AM' : 'PM');
    result = result.replaceAll('g', (hours % 12).toString());
    result = result.replaceAll('G', hours.toString().padLeft(2, '0'));
    result = result.replaceAll('h', (hours % 12).toString().padLeft(2, '0'));
    result = result.replaceAll('H', hours.toString().padLeft(2, '0'));
    result = result.replaceAll('i', minutes.toString().padLeft(2, '0'));
    result = '$sign$result';
    return result;
  }
  /// Creates a new [Zeit] from a formatted string.
  static Zeit? fromFormatted(String? formatted) {
    final regexFormatted = RegExp(r'^[-]?\d*[:.]?\d\d$');
    if (formatted == null) {
      return null;
    }
    if (!regexFormatted.hasMatch(formatted)) {
      return null;
    }
    var replaced = formatted.replaceAll('.', ':');
    var minus = false;
    if (replaced.startsWith('-')) {
      minus = true;
      replaced = replaced.substring(1);
    }
    if (!replaced.contains(':')) {
      if (replaced.length < 2) {
        replaced = '0:$replaced';
      } else {
        replaced = '${replaced.substring(0, replaced.length - 2)}:${replaced.substring(replaced.length - 2)}';
      }
    }
    final parts = replaced.split(':');
    final result = (minus ? -1 : 1) * (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
    return fromSaved(result);
  }
  /// Creates a new [Zeit] from a saved value.
  // ignore: prefer_constructors_over_static_methods
  static Zeit fromSaved(int data) => Zeit._(data);
  /// Creates a new [Zeit] from a [TimeOfDay].
  static Zeit fromTime(TimeOfDay time) {
    final saved = time.hour * 60 + time.minute;
    return fromSaved(saved);
  }
}
/// Converts a [Zeit] to and from a saved value.
// class ZeitConverter implements JsonConverter<Zeit, int> {
//   /// Converts a [Zeit] to and from a saved value.
//   const ZeitConverter();
//   @override
//   Zeit fromJson(int value) {
//     return Zeit.fromSaved(value);
//   }
//   @override
//   int toJson(Zeit zeit) => zeit.toSaved;
// }
// /// Converts a [Zeit] (or null) to and from a json value.
// class ZeitConverterNullable implements JsonConverter<Zeit?, int?> {
//   /// Converts a [Zeit] (or null) to and from a json value.
//   const ZeitConverterNullable();
//   @override
//   Zeit? fromJson(int? value) {
//     return value == null ? null : Zeit.fromSaved(value);
//   }
//   @override
//   int? toJson(Zeit? zeit) => zeit?.toSaved;
// }
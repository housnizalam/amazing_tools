import 'package:amazing_tools/tools/datum/datum.dart';
import 'package:flutter/material.dart';

@immutable
class DateRange {
  final Datum von;
  final Datum bis;
  const DateRange._({required this.von, required this.bis});
  DateRange.fromDatum({
    required this.von,
    required this.bis,
  });
  int get distance => bis.afterInDays(von);
  @override
  int get hashCode => von.hashCode ^ bis.hashCode;
  int get length => distance + 1;
  @override
  bool operator ==(Object other) {
    if (other is DateRange) {
      return von == other.von && bis == other.bis;
    }
    return false;
  }
  bool collidesWith(DateRange other) {
    if (bis.isBefore(other.von)) return false;
    if (von.isAfter(other.bis)) return false;
    return true;
  }
  // Feststellung ob diese Zeitraum außer der gegebenen Date-Range Liste
  bool collidesWithOneOf(List<DateRange> dateRanges) {
    for (final range in dateRanges) {
      if (range.collidesWith(this)) {
        return true;
      }
    }
    return false;
  }
  // Feststellung ob diese Zeitraum außer der gegebenen Date-Range Liste
  DateRange? getBlockingRangeOf(List<DateRange> ranges) {
    for (final range in ranges) {
      if (range.collidesWith(this)) {
        return range;
      }
    }
    return null;
  }
  bool isAfter(DateRange other) => von.isAfter(other.bis);
  bool isAfterOrEqual(DateRange other) => von.isAfterOrEqual(other.bis);
  bool isBefore(DateRange other) => bis.isBefore(other.von);
  bool isBeforeOrEqual(DateRange other) => bis.isBeforeOrEqual(other.von);
  static DateRange? fromDate({
    required DateTime von,
    required DateTime bis,
  }) =>
      wouldBeValid(von: Datum.fromDate(von), bis: Datum.fromDate(bis))
          ? DateRange._(von: Datum.fromDate(von), bis: Datum.fromDate(bis))
          : null;
  static DateRange? fromFormatted({
    required String von,
    required String bis,
  }) {
    final savedVon = Datum.fromFormatted(von);
    final savedBis = Datum.fromFormatted(bis);
    if (savedVon == null || savedBis == null) {
      return null;
    }
    if (!wouldBeValid(von: savedVon, bis: savedBis)) {
      return null;
    }
    return DateRange._(von: savedVon, bis: savedBis);
  }
  String toString() => '$von - $bis';
  // Checks a list of [DateRange]s for collisions with each other
  static bool isListOfDateRangeWithoutCollisions(List<DateRange> dateRanges) {
    for (var i = 0; i < dateRanges.length - 1; i++) {
      for (var j = i + 1; j < dateRanges.length; j++) {
        if (dateRanges[i].collidesWith(dateRanges[j])) {
          return true;
        }
      }
    }
    return false;
  }
  static bool wouldBeValid({
    required Datum von,
    required Datum bis,
  }) =>
      von.isBeforeOrEqual(bis);
}
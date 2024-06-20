import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Seconds since epoch
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;

  static DateTime fromSecondsSinceEpoch(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  /// Returns short date string in format 'dd.MM HH:mm'
  String get shortDateTimeString {
    return DateFormat('dd.MM HH:mm').format(this);
  }

  /// Returns short date string in format 'HH:mm\n dd.MM'
  String get shortDateTimeStringTwoLines {
    return '${DateFormat('HH:mm').format(this)}\n'
        '${DateFormat('dd.MM').format(this)}';
  }

  /// Returns short time string in format 'HH:mm'
  String get shortTimeString {
    return DateFormat('HH:mm').format(this);
  }

  /// Returns short date string in format 'dd.MM'
  String get shortDateString {
    return DateFormat('dd.MM').format(this);
  }

  /// Returns date in format 'yyyy-MM-dd'
  String get dateInIso8601 {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Returns true if this date is the same day as [other]
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime get startOfDay => DateTime(year, month, day);

  bool get isToday => isSameDay(DateTime.now());
}

import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime unixToDateTime(num unix) {
    return DateTime.fromMillisecondsSinceEpoch(unix * 1000);
  }

  static String formatUnixToTimeOfDay(num unix) {
    var date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return DateFormat('h:mm a').format(date);
  }

  static String formatUnixToDay(num unix) {
    var date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return DateFormat('MMM d (E)').format(date);
  }
}
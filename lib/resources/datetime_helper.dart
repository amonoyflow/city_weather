import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime unixToDateTime(int unix) {
    return DateTime.fromMillisecondsSinceEpoch(unix * 1000);
  }

  static String formatUnixToTimeOfDay(int unix) {
    var date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return DateFormat('h:mm a').format(date);
  }

  static String formatUnixToDay(int unix) {
    var date = DateTime.fromMillisecondsSinceEpoch(unix * 1000);
    return DateFormat('MMM d (E)').format(date);
  }
}
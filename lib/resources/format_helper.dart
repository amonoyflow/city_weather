class FormatHelper {
  static String formatWindSpeed(double windSpeed, bool isMetric) {
    if (isMetric) {
      return "$windSpeed km/h";
    }
    else {
      var speed = windSpeed * 0.62137;
      return "$speed mi/h";
    }
  }
}
class FormatHelper {
  static String formatWindSpeed(num windSpeed, bool isImperial) {
    return isImperial ? "${(windSpeed * 0.62137).floor()} mi/h" : "${windSpeed.floor()} km/h";
  }

  static num formatTemperature(num temperature, bool isImperial) {
    var temp = isImperial ? (temperature * 1.8) + 32 : temperature;
    return temp.floor();
  }
}
import 'package:city_weather/models/current_weather.dart';

import 'current_weather_provider.dart';

class CurrentWeatherRepository {
  final currentWeatherProvider = CurrentWeatherApiProvider();

  Future<CurrentWeather> getCurrentWeather(double latitude, double longitude) {
    return currentWeatherProvider.getCurrentWeather(latitude, longitude);
  }
}
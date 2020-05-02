import 'package:city_weather/services/weather_service.dart';
import 'package:flutter/material.dart';

abstract class BlocBase {
  @protected
  final weatherService = WeatherService();
  void dispose() {}
}
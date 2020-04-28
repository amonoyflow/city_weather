import 'package:city_weather/services/repository.dart';
import 'package:flutter/material.dart';

abstract class BlocBase {
  @protected
  final repository = CurrentWeatherRepository();
  void dispose() {}
}
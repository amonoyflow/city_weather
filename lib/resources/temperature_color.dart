import 'package:city_weather/constant/weather_pallete.dart';
import 'package:flutter/material.dart';

class TemperatureColor {
  static Color getTemperatureColor(num temperature) {
    if (temperature >= 38) {
      return WeatherPallete.weatherRed;
    }
    else if (temperature >= 32 && temperature < 38) {
      return WeatherPallete.weatherDarkOrange;
    }
    else if (temperature >= 25 && temperature < 32) {
      return WeatherPallete.weatherOrange;
    }
    else if (temperature >= 15 && temperature < 25) {
      return WeatherPallete.weatherYellow;
    }
    else if (temperature >= 10 && temperature < 15) {
      return WeatherPallete.weatherGreen;
    }
    else if (temperature >= 0 && temperature < 10) {
      return WeatherPallete.weatherLightBlue;
    }
    else if (temperature >= -10 && temperature < 0) {
      return WeatherPallete.weatherBlue;
    }

    return WeatherPallete.weatherPurple;
  }
}
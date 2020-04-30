import 'package:city_weather/constant/weather-color-pallete.dart';
import 'package:flutter/material.dart';

class TemperatureColor {
  static Color getTemperatureColor(num temperature) {
    if (temperature >= 38) {
      return WeatherColorPallete.weatherRed;
    }
    else if (temperature >= 32 && temperature < 38) {
      return WeatherColorPallete.weatherDarkOrange;
    }
    else if (temperature >= 25 && temperature < 32) {
      return WeatherColorPallete.weatherOrange;
    }
    else if (temperature >= 15 && temperature < 25) {
      return WeatherColorPallete.weatherYellow;
    }
    else if (temperature >= 10 && temperature < 15) {
      return WeatherColorPallete.weatherGreen;
    }
    else if (temperature >= 0 && temperature < 10) {
      return WeatherColorPallete.weatherLightBlue;
    }
    else if (temperature >= -10 && temperature < 0) {
      return WeatherColorPallete.weatherBlue;
    }

    return WeatherColorPallete.weatherPurple;
  }
}
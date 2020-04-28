import 'package:city_weather/models/temp.dart';
import 'package:city_weather/models/weather.dart';
import 'package:city_weather/resources/datetime_helper.dart';

import 'feels_like.dart';

class Daily {
  num dt;
  num sunrise;
  num sunset;
  Temp temp;
  FeelsLike feelsLike;
  num pressure;
  num humidity;
  num dewPoint;
  num windSpeed;
  num windDeg;
  List<Weather> weather;
  num clouds;
  num uvi;
  DateTime today;
  DateTime weekly;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.clouds,
    this.uvi
  });

  Daily.fromJson(Map<String, dynamic> json) {
    this.dt = json["dt"];
    this.sunrise = json["sunrise"];
    this.sunset = json["sunset"];
    this.temp = Temp.fromJson(json["temp"]);
    this.feelsLike = FeelsLike.fromJson(json["feels_like"]);
    this.pressure = json["pressure"];
    this.humidity = json["humidity"];
    this.dewPoint = json["dew_point"];
    this.windSpeed = json["wind_speed"];
    this.windDeg = json["wind_deg"];
    this.weather = (json["weather"] as List).map((i) => Weather.fromJson(i)).toList();
    this.clouds = json["clouds"];
    this.uvi = json["uvi"];
    this.weekly = DateTimeHelper.unixToDateTime(this.dt);
    this.today = DateTimeHelper.unixToDateTime(this.dt);
  }

  Map<String, dynamic> toJson() => {
    "dt": this.dt,
    "sunrise": this.sunrise,
    "sunset": this.sunset,
    "temp": this.temp,
    "feels_like": this.feelsLike,
    "pressure": this.pressure,
    "humudity": this.humidity,
    "dew_point": this.dewPoint,
    "wind_speed": this.windSpeed,
    "wind_deg": this.windDeg,
    "weather": this.weather,
    "clouds": this.clouds,
    "uvi": this.uvi
  };
}
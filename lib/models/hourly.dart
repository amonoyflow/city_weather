import 'package:city_weather/models/weather.dart';
import 'package:city_weather/resources/datetime_helper.dart';

class Hourly {
  num dt;
  num temp;
  num feelsLike;
  num pressure;
  num humidity;
  num dewPoint;
  num clouds;
  num windSpeed;
  num windDeg;
  DateTime today;
  List<Weather> weather;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.clouds,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    this.dt = json['dt'];
    this.temp = json['temp'];
    this.feelsLike = json['feels_like'];
    this.pressure = json['pressure'];
    this.humidity = json['humidity'];
    this.dewPoint = json['dew_point'];
    this.clouds = json['clouds'];
    this.windSpeed = json['wind_speed'];
    this.windDeg = json['wind_deg'];
    this.weather = (json['weather'] as List).map((i) => Weather.fromJson(i)).toList();
    this.today = DateTimeHelper.unixToDateTime(this.dt);
  }

  Map<String, dynamic> toJson() => {
    "dt": this.dt,
    "temp": this.temp,
    "feels_like": this.feelsLike,
    "pressure": this.pressure,
    "humudity": this.humidity,
    "dew_point": this.dewPoint,
    "clouds": this.clouds,
    "wind_speed": this.windSpeed,
    "wind_deg": this.windDeg,
    "weather": this.weather
  };
}
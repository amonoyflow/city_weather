import 'package:city_weather/models/weather.dart';

class Current {
  num dt;
  num sunrise;
  num sunset;
  num temp;
  num feelsLike;
  num pressure;
  num humidity;
  num dewPoint;
  num uvi;
  num clouds;
  num visibility;
  num windSpeed;
  num windDeg;
  List<Weather> weather;

  Current({
    this.dt, 
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather
  });

  Current.fromJson(Map<String, dynamic> json) {
    this.dt = json['dt'];
    this.sunrise = json['sunrise'];
    this.sunset = json['sunset'];
    this.temp = json['temp'];
    this.feelsLike = json['feels_like'];
    this.pressure = json['pressure'];
    this.humidity = json['humidity'];
    this.dewPoint = json['dew_point'];
    this.uvi = json['uvi'];
    this.clouds = json['clouds'];
    this.visibility = json['visibility'];
    this.windSpeed = json['wind_speed'];
    this.windDeg = json['wind_deg'];
    this.weather = (json['weather'] as List).map((i) => Weather.fromJson(i)).toList();
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
    "uvi": this.uvi,
    "clouds": this.clouds,
    "visibility": this.visibility,
    "wind_speed": this.windSpeed,
    "wind_deg": this.windDeg,
    "weather": this.weather
  };
}
import 'current.dart';
import 'daily.dart';
import 'hourly.dart';

class CurrentWeather {
  num lat;
  num lon;
  String timezone;
  Current current;
  List<Hourly> hourly;
  List<Daily> daily;

  CurrentWeather({
    this.lat, 
    this.lon,
    this.timezone,
    this.current,
    this.hourly,
    this.daily
  });

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    this.lat = json["lat"];
    this.lon = json["lon"];
    this.timezone = json["timezone"];
    this.current = Current.fromJson(json["current"]);
    this.hourly = (json["hourly"] as List).map((i) => Hourly.fromJson(i)).toList();
    this.daily = (json["daily"] as List).map((i) => Daily.fromJson(i)).toList();
  }

  Map<String, dynamic> toJson() => {
    "lat": this.lat,
    "lon": this.lon,
    "timezone": this.timezone,
    "current": this.current,
    "hourly": this.hourly,
    "daily": this.daily
  };
}
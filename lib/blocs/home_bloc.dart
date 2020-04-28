
import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/resources/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class HomeBloc extends BlocBase {
  final currentWeatherFetcher = PublishSubject<CurrentWeather>();
  final currentLocationFetcher = PublishSubject<List<Placemark>>();

  Stream<CurrentWeather> get currentWeatherStream => currentWeatherFetcher.stream;
  Stream<List<Placemark>> get currentLocationStream => currentLocationFetcher.stream;

  void getCurrentWeather() async {
    var position = await GeoLocatorService().getLocation();
    if (position == null) return;

    CurrentWeather weather = await repository.getCurrentWeather(position.latitude, position.longitude);
    currentWeatherFetcher.sink.add(weather);
  }

  void getCurrentLocation() async {
    var position = await GeoLocatorService().getLocation();
    if (position == null) return;

    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    currentLocationFetcher.sink.add(placemark);
  }

  @override
  dispose() {
    super.dispose();
    currentWeatherFetcher.close();
    currentLocationFetcher.close();
  }
}
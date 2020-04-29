import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/services/geolocator_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import '_bloc_base.dart';

class HomeBloc extends BlocBase {
  final currentWeatherFetcher = PublishSubject<CurrentWeather>();
  final currentLocationFetcher = PublishSubject<List<Placemark>>();

  Stream<CurrentWeather> get currentWeatherStream => currentWeatherFetcher.stream;
  Stream<List<Placemark>> get currentLocationStream => currentLocationFetcher.stream;

  Future<void> initialize() async {
    var position = await GeoLocatorService().getLocation();
    if (position == null) {
      print(position.toString());
      return;
    }

    CurrentWeather weather = await weatherService.getCurrentWeather(position.latitude, position.longitude);
    currentWeatherFetcher.sink.add(weather);
    
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
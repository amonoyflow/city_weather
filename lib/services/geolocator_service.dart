import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<Position> getLocation() async {
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<GeolocationStatus> getGeolocationStatus() async {
    return await Geolocator().checkGeolocationPermissionStatus();
  }
}
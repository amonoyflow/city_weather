import 'package:http/http.dart';

class ServiceBase {
  final baseUrl = "https://api.openweathermap.org";
  
  Client http = Client();
}
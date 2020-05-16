import 'package:city_weather/blocs/settigs_bloc.dart';
import 'package:city_weather/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(App());
  });
} 

class App extends StatelessWidget {
  App() {
    settingsBloc.loadSavedSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "City Weather",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
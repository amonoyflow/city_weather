import 'dart:ui';
import 'package:city_weather/blocs/home_bloc.dart';
import 'package:city_weather/constant/assets.dart';
import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/resources/datetime_helper.dart';
import 'package:city_weather/resources/format_helper.dart';
import 'package:city_weather/resources/temperature_color.dart';
import 'package:city_weather/widgets/weather_forecast_widget.dart';
import 'package:city_weather/widgets/weather_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  HomeBloc homeBloc;
  Color weatherColor;
  String windSpeed;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
    homeBloc.getCurrentWeather();
    homeBloc.getCurrentLocation();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: StreamBuilder(
        stream: homeBloc.currentWeatherStream,
        builder: (context, AsyncSnapshot<CurrentWeather> snapshot) {
          if (snapshot.hasData) {
            return _buildBody(snapshot.data);
          } 
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.place, color: Colors.red),
          StreamBuilder(
            stream: homeBloc.currentLocationStream,
            builder: (context, AsyncSnapshot<List<Placemark>> snapshot) {
              if (snapshot.hasData) {
                return Flexible(
                  child: Container(
                    child: Text(
                      "${snapshot.data.first.locality}, ${snapshot.data.first.isoCountryCode}",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                    ),
                  ),
                );
              }
              return Text("");
            }
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () => _onSettingsPressed(),
        ),
        IconButton(
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () => _onSettingsPressed(),
        ),
      ],
    );
  }

  Widget _buildBody(CurrentWeather weather) {
    this.weatherColor = TemperatureColor.getTemperatureColor(weather.current.temp);
    this.windSpeed = FormatHelper.formatWindSpeed(weather.current.windSpeed, true);

    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: weatherColor,
                image: DecorationImage(
                  image: AssetImage(Assets.bgCity),
                  fit: BoxFit.fill,
                ),
                border: Border(
                  bottom: BorderSide(
                    color: weatherColor
                  )
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: weatherColor
                      )
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [weatherColor, weatherColor, Colors.white],
                        stops: [0.3, 0.3, 0.8]
                      ),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                weather.current.temp.floor().toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 100,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                              Text(
                                "\u00B0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  letterSpacing: -15
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Today ${DateTimeHelper.formatUnixToTimeOfDay(weather.current.dt)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            WeatherInfoWidget(
                              title: "Humidity",
                              icon: Assets.iconHumidity,
                              value: "${weather.current.humidity}%",
                            ),
                            WeatherInfoWidget(
                              title: "Wind",
                              icon: Assets.iconWindSpeed,
                              value: this.windSpeed,
                            ),
                            WeatherInfoWidget(
                              title: "UV Index",
                              icon: Assets.iconUVIndex,
                              value: weather.current.uvi.toString(),
                            ),
                            WeatherInfoWidget(
                              title: "Clouds",
                              icon: Assets.iconClouds,
                              value: "${weather.current.clouds}%",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            WeatherForecastWidget(
              indicatorColor: this.weatherColor,
              hourly: weather.hourly,
              daily: weather.daily,
            ),
          ],
        ),
      ),
    );
  }

  void _onSettingsPressed() {
    showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        )
      ),
      builder: (context) {
        return Container(
          height: 100,
          child: ListTile(
            leading: Icon(Icons.cloud),
            title: Text("Temperature Units"),
          ),
        );
      }
    );
  }
}
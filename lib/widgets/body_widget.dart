import 'package:city_weather/constant/assets.dart';
import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/resources/datetime_helper.dart';
import 'package:city_weather/resources/format_helper.dart';
import 'package:city_weather/resources/temperature_color.dart';
import 'package:city_weather/widgets/weather_forecast_widget.dart';
import 'package:city_weather/widgets/weather_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatefulWidget {
  final CurrentWeather currentWeather;

  BodyWidget({
    this.currentWeather
  });

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    var weatherColor = TemperatureColor.getTemperatureColor(widget.currentWeather.current.temp);
    var windspeed = FormatHelper.formatWindSpeed(widget.currentWeather.current.windSpeed, true);

    return SingleChildScrollView(
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
                              widget.currentWeather.current.temp.floor().toString(),
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
                              "Today ${DateTimeHelper.formatUnixToTimeOfDay(widget.currentWeather.current.dt)}",
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
                            value: "${widget.currentWeather.current.humidity}%",
                          ),
                          WeatherInfoWidget(
                            title: "Wind",
                            icon: Assets.iconWindSpeed,
                            value: windspeed,
                          ),
                          WeatherInfoWidget(
                            title: "UV Index",
                            icon: Assets.iconUVIndex,
                            value: widget.currentWeather.current.uvi.toString(),
                          ),
                          WeatherInfoWidget(
                            title: "Clouds",
                            icon: Assets.iconClouds,
                            value: "${widget.currentWeather.current.clouds.toString()}%",
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
            indicatorColor: weatherColor,
            hourly: widget.currentWeather.hourly,
            daily: widget.currentWeather.daily,
          ),
        ],
      ),
    );
  }
}
import 'package:city_weather/blocs/settigs_bloc.dart';
import 'package:city_weather/constant/assets.dart';
import 'package:city_weather/dto/settings_dto.dart';
import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/utilities/datetime_helper.dart';
import 'package:city_weather/utilities/format_helper.dart';
import 'package:city_weather/utilities/temperature_color.dart';
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
  @override
  Widget build(BuildContext context) {
    var weatherColor = TemperatureColor.getTemperatureColor(widget.currentWeather.current.temp);

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
              border: Border(bottom: BorderSide(color: weatherColor)),
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: weatherColor)),
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
                            StreamBuilder(
                              stream: settingsBloc.settingsStream,
                              initialData: SettingsDto(isImperial: false),
                              builder: (context, AsyncSnapshot<SettingsDto> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    FormatHelper.formatTemperature(widget.currentWeather.current.temp, settingsBloc.settings.isImperial).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 100,
                                      fontWeight: FontWeight.w800
                                    ),
                                  );
                                } 
                                return Container();
                              },
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
                    WeatherInfoWidget(currentWeather: widget.currentWeather),
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
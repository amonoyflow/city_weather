import 'package:city_weather/blocs/settigs_bloc.dart';
import 'package:city_weather/constant/assets.dart';
import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/resources/format_helper.dart';
import 'package:flutter/material.dart';

class WeatherInfoWidget extends StatefulWidget {
  final CurrentWeather currentWeather;

  WeatherInfoWidget({
    this.currentWeather,
  });

  @override
  State<StatefulWidget> createState() => _WeatherInfoWidgetState();
}

class _WeatherInfoWidgetState extends State<WeatherInfoWidget> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          createInfo(
            "Humidity", 
            Assets.iconHumidity, 
            "${widget.currentWeather.current.humidity}%"
          ),
          StreamBuilder(
            stream: settingsBloc.currentUnitStream,
            initialData: false,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return createInfo(
                "Wind", 
                Assets.iconWindSpeed, 
                FormatHelper.formatWindSpeed(widget.currentWeather.current.windSpeed, settingsBloc.isUnitImperial())
              );
            }
          ),
          createInfo(
            "UV Index", 
            Assets.iconUVIndex, 
            widget.currentWeather.current.uvi.toString()
          ),
          createInfo(
            "Clouds", 
            Assets.iconClouds, 
            "${widget.currentWeather.current.clouds.toString()}%"
          ),
        ],
      ),
    );
  }

  Widget createInfo(String title, String image, String value) {
    return Container(
      height: 160,
      padding: EdgeInsets.all(10),
      width: (MediaQuery.of(context).size.width / 4.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w700
            ),
          ),
          Image.asset(
            image,
            width: 40,
            height: 40,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
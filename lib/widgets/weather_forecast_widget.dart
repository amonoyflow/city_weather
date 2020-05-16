import 'package:city_weather/blocs/settigs_bloc.dart';
import 'package:city_weather/dto/settings_dto.dart';
import 'package:city_weather/models/daily.dart';
import 'package:city_weather/models/hourly.dart';
import 'package:city_weather/utilities/datetime_helper.dart';
import 'package:city_weather/utilities/format_helper.dart';
import 'package:city_weather/utilities/temperature_color.dart';
import 'package:flutter/material.dart';

class WeatherForecastWidget extends StatefulWidget {
  final Color indicatorColor;
  final List<Hourly> hourly;
  final List<Daily> daily;

  WeatherForecastWidget({
    this.indicatorColor,
    this.hourly,
    this.daily
  });

  @override
  State<StatefulWidget> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecastWidget> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    this.tabController.addListener(() {
      if (this.tabController.indexIsChanging) {
        setState(() {
          _createForecast(this.tabController.index == 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: this.tabController,
            labelColor: Colors.grey.shade700,
            indicatorColor: widget.indicatorColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontWeight: FontWeight.w700),
            tabs: <Tab>[
              Tab(text: "Hourly Forecast"),
              Tab(text: "Daily Forecast")
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 0),
            child: _createForecast(this.tabController.index == 0)
          ),
        ],
      ),
    );
  }

  Widget _createForecast(bool isToday) {
    if (isToday) {
      return _createTodayForecast();
    } else {
      return _createWeeklyForecast();
    }
  }

  Widget _createTodayForecast() {
    List<Hourly> items = widget.hourly.where((x) => x.today.month == DateTime.now().month && x.today.day == DateTime.now().day).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      key: ValueKey<num>(items.length),
      children: [
        ...List.generate(
          items.length,
          (index) => Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200)
              ),
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  DateTimeHelper.formatUnixToTimeOfDay(items[index].dt),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        StreamBuilder(
                          stream: settingsBloc.settingsStream,
                          initialData: SettingsDto(isImperial: false),
                          builder: (context, AsyncSnapshot<SettingsDto> snapshot) {
                            return Text(
                              "${FormatHelper.formatTemperature(items[index].temp, settingsBloc.settings.isImperial).toString()}\u00B0",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            );
                          }
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: TemperatureColor.getTemperatureColor(items[index].temp), 
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createWeeklyForecast() {
    List<Daily> items = widget.daily.where((x) => x.today.day != DateTime.now().day).toList();
    return Column(
      key: ValueKey<num>(items.length),
      children: [
        ...List.generate(
          items.length,
          (index) => Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200)
              ),
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  DateTimeHelper.formatUnixToDay(items[index].dt),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Day",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(width: 10),
                        StreamBuilder(
                          stream: settingsBloc.settingsStream,
                          initialData: SettingsDto(isImperial: false),
                          builder: (context, AsyncSnapshot<SettingsDto> snapshot) {
                            return Text(
                              "${FormatHelper.formatTemperature(items[index].temp.day, settingsBloc.settings.isImperial).toString()}\u00B0",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            );
                          }
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: TemperatureColor.getTemperatureColor(items[index].temp.day),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Night",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(width: 10),
                        StreamBuilder(
                          stream: settingsBloc.settingsStream,
                          initialData: SettingsDto(isImperial: false),
                          builder: (context, AsyncSnapshot<SettingsDto> snapshot) {
                            return Text(
                              "${FormatHelper.formatTemperature(items[index].temp.eve, settingsBloc.settings.isImperial).toString()}\u00B0",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            );
                          }
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: TemperatureColor.getTemperatureColor(items[index].temp.day),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }
}
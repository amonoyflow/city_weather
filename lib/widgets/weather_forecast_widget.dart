import 'package:city_weather/models/daily.dart';
import 'package:city_weather/models/hourly.dart';
import 'package:city_weather/resources/datetime_helper.dart';
import 'package:city_weather/resources/temperature_color.dart';
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
          build(context);
        });
      }
    });
  }

  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
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
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700
            ),
            tabs: <Tab>[
              Tab(text: "Hourly Forecast"),
              Tab(text: "Daily Forecast")
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 0),
            child: createForecast(this.tabController.index == 0)
          ),
        ],
      ),
    );
  }

  Widget createTodayForecast() {
    List<Hourly> items = widget.hourly.where((x) => x.today.month == DateTime.now().month && x.today.day == DateTime.now().day).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      key: ValueKey<int>(items.length),
      children: [
        ...List.generate(
          items.length,
          (index) => Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200
                  )
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
                        Text(
                          "${items[index].temp.floor().toString()}\u00B0",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
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

  Widget createWeeklyForecast() {
    List<Daily> items = widget.daily.where((x) => x.today.day != DateTime.now().day).toList();
    return Column(
      key: ValueKey<int>(items.length),
      children: [
        ...List.generate(
          items.length,
          (index) => Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200
                  )
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
                        Text(
                          "${items[index].temp.day.floor().toString()}\u00B0",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
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
                        Text(
                          "${items[index].temp.eve.floor().toString()}\u00B0",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
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

  Widget createForecast(bool isToday) {
    if (isToday) {
      return createTodayForecast();
    } else {
      return createWeeklyForecast();
    }
  }
}
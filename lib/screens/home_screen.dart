import 'package:city_weather/blocs/home_bloc.dart';
import 'package:city_weather/models/current_weather.dart';
import 'package:city_weather/widgets/appbar_widget.dart';
import 'package:city_weather/widgets/body_widget.dart';
import 'package:city_weather/widgets/settings_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    homeBloc.initialize();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: AppBarWidget(),
      actions: <Widget>[
        SettingsWidget()
      ],
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: homeBloc.currentWeatherStream,
      builder: (context, AsyncSnapshot<CurrentWeather> snapshot) {
        if (snapshot.hasData) {
          return BodyWidget(currentWeather: snapshot.data);
        } 
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> refreshData() async {
    setState(() {
      homeBloc.initialize();
    });
  }
}
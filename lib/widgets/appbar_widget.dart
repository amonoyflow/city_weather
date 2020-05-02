import 'package:city_weather/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppBarWidget extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() => _AppBarWidget();
}

class _AppBarWidget extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.place, 
          color: Colors.red
        ),
        Flexible(
          child: StreamBuilder(
            stream: homeBloc.currentLocationStream,
            builder: (context, AsyncSnapshot<List<Placemark>> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "${snapshot.data.first.locality}, ${snapshot.data.first.isoCountryCode}",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),
                );
              }
              return Container();
            }
          ),
        ),
      ]
    );
  }
}
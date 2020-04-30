import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AppBarWidget extends StatefulWidget  {
  final List<Placemark> placemark;

  AppBarWidget({
    this.placemark
  });

  @override
  State<StatefulWidget> createState() => _AppBarWidget();
}

class _AppBarWidget extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.place, 
          color: Colors.red
        ),
        Flexible(
          child: Container(
            child: Text(
              "${widget.placemark.first.locality}, ${widget.placemark.first.isoCountryCode}",
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18
              ),
            ),
          ),
        )
      ]
    );
  }
}
import 'package:city_weather/constant/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  bool _metric = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.settings, color: Colors.black),
        onPressed: _onPressed,
      ),
    );
  }

  _onPressed() {
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
          child: Center(
            child: SwitchListTile(
              title: Text("Use Imperial System"),
              value: _metric,
              onChanged: (bool value) { setState(() { _metric = value; }); 
              },
              secondary: Image.asset(
                Assets.iconMeasurement,
                width: 30,
                height: 30,
              ),
            ),
          )
        );
      }
    );
  }
}
import 'package:city_weather/blocs/settigs_bloc.dart';
import 'package:city_weather/constant/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.settings, 
        color: Colors.black
      ),
      onPressed: _onSettingsTap,
    );
  }

  _onSettingsTap() {
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
        return Bottom();
      }
    );
  }
}

class Bottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  bool unitImperial = settingsBloc.isUnitImperial();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: SwitchListTile(
          title: Text("Use Imperial System"),
          value: unitImperial,
          onChanged: (bool newValue) {
            setState(() {
              settingsBloc.onUnitChanged(newValue);
              unitImperial = newValue;
            });
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
}
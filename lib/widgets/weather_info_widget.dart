import 'package:flutter/material.dart';

class WeatherInfoWidget extends StatefulWidget {
  final String title;
  final String icon;
  final String value;

  WeatherInfoWidget({
    this.title,
    this.icon,
    this.value
  });

  @override
  State<StatefulWidget> createState() => _WeatherInfoWidgetState();
}

class _WeatherInfoWidgetState extends State<WeatherInfoWidget> with TickerProviderStateMixin {
  Animation<double> fadeIn;

  @override
  void initState() {
    super.initState();
    var animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)
    );
    fadeIn = Tween<double>(
      begin: 0.0, 
      end: 1.0
    ).animate(animation);
    animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeIn,
      child: Container(
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
              widget.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w700
              ),
            ),
            Image.asset(
              widget.icon,
              width: 40,
              height: 40,
            ),
            Text(
              widget.value,
              style: TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
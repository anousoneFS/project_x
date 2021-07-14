import 'package:flutter/material.dart';
import 'package:project_x/style/color_theme.dart';
import 'package:project_x/widgets/sensor_value_banner.dart';

class SensorValueStreamingWidget extends StatelessWidget {
  final Map<String, dynamic> json;

  const SensorValueStreamingWidget({@required this.json});

  @override
  Widget build(BuildContext context) {
    return
       Column(
        children: [
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SensorValueBanner(
                color: GFTheme.lightBlue,
                title: json.keys.toList()[1],
                value: json.values.toList()[1],
                image: "assets/icons/thermometer.svg",
              ),
              SensorValueBanner(
                color: GFTheme.lightPurple,
                title: json.keys.toList()[2],
                value: json.values.toList()[2],
                image: "assets/icons/humidity.svg",
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SensorValueBanner(
                color: GFTheme.lightPeach,
                title: json.keys.toList()[3],
                value: json.values.toList()[3],
                image: "assets/icons/ph.svg",
              ),
              SensorValueBanner(
                color: GFTheme.lightBlue,
                title: json.keys.toList()[4],
                value: json.values.toList()[4],
                image: "assets/icons/ec-water.svg",
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SensorValueBanner(
                color: GFTheme.lightBlue,
                title: json.keys.toList()[5],
                value: json.values.toList()[5],
                image: "assets/icons/water-temperature.svg",
              ),
              SensorValueBanner(
                color: GFTheme.lightYellow,
                title: json.keys.toList()[6],
                value: json.values.toList()[6],
                image: "assets/icons/sun.svg",
              ),
            ],
          ),
        ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_x/components/button_widget.dart';

class TimePickerWidget extends StatelessWidget {
  final Function func;
  final String time;
  final String title;
  final double rightPadding;
  final double leftPadding;

  TimePickerWidget({
    @required this.func,
    this.time = '00:00',
    this.title = 'Time',
    this.rightPadding = 0,
    this.leftPadding = 0,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
        child: ButtonHeaderWidget(
          title: title,
          text: time,
          onClicked: () => func(context),
        ),
      );
}

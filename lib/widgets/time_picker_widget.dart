import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_x/components/button_widget.dart';

class TimePickerWidget extends StatefulWidget {
  final Function func;
  final String time;
  final String title;

  TimePickerWidget({@required this.func, @required this.time, @required this.title});

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: widget.title,
        text: widget.time,
        onClicked: () => widget.func(context),
      );

}

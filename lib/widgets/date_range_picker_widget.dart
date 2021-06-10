import 'package:flutter/material.dart';
import 'package:project_x/logics/choose_date_range_logic.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/monitor_provider.dart';
import 'package:provider/provider.dart';
import '../components/button_widget.dart';

class DateRangePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialData = Provider.of<MonitorProvider>(context, listen: true);
    List<List<dynamic>> data = Provider.of<FirebaseApi>(context, listen: true).getData;

    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
            text: initialData.getFormDate,
            onClicked: () => pickDateRange(context, data, initialData),
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.arrow_forward, color: Colors.blueAccent),
        const SizedBox(width: 8),
        Expanded(
          child: ButtonWidget(
            text: initialData.getUntilDate,
            onClicked: () => pickDateRange(context, data, initialData),
          ),
        ),
      ],
    );
  }
}

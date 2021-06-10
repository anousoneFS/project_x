import 'package:flutter/material.dart';
import 'package:project_x/providers/monitor_provider.dart';

class TableWidget extends StatelessWidget {
  final List<List<dynamic>> data;
  final MonitorProvider initialData;

  TableWidget({@required this.data, @required this.initialData});

  @override
  Widget build(BuildContext context) {
    final dataTable =
        data.sublist(initialData.getIndexBegin, initialData.getIndexEnding);

    return ListView.builder(
      itemCount: dataTable.length ?? 0,
      itemBuilder: (ctx, index) {
        return Text(
            "${dataTable[index]}");
      },
    );
  }
}

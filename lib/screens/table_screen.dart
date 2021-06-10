import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_x/widgets/datagrid_widget.dart';
import 'package:project_x/widgets/date_range_picker_widget.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/monitor_provider.dart';
import 'package:project_x/widgets/no_data_table_widget.dart';
import 'package:project_x/widgets/table_widget.dart';
import 'package:project_x/widgets/test_table_widget.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  static String routeName = "/table";

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<List<dynamic>> data;
  MonitorProvider initialData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    data = Provider.of<FirebaseApi>(context, listen: true).getData;
    initialData = Provider.of<MonitorProvider>(context);
    return Container(
      width: size.width,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DateRangePickerWidget(),
            ),
            SizedBox(
              height: 2,
            ),
            if (data.length > 1)
              Expanded(
                // child: TableWidget(
                //   data: data,
                //   initialData: initialData,
                // ),
                // child: TestTableWidget(),
                child: MyHomePage(),
              )
            else
              Expanded(
                child: noDataTableWidget(data),
              ),
          ],
        ),
      ),
    );
  }
}

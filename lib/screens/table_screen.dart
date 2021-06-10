import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_x/components/date_range_picker_widget.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatelessWidget {
  static String routeName = "/table";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: DateRangePickerWidget(),
      ),
    );
  }
}

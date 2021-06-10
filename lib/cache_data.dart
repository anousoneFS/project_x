import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Box box;
Future openBoxSensor() async {
  Directory directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  box = await Hive.openBox('sensor_data');
  return;
}

Future pushDataSensor(data) async {
  await box.clear();
  for (var d in data) {
    box.add(d);
  }
}

Box boxSetting;
Future openBoxSetting() async {
  Directory directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  boxSetting = await Hive.openBox('setting_data');
  return;
}

Future pushDataSetting(data) async {
  await boxSetting.clear();
  // for (var d in data) {
  //   boxSetting.add(d);
  // }
  boxSetting.add(data);
}
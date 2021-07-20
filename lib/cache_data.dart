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
  await box.close();
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
  // var key = Hive.generateSecureKey();
  // boxHome = await Hive.openBox('setting_data',encryptionKey: key);
  boxHome = await Hive.openBox('setting_data');
  return;
}

Future pushDataSetting(data) async {
  await boxSetting.clear();
  // for (var d in data) {
  //   boxSetting.add(d);
  // }
  await boxSetting.add(data);
  print('closing');
  await boxSetting.close();
}

Box boxHome;
Future openBoxHome() async {
  Directory directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  // var key = Hive.generateSecureKey();
  // boxHome = await Hive.openBox('home',encryptionKey: key);
  boxHome = await Hive.openBox('home');
  return;
}

Future pushHome(data) async {
  await boxHome.clear();
  boxHome.add(data);
  await boxHome.close();
}

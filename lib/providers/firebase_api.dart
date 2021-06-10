import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../cache_data.dart';

class FirebaseApi with ChangeNotifier{
  List<List<dynamic>> _sensorData = [
    ['time', 'temperature', 'humidity', 'ph', 'ec', 'light'],
  ];

  List<List<dynamic>> get getData => _sensorData;

  Future<void> fetchData() async{
    try{
      final url =
          'https://final-project-2fa6f-default-rtdb.firebaseio.com/sensor-values2.json';
      final response = await http.get(url);
      final body = json.decode(response.body) as Map<String, dynamic>;
      List<List<dynamic>> sensorList = [
        ['time', 'temperature', 'humidity', 'ph', 'ec', 'light'],
      ];
      body.forEach((key, value) {
        for (var item in value.sublist(1)) {
          Map<String, dynamic> myMap = json.decode(item) as Map<String, dynamic>;
          sensorList.add([
            myMap["time"],
            myMap["temp"],
            myMap["humid"],
            myMap["ph"],
            myMap["ec"],
            myMap["light"],
          ]);
        }
      });
      // ຖ້າມີ Error ເກີດຂຶ້ນ ຄຳສັ່ງຕໍ່ໄປນີ້ຈະບໍ່ຖືກເອີ້ນໃຊ້
      _sensorData = sensorList;
      await openBoxSensor();
      await pushDataSensor(_sensorData).then((value) {
        print('-----> Save data to LocalDB Success');
      });
      notifyListeners();
    }catch(error){
      print("---- Have Error fetchData in Provider -----");
      Fluttertoast.showToast(
        msg: 'Connection Failed!',
        timeInSecForIosWeb: 3,
      );
      print(error);
      throw error;
    }
  }

  Future<void> fetchDataFormLocalDb() async{
    // get data from LocalDB
    try{
      await openBoxSensor();
      var myMap = box
          .toMap()
          .values
          .toList();
      if (myMap.isEmpty) {
        print("LocalDb is empty");
      }else{
        List<List<dynamic>> fetchData = List.generate(
          myMap.length,
              (index) => myMap[index],
        );
        // add data from db to provider
        _sensorData = fetchData;
      }
      notifyListeners();
    }catch(error){
      print("--- Have Error in OpenBoxSensor ---");
      print(error);
     throw error;
    }
  }

  Future<void> saveData() async {
    String sensorCsv = ListToCsvConverter().convert(_sensorData);
    print(sensorCsv);
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          // String newPath = '';
          // List<String> folders = directory.path.split('/');
          // for (int x = 1; x < folders.length; x++) {
          //   if (folders[x] != "Android") {
          //     newPath += '/' + folders[x];
          //   } else {
          //     break;
          //   }
          // }
          // newPath = newPath + "/Project_X";
          // directory = Directory(newPath);
          // print(directory.path);
        } else {
          print("do'nt have permission");
          return;
        }
      } else {
        if (await _requestPermission(Permission.storage)) {
          directory = await getApplicationDocumentsDirectory();
        } else {
          print("don't have permission");
          return;
        }
      }

      File saveFile = File(directory.path + "/sensor_data.csv");
      if (!await directory.exists()) {
        print("==> Don't Have Directory");
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        print("==> Directory Is Created");
        await saveFile.writeAsString(sensorCsv).then((_) {
          print("save file success");
        });
      }
    } catch (e) {
      print("--- Get Error Form SaveData Function ---");
      print(e);
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

}
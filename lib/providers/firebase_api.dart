import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_x/models/sensor_data_model.dart';
import 'package:project_x/providers/monitor_provider.dart';
import 'package:provider/provider.dart';

import '../cache_data.dart';

class FirebaseApi with ChangeNotifier {
  List<List<dynamic>> _sensorData = [
    ['time', 'temperature', 'humidity', 'ph', 'ec', 'light'],
  ];
  List<SensorData> _sensorDataObj;

  List<List<dynamic>> _sensorSubData;
  List<SensorData> _sensorSubDataObj;

  String _formDate = 'Form';
  String _untilDate = 'Until';
  int _indexBegin = 0;
  int _indexEnding = 97;

  List<List<dynamic>> get getData => _sensorData;

  List<SensorData> get getDataObj => _sensorDataObj;

  List<List<dynamic>> get getSubData => _sensorSubData;

  List<SensorData> get getSubDataObj => _sensorSubDataObj;

// ===========

  String get getFormDate => _formDate;

  String get getUntilDate => _untilDate;

  int get getIndexBegin => _indexBegin;

  int get getIndexEnding => _indexEnding;

  void setSubDataObj() {
    // ເອົາຂໍ້ມູນທັງໝົດ ມາແບ່ງສ່ວນ
    _sensorSubDataObj = _sensorDataObj.sublist(_indexBegin, _indexEnding);
    notifyListeners();
  }

  void setSubData() {
    // ເອົາຂໍ້ມູນທັງໝົດ ມາແບ່ງສ່ວນ
    _sensorSubData = _sensorData.sublist(_indexBegin, _indexEnding);
    notifyListeners();
  }

  void reversData() {
    _sensorSubDataObj = _sensorSubDataObj.reversed.toList();
    _sensorSubData = _sensorSubData.reversed.toList();
    print("=====> reversed");
    notifyListeners();
  }

  void setFormDate(String newDate) {
    _formDate = newDate;
    notifyListeners();
  }

  void setUntilDate(String newDate) {
    _untilDate = newDate;
    notifyListeners();
  }

  void setIndexBegin(int newIndex) {
    _indexBegin = newIndex;
    notifyListeners();
  }

  void setIndexEnding(int newIndex) {
    _indexEnding = newIndex;
    notifyListeners();
  }

  // ===========

  Future<void> fetchData() async {
    try {
      DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
      await _databaseReference
          .child('sensor-values')
          .once()
          .then((DataSnapshot snapshot) {
            snapshot.value.forEach((key, value) {
              for (var item in value.sublist(1)) {
                Map<String, dynamic> myMap =
                    json.decode(item) as Map<String, dynamic>;
                // ດັກ Error ໄວ້ ຖ້າມີຄ່າ Null
                _sensorData.add([
                  myMap["time"] ?? 0,
                  myMap["temp"] ?? 0,
                  myMap["humid"] ?? 0,
                  myMap["ph"] ?? 0,
                  myMap["ec"] ?? 0,
                  myMap["light"] ?? 0,
                ]);
              }
            });
            _sensorDataObj = _sensorData
                .sublist(1)
                .map((list) => SensorData.formList(list))
                .toList();

            // ===> set Sub Data
            setSubData();
            setSubDataObj();
        // =====> pass json data <===
      }).then((value) {
        print("------> call then snapshot firebase next save to LocalDB");
        // ====> save data to local db
        // saveSettingToLocalDb(_data);
        // setAllStatus();
      });
    } catch (error) {
      print('---- Have Error fetch data sensor in provider----');
      print(error);
      throw error;
    }
  }

  // Future<void> fetchData() async {
  //   try {
  //     final url =
  //         'https://final-project-2fa6f-default-rtdb.firebaseio.com/sensor-values2.json';
  //     final response = await http.get(url);
  //     final body = json.decode(response.body) as Map<String, dynamic>;
  //     body.forEach((key, value) {
  //       for (var item in value.sublist(1)) {
  //         Map<String, dynamic> myMap =
  //             json.decode(item) as Map<String, dynamic>;
  //         // ດັກ Error ໄວ້ ຖ້າມີຄ່າ Null
  //         _sensorData.add([
  //           myMap["time"] ?? 0,
  //           myMap["temp"] ?? 0,
  //           myMap["humid"] ?? 0,
  //           myMap["ph"] ?? 0,
  //           myMap["ec"] ?? 0,
  //           myMap["light"] ?? 0,
  //         ]);
  //       }
  //     });
  //     _sensorDataObj = _sensorData
  //         .sublist(1)
  //         .map((list) => SensorData.formList(list))
  //         .toList();
  //
  //     // ===> set Sub Data
  //     setSubData();
  //     setSubDataObj();
  //
  //     // ຫຼັງຈາກ assign ຄ່າແລ້ວຈາກນັ້ນ save ລົງ LocalDB ໄວ້
  //     await openBoxSensor();
  //     await pushDataSensor(_sensorData).then((value) {
  //       print('-----> Save data to LocalDB Success');
  //     });
  //     notifyListeners();
  //   } catch (error) {
  //     print("---- Have Error fetchData in Provider -----");
  //     Fluttertoast.showToast(
  //       msg: 'Connection Failed!',
  //       timeInSecForIosWeb: 3,
  //     );
  //     print(error);
  //     throw error;
  //   }
  // }

  Future<void> fetchDataFormLocalDb() async {
    // get data from LocalDB
    try {
      await openBoxSensor();
      var myMap = box.toMap().values.toList();
      if (myMap.isEmpty) {
        print("LocalDb is empty");
      } else {
        List<List<dynamic>> fetchData = List.generate(
          myMap.length,
          (index) => myMap[index],
        );
        // add data from LocalDB to provider
        _sensorData = fetchData;
        // add data List to data Object but don't need header
        _sensorDataObj = _sensorData
            .sublist(1)
            .map((list) => SensorData.formList(list))
            .toList();

        // set Sub Data
        setSubData();
        setSubDataObj();
      }
      notifyListeners();
    } catch (error) {
      print("--- Have Error in OpenBoxSensor ---");
      print(error);
      throw error;
    }
  }

  Future<void> saveData() async {
    // save ສະເພາະຊ່ວງເວລາທີ່ user ໄດ້ກົດເລືອກນັ້ນຄືເຫດຜົນທີໃຊ້ _sensorSubData
    _sensorSubData.insert(
      0,
      ['time', 'temperature', 'humidity', 'ph', 'ec', 'light'],
    );
    String sensorCsv = ListToCsvConverter().convert(_sensorSubData);
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
          Fluttertoast.showToast(
            msg: 'Save File Success!!',
            timeInSecForIosWeb: 3,
          );
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

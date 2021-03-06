import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_x/models/sensor_data_model.dart';
import 'package:project_x/providers/monitor_provider.dart';
import 'package:provider/provider.dart';

import '../cache_data.dart';

class FirebaseApi with ChangeNotifier {
  String _connectionStatus = '';

  String get getConnectionStatus => _connectionStatus;

  void setConnectionStatus(String newStatus) {
    _connectionStatus = newStatus;
    notifyListeners();
  }

  List<List<dynamic>> _sensorData = [
    ['time', 'temperature', 'humidity', 'ph', 'ec', 'light'],
  ];
  List<SensorData> _sensorDataObj = [];

  List<List<dynamic>> _sensorSubData = [];
  List<SensorData> _sensorSubDataObj = [];

  String _formDate = 'ຈາກວັນທີ';
  String _untilDate = 'ຫາວັນທີ';
  int _indexBegin = 0;
  int _indexEnding = 2;

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
    if (_sensorDataObj.length > 1) {
      _sensorSubDataObj = _sensorDataObj.sublist(_indexBegin, _indexEnding);
    } else {
      _sensorSubDataObj = _sensorDataObj;
    }
    notifyListeners();
  }

  void setSubData() {
    // ເອົາຂໍ້ມູນທັງໝົດ ມາແບ່ງສ່ວນ
    if (_sensorData.length > 1) {
      _sensorSubData = _sensorData.sublist(_indexBegin, _indexEnding);
    } else {
      _sensorSubData = _sensorData;
    }
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
      // ເກັບເວລາທຳອິດຂອງແຕ່ລະມື້ໄວ້
      List<DateTime> _timeUnsort = [];
      List<List<List<dynamic>>> _subAllData = [];
      List<List<dynamic>> _subData = [];

      DatabaseReference _databaseReference =
          FirebaseDatabase.instance.reference();

      await _databaseReference
          .child('sensor-values2')
          .once()
          .then((DataSnapshot snapshot) {
        print('snapshot is ${snapshot.value}');
        snapshot.value.forEach((key, value) {
          // loop ຂອງແຕ່ລະມື້
          int first = 1;
          // sublist ເພາະວ່າ ມີຄ່າ null ຢູ່ທາງໜ້າ
          // print('value is $value');
          for (var item in value.sublist(0)) {
            // print('item is $item');

            if (item != null) {
              Map<String, dynamic> myMap =
                  json.decode(item) as Map<String, dynamic>;
              // ດັກ Error ໄວ້ ຖ້າມີຄ່າ Null
              _subData.add([
                myMap["time"] ?? 0,
                myMap["temp"] ?? 0,
                myMap["humid"] ?? 0,
                myMap["ph"] ?? 0,
                myMap["ec"] ?? 0,
                myMap["light"] ?? 0,
              ]);
              if (first == 1) {
                // 1-6-2021 00:15
                List splitEnd = myMap['time'].split(' ').toList();
                List<String> splitTime = splitEnd[0].split('-').toList();
                _timeUnsort.add(DateFormat('dd-MM-yyyy').parse(splitEnd[0]));
                first = 2;
              }
            }
          }

          _subAllData.add(_subData);
          _subData = [];
        });

        List<DateTime> _timeSort = [..._timeUnsort];
        _timeSort.sort((a, b) => a.compareTo(b));
        // ຊອກຫາ index ຂອງເວລາທີ່ຈັດລຽງແລ້ວ
        List<int> _timeIndexSort = [];
        for (var i = 0; i < _timeSort.length; i++) {
          for (var j = 0; j < _timeUnsort.length; j++) {
            if (_timeSort[i] == _timeUnsort[j]) {
              _timeIndexSort.add(j);
            }
          }
        }
        // ເອົາ index ຂອງເວລາທີຈັດລຽງແລ້ວມາ Map ກັບ subAllData ຈະໄດ້ຂໍ້ມູນທັງໝົດທີ່ Sort ແລ້ວ
        List<List<dynamic>> _finalDataSorted = [
          ['time', 'temperature', 'humidity', 'ph', 'ec', 'light'],
        ];
        _timeIndexSort.forEach((index) {
          _subAllData[index].forEach((item) {
            _finalDataSorted.add(item);
          });
        });

        // type = List<dynamic>
        _sensorData = [..._finalDataSorted];
        //ປ່ຽນໄປເປັນ Object  List<dynamic> ==> SensorData()
        if (_sensorData.length > 1) {
          _sensorDataObj = _sensorData
              .sublist(1)
              .map((list) => SensorData.formList(list))
              .toList();
        } else {
          _sensorDataObj = [
            SensorData(
                time: '0-0-0 00:00',
                tempAir: 0,
                tempWater: 0,
                ec: 0,
                ph: 0,
                humid: 0,
                light: 0)
          ];
        }
        // ===> set Sub Data
        setSubData();
        setSubDataObj();
        // =====> pass json data <===
      }).then((value) async {
        // ====> save data to local db
        // ຫຼັງຈາກ assign ຄ່າແລ້ວຈາກນັ້ນ save ລົງ LocalDB ໄວ້
        await saveSensorDataToLocalDb(_sensorData);
        notifyListeners();
      });
    } catch (error) {
      print('---- Have Error fetch data sensor in provider----');
      Fluttertoast.showToast(
        msg: 'Connection Failed! api',
        timeInSecForIosWeb: 3,
      );
      print(error);
      throw error;
    }
  }

  Future<void> fetchDataFormLocalDb() async {
    // get data from LocalDB
    try {
      await openBoxSensor();
      var myMap = box.toMap().values.toList();
      box.close();
      if (myMap.isEmpty) {
        print("LocalDb is empty");
      } else {
        List<List<dynamic>> fetchData = List.generate(
          myMap.length,
          (index) => myMap[index],
        );
        print("=> 1");
        // add data from LocalDB to provider
        _sensorData = fetchData;
        // add data List to data Object but don't need header
        _sensorDataObj = _sensorData
            .sublist(1)
            .map((list) => SensorData.formList(list))
            .toList();

        print("=> 2");

        // set Sub Data
        setSubData();
        setSubDataObj();
        print('fetch sensor data from Local DB success');
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

Future<void> saveSensorDataToLocalDb(List<dynamic> sensorData) async {
  await openBoxSensor();
  await pushDataSensor(sensorData).then((value) {
    print('save sensor data to Local DB success');
  });
}

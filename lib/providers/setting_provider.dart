import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_x/cache_data.dart';
import 'package:project_x/logics/format_time.dart';
import 'package:project_x/models/setting_model.dart';

class SettingProvider with ChangeNotifier {
  List<TimeOfDay> _timeFish = [];
  int _timePumpActive; // ຍັງບໍ່ທັນ get from firebase
  DatabaseReference _databaseReference;

  // for alert
  Setting _data = new Setting();
  double _maxPh;
  double _minPh;
  int _maxEc;
  int _minEc;
  int _maxTempAir;
  int _minTempAir;
  int _maxTempWater;
  int _minTempWater;
  int _maxHumid;
  int _minHumid;
  int _maxLight;
  int _minLight;

  List<TimeOfDay> get getTimeFish => [..._timeFish];

  void setTimeFish1(TimeOfDay newTime1) {
    _timeFish[0] = newTime1;
    notifyListeners();
  }

  void setTimeFish2(TimeOfDay newTime2) {
    _timeFish[1] = newTime2;
    notifyListeners();
  }

  int get getPumpActive => _timePumpActive;

  void setTimePumpActive(int newValue) {
    _timePumpActive = newValue;
    // notifyListeners();
  }

  double get getMaxPh => _maxPh;

  int get getMaxEc => _maxEc;

  int get getMaxTempWater => _maxTempWater;

  int get getMaxTempAir => _maxTempAir;

  int get getMaxHumid => _maxHumid;

  int get getMaxLight => _maxLight;

  double get getMinPh => _minPh;

  int get getMinEc => _minEc;

  int get getMinTempWater => _minTempWater;

  int get getMinTempAir => _minTempAir;

  int get getMinHumid => _minHumid;

  int get getMinLight => _minLight;

  Future<void> fetchData() async {
    try {
      _databaseReference = FirebaseDatabase.instance.reference();
      await _databaseReference
          .child('setting')
          .once()
          .then((DataSnapshot snapshot) {
        // =====> pass json data <===
        assignData(snapshot.value);
      });
      // ====> save data to local db
      saveSettingToLocalDb(_data);
    } catch (error) {
      print('---- Have Error fetch settingFirebase in provider----');
      print(error);
      throw error;
    }
  }

  Future<void> fetchDataFormLocalDb() async {
    // get data from LocalDB
    try {
      await openBoxSetting();
      final myMap = boxSetting.toMap().values.toList();
      if (myMap == null) {
        print("setting LocalDb is empty");
      } else {
        // =====> pass json data <======
        assignData(myMap[0]);
      }
      notifyListeners();
    } catch (error) {
      print("--- Have Error in OpenBoxSetting ---");
      print(error);
      throw error;
    }
  }

  Future<void> update() async {
    // update Firebase RTDB
    List<String> formatTime = FormatTime.displayTime(_timeFish);
    try {
      await _databaseReference.child('setting').update({
        'maxPh': _maxPh,
        'maxEc': _maxEc,
        'maxTempWater': _maxTempWater,
        'maxTempAir': _maxTempAir,
        'maxHumid': _maxHumid,
        'maxLight': _maxLight,
        'minPh': _minPh,
        'minEc': _minEc,
        'minTempWater': _minTempWater,
        'minTempAir': _minTempAir,
        'minHumid': _minHumid,
        'minLight': _minLight,
        'timeFish1': formatTime[0],
        'timeFish2': formatTime[1],
        'timePumpActive': _timePumpActive,
      });
      // update streaming for Arduino
      await _databaseReference.update({
        'arduino_streaming':
            formatTime.join(',') + ',' + _timePumpActive.toString(),
      });

      // ຕ້ອງ update data ຢູ່ object ກ່ອນ or _data
      updateObj(formatTime);
      // ===> save to Local Db when update Data
      saveSettingToLocalDb(_data);
      Fluttertoast.showToast(
        msg: 'Save Success!!',
        timeInSecForIosWeb: 3,
      );
    } catch (error) {
      print("--- Have Error Update to Firebase ----");
      Fluttertoast.showToast(
        msg: 'Save Failed!!',
        timeInSecForIosWeb: 3,
      );
      // ຕ້ອງ update data ຢູ່ object ກ່ອນ _data
      updateObj(formatTime);
      // ====> save to Local Db when update Data
      saveSettingToLocalDb(_data);
      print(error);
    }
  }

  void updateObj(List<String> time) {
    _data.timeFish1Split = time[0].split(":");
    _data.timeFish2Split = time[1].split(":");
    _data.timePumpActive = _timePumpActive;
  }

  void assignData(dynamic newJson) {
    try {
      if (newJson['maxPh'] != null &&
          newJson['maxEc'] != null &&
          newJson['maxTempWater'] != null &&
          newJson['maxTempAir'] != null &&
          newJson['maxHumid'] != null &&
          newJson['maxLight'] != null &&
          newJson['minPh'] != null &&
          newJson['minEc'] != null &&
          newJson['minTempWater'] != null &&
          newJson['minTempAir'] != null &&
          newJson['minHumid'] != null &&
          newJson['minLight'] != null) {
        _data = Setting.formJson(newJson);
        _timePumpActive = _data.timePumpActive;
        _maxPh = _data.maxPh;
        _maxEc = _data.maxEc;
        _maxTempWater = _data.maxTempWater;
        _maxTempAir = _data.maxTempAir;
        _maxHumid = _data.maxHumid;
        _maxLight = _data.maxLight;
        _minPh = _data.minPh;
        _minEc = _data.minEc;
        _minTempWater = _data.minTempWater;
        _minTempAir = _data.minTempAir;
        _minHumid = _data.minHumid;
        _minLight = _data.minLight;

        final t1 = _data.timeFish1Split[0];
        final t2 = _data.timeFish1Split[1];
        final t3 = _data.timeFish2Split[0];
        final t4 = _data.timeFish2Split[1];
        if (_timeFish.length == 0) {
          _timeFish.add(TimeOfDay(hour: int.parse(t1), minute: int.parse(t2)));
          _timeFish.add(TimeOfDay(hour: int.parse(t3), minute: int.parse(t4)));
        } else {
          _timeFish[0] = TimeOfDay(hour: int.parse(t1), minute: int.parse(t2));
          _timeFish[1] = TimeOfDay(hour: int.parse(t3), minute: int.parse(t4));
        }
        notifyListeners();
      } else {
        // ====> ຖ້າບໍ່ສາມາດເອົາ data ມາຈາກ firebase ໄດ້ ຕ້ອງ fetch data ມາຈາກ LocalDB ແທນ
        fetchDataFormLocalDb();
        print(">>> Key Firebase Data Setting get Value Null !!!");
        Fluttertoast.showToast(
          msg: 'Assign Data to Setting Model Fails!!',
          timeInSecForIosWeb: 3,
        );
      }
    } catch (error) {
      print('>>>> Have Error in Assign Json Data to Model Setting <<<<<<');
      print(error);
    }
  }

  // set Max
  void setMaxPh(double newValue) {
    _maxPh = newValue;
    _data.maxPh = newValue;
    // notifyListeners();
  }

  void setMaxEc(int newValue) {
    _maxEc = newValue;
    _data.maxEc = newValue;
    // notifyListeners();
  }

  void setMaxTempWater(int newValue) {
    _maxTempWater = newValue;
    _data.maxTempWater = newValue;
    // notifyListeners();
  }

  void setMaxTempAir(int newValue) {
    _maxTempAir = newValue;
    _data.maxTempAir = newValue;
    // notifyListeners();
  }

  void setMaxHumid(int newValue) {
    _maxHumid = newValue;
    _data.maxHumid = newValue;
    // notifyListeners();
  }

  void setMaxLight(int newValue) {
    _maxLight = newValue;
    _data.maxLight = newValue;
    // notifyListeners();
  }

  // set Min
  void setMinPh(double newValue) {
    _minPh = newValue;
    _data.minPh = newValue;
    // notifyListeners();
  }

  void setMinEc(int newValue) {
    _minEc = newValue;
    _data.minEc = newValue;
    // notifyListeners();
  }

  void setMinTempWater(int newValue) {
    _minTempWater = newValue;
    _data.minTempWater = newValue;
    // notifyListeners();
  }

  void setMinTempAir(int newValue) {
    _minTempAir = newValue;
    _data.minTempAir = newValue;
    // notifyListeners();
  }

  void setMinHumid(int newValue) {
    _minHumid = newValue;
    _data.minHumid = newValue;
    // notifyListeners();
  }

  void setMinLight(int newValue) {
    _minLight = newValue;
    _data.minLight = newValue;
    // notifyListeners();
  }
}

Future<void> saveSettingToLocalDb(Setting data) async {
  await openBoxSetting();
  await pushDataSetting(data.json()).then((value) {
    print("------> Save setting to LocalDB Success");
  });
}

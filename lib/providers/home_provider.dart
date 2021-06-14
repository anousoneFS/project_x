import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../cache_data.dart';

class HomeProvider with ChangeNotifier{
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  Map<String,dynamic> _data = {};

  Map<String,dynamic> get getData => _data;

  int _togglePump  = 0;
  int _toggleServo  = 2;

  void setData(Map<String, dynamic> json) async{
   _data = {...json};
   await openBoxHome();
   await pushHome(json);
   notifyListeners();
  }

  Future<void> togglePump()async{
    try {
      if(_togglePump == 1){
        _togglePump = 0;
      }else{
        _togglePump = 1;
      }
      await _databaseReference.update({
        'arduino_streaming': _togglePump
      }).then((_) => print('togglePump Success'));
    } catch (error) {
      print('---- Have Error togglePump Arduino Streaming ----');
      print(error);
      throw error;
    }
  }

  Future<void> toggleServo()async{
    try {
      if(_toggleServo == 2){
        _toggleServo = 3;
      }else{
        _toggleServo = 2;
      }
      await _databaseReference.update({
        'arduino_streaming': _toggleServo
      }).then((_) => print('togglePump Success'));
    } catch (error) {
      print('---- Have Error toggleServo Arduino Streaming ----');
      print(error);
      throw error;
    }
  }

  Future<void> fetchDataFromLocalDb()async{
    try {
      await openBoxHome();
      final myMap = boxHome.toMap().values.toList();
      boxHome.close();
      if (myMap == null) {
        print("setting LocalDb is empty");
      } else {
        // =====> pass json data <======
        _data = {...myMap[0]};
        print('fetch data stream from Local DB success');
      }
      // notifyListeners();
    } catch (error) {
      print("--- Have Error in OpenBoxSetting ---");
      print(error);
      throw error;
    }
  }
}
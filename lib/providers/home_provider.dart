import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../cache_data.dart';

class HomeProvider with ChangeNotifier{
  Map<String,dynamic> _data = {};

  Map<String,dynamic> get getData => _data;

  void setData(Map<String, dynamic> json) async{
   _data = {...json};
   await openBoxHome();
   await pushHome(json);
   notifyListeners();
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
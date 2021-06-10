import 'package:flutter/cupertino.dart';

class MonitorProvider with ChangeNotifier{
  String _formDate = 'Form';
  String _untilDate = 'Until';
  int _indexBegin = 0;
  int _indexEnding = 10;

  String get getFormDate => _formDate;
  String get getUntilDate => _untilDate;
  int get getIndexBegin => _indexBegin;
  int get getIndexEnding => _indexEnding;

  void setFormDate(String newDate){
    _formDate = newDate;
    notifyListeners();
  }

  void setUntilDate(String newDate){
    _untilDate = newDate;
    notifyListeners();
  }

  void setIndexBegin(int newIndex){
    _indexBegin = newIndex;
    notifyListeners();
  }

  void setIndexEnding(int newIndex){
    _indexEnding = newIndex;
    notifyListeners();
  }

}
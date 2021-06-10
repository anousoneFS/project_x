import 'package:flutter/material.dart';

class Setting {
  double maxPh;
  double minPh;
  int maxEc;
  int minEc;
  int maxTempAir;
  int minTempAir;
  int maxTempWater;
  int minTempWater;
  int maxHumid;
  int minHumid;
  int maxLight;
  int minLight;
  int timePumpActive;
  List<String> timeFish1Split;
  List<String> timeFish2Split;

  Setting({
    this.timePumpActive,
    this.timeFish1Split,
    this.timeFish2Split,
    this.minPh,
    this.maxEc,
    this.minEc,
    this.maxTempAir,
    this.minTempAir,
    this.maxTempWater,
    this.minTempWater,
    this.maxHumid,
    this.minHumid,
    this.maxLight,
    this.minLight,
    this.maxPh,
  });

  Setting.formJson(Map<dynamic, dynamic> json)
      : this.timePumpActive = int.parse(json['timePumpActive'].toString()),
        this.timeFish1Split = json['timeFish1'].split(":"),
        this.timeFish2Split = json['timeFish2'].split(":"),
        this.maxPh = double.parse(json['maxPh'].toString()),
        this.maxEc = int.parse(json['maxEc'].toString()),
        this.maxTempWater = json['maxTempWater'],
        this.maxTempAir = json['maxTempAir'],
        this.maxHumid = json['maxHumid'],
        this.maxLight = json['maxLight'],
        this.minPh = double.parse(json['minPh'].toString()),
        this.minEc = int.parse(json['minEc'].toString()),
        this.minTempWater = json['minTempWater'],
        this.minTempAir = json['minTempAir'],
        this.minHumid = json['minHumid'],
        this.minLight = json['minLight'];

  dynamic json() {
    return {
      'timePumpActive': this.timePumpActive,
      'maxPh': this.maxPh,
      'maxEc': this.maxEc,
      'maxTempWater': this.maxTempWater,
      'maxTempAir': this.maxTempAir,
      'maxHumid': this.maxHumid,
      'maxLight': this.maxLight,
      'minPh': this.minPh,
      'minEc': this.minEc,
      'minTempWater': this.minTempWater,
      'minTempAir': this.minTempAir,
      'minHumid': this.minHumid,
      'minLight': this.minLight,
      'timeFish1': this.timeFish1Split == null ? "06:30" : this.timeFish1Split.join(':'),
      // ຕ້ອງ save data ໄວ້ຄືກັບຢູ່ Firebase
      'timeFish2': this.timeFish2Split == null ? "17:00" : this.timeFish2Split.join(':'),
    };
  }
}

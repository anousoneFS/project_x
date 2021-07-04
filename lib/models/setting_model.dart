import 'package:flutter/material.dart';

class Setting {
  bool isAuto;
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
    this.isAuto = false,
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
  // ຂຽນດັກໄວ້ ຫ້າມມີຄ່າ null ຖືວ່າດັກໄວ້ຫຼາຍຊັ້ນເຕີບ
      :
        this.isAuto = int.parse(json['auto'].toString()) == 1 ? true : false,
        this.timePumpActive = int.parse(json['timePumpActive'].toString()) ?? 0,
        this.timeFish1Split = json['timeFish1'].split(":") ?? ['00', '00'],
        this.timeFish2Split = json['timeFish2'].split(":") ?? ['00', '00'],
        this.maxPh = double.parse(json['maxPh'].toString()) ?? 0,
        this.maxEc = int.parse(json['maxEc'].toString()) ?? 0,
        this.maxTempWater = int.parse(json['maxTempWater'].toString()) ?? 0,
        this.maxTempAir = int.parse(json['maxTempAir'].toString()) ?? 0,
        this.maxHumid = int.parse(json['maxHumid'].toString()) ?? 0,
        this.maxLight = int.parse(json['maxLight'].toString()) ?? 0,
        this.minPh = double.parse(json['minPh'].toString()) ?? 0,
        this.minEc = int.parse(json['minEc'].toString()) ?? 0,
        this.minTempWater = int.parse(json['minTempWater'].toString()) ?? 0,
        this.minTempAir = int.parse(json['minTempAir'].toString()) ?? 0,
        this.minHumid = int.parse(json['minHumid'].toString()) ?? 0,
        this.minLight = int.parse(json['minLight'].toString()) ?? 0;

  dynamic json() {
    return {
      // ຂຽນດັກໄວ້ຖ້າມີຄ່າ null ເວລາ save ໃສ່ LocalDb ຈຶ່ງບໍ່ມີຄ່າ null
      'auto': this.isAuto ? 1 : 0,
      'timePumpActive': this.timePumpActive ?? 0,
      'maxPh': this.maxPh ?? 0,
      'maxEc': this.maxEc ?? 0,
      'maxTempWater': this.maxTempWater ?? 0,
      'maxTempAir': this.maxTempAir ?? 0,
      'maxHumid': this.maxHumid ?? 0,
      'maxLight': this.maxLight ?? 0,
      'minPh': this.minPh ?? 0,
      'minEc': this.minEc ?? 0,
      'minTempWater': this.minTempWater ?? 0,
      'minTempAir': this.minTempAir ?? 0,
      'minHumid': this.minHumid ?? 0,
      'minLight': this.minLight ?? 0,
      'timeFish1': this.timeFish1Split == null ? "00:00" : this.timeFish1Split.join(':'),
      // ຕ້ອງ save data ໄວ້ຄືກັບຢູ່ Firebase
      'timeFish2': this.timeFish2Split == null ? "00:00" : this.timeFish2Split.join(':'),
    };
  }
}


import 'package:project_x/providers/setting_provider.dart';

import '../dummy_data.dart';

Map<String, dynamic> initialDropDown(SettingProvider setting, String id, String unit){
  String valueChoose;
  List<dynamic> listItemOption;
  // assign ເພືອ່ກັນບໍ່ໃຫ້ເປັນຄ່າ null
  bool valNotify = false;
  switch(id){
    case 'timePumpActive':{
      valueChoose = setting.getPumpActive.toString();
      listItemOption = listItemTimePumpActive.keys.toList();
      // ເພື່ອເຮັດໃຫ້ປັບປ່ຽນ Unit ໄດ້ງ່າຍເວລາຂຽນ code
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxPh':{
      valueChoose = setting.getMaxPh.toString();
      listItemOption = listItemPh.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '0.0'){ // it double
        valueChoose = '0';
      }
      if(valueChoose == '-1.0'){ // because maxPh is double
        setting.setMaxPhStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMaxPhStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'minPh':{
      valueChoose = setting.getMinPh.toString();
      listItemOption = listItemPh.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '0.0'){
        valueChoose = '0';
      }
      if(valueChoose == '-1.0'){ // because minPh is double
        setting.setMinPhStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMinPhStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'maxEc':{
      valueChoose = setting.getMaxEc.toString();
      listItemOption = listItemEc.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMaxEcStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMaxEcStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'minEc':{
      valueChoose = setting.getMinEc.toString();
      listItemOption = listItemEc.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMinEcStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMinEcStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'maxTempWater':{
      valueChoose = setting.getMaxTempWater.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMaxTempWaterStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMaxTempWaterStatus(true);
        valNotify = true;
      }
      print('maxtemp water');
      print(valueChoose);
    }
    break;
    case 'minTempWater':{
      valueChoose = setting.getMinTempWater.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMinTempWaterStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMinTempWaterStatus(true);
        valNotify = true;
      }
      print('mintemp water');
      print(valueChoose);
    }
    break;
    case 'maxTempAir':{
      valueChoose = setting.getMaxTempAir.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMaxTempAirStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMaxTempAirStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'minTempAir':{
      valueChoose = setting.getMinTempAir.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMinTempAirStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMinTempAirStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'maxHumid':{
      valueChoose = setting.getMaxHumid.toString();
      listItemOption = listItemHumid.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMaxHumidStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMaxHumidStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'minHumid':{
      valueChoose = setting.getMinHumid.toString();
      listItemOption = listItemHumid.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMinHumidStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMinHumidStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'maxLight':{
      valueChoose = setting.getMaxLight.toString();
      listItemOption = listItemLight.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMaxLightStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMaxLightStatus(true);
        valNotify = true;
      }
    }
    break;
    case 'minLight':{
      valueChoose = setting.getMinLight.toString();
      listItemOption = listItemLight.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
      if(valueChoose == '-1'){
        setting.setMinLightStatus(false);
        valNotify = false;
        valueChoose = 'null';
      }else{
        setting.setMinLightStatus(true);
        valNotify = true;
      }
    }
    break;
    default:{
      // ກັນ Error ໄວ້
      valueChoose =  'null';
      listItemOption = listItemDefault.keys.toList();
      listItemOption.add('...');
      print('invalid choice initial value for Drop-Down-Widget. => may be id is wrong');
    }
    break;
  }
  return {'valueChoose': valueChoose, 'listItemOption': listItemOption, 'valNotify': valNotify};
}

// =================================================

void setValueDropDownProvider(SettingProvider setting, String id, String newValue){
  switch(id){
    case 'timePumpActive':{
      setting.setTimePumpActive(int.parse(listItemTimePumpActive[newValue].toString())); // ເອົາ key ໃສ່
    }
    break;
    case 'maxPh':{
      setting.setMaxPh(listItemPh[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'minPh':{
      setting.setMinPh(listItemPh[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'maxEc':{
      setting.setMaxEc(listItemEc[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'minEc':{
      setting.setMinEc(listItemEc[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'maxTempWater':{
      setting.setMaxTempWater(listItemTemp[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'minTempWater':{
      setting.setMinTempWater(listItemTemp[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'maxTempAir':{
      setting.setMaxTempAir(listItemTemp[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'minTempAir':{
      setting.setMinTempAir(listItemTemp[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'maxHumid':{
      setting.setMaxHumid(listItemHumid[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'minHumid':{
      setting.setMinHumid(listItemHumid[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'maxLight':{
      setting.setMaxLight(listItemLight[newValue]); // ເອົາ key ໃສ່
    }
    break;
    case 'minLight':{
      setting.setMinLight(listItemLight[newValue]); // ເອົາ key ໃສ່
    }
    break;
    default:{
      print('invalid choice update value for provider fails !!! may be id was wrong');
      print('$newValue = ${listItemDefault[newValue]}');
    }
    break;
  }
}

// =================================================

void setStatusSwitchCase(SettingProvider setting, String id, bool newValue){
  switch(id){
    // case 'timePumpActive':{
    //   setting.setTimePumpActive(int.parse(listItemTimePumpActive[newValue].toString())); // ເອົາ key ໃສ່
    // }
    // break;
    case 'maxPh':{  // ຫ້າມໃສ່ notifyListener ຫຼາຍກວ່າ 2 ອັນ
      setting.setMaxPhStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue){
        setting.setMaxPh(-1); // ເອົາ key ໃສ່
      }else{
        setting.setMaxPh(0); // ເອົາ key ໃສ່
      }
    }
    break;
    case 'minPh':{
      setting.setMinPhStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMinPh(-1); // ເອົາ key ໃສ່
      }else{
        setting.setMinPh(0); // ເອົາ key ໃສ່
      }
    }
    break;
    case 'maxEc':{
      setting.setMaxEcStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMaxEc(-1);
      } else{
        setting.setMaxEc(0);
      }
    }
    break;
    case 'minEc':{
      setting.setMinEcStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMinEc(-1);
      } else{
        setting.setMinEc(0);
      }
    }
    break;
    case 'maxTempWater':{
      setting.setMaxTempWaterStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMaxTempWater(-1);
      }else{
        setting.setMaxTempWater(0);
      }
    }
    break;
    case 'minTempWater':{
      setting.setMinTempWaterStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMinTempWater(-1);
      } else{
        setting.setMinTempWater(0);
      }
    }
    break;
    case 'maxTempAir':{
      setting.setMaxTempAirStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue){
        setting.setMaxTempAir(-1);
      } else{
        setting.setMaxTempAir(0);
      }
    }
    break;
    case 'minTempAir':{
      setting.setMinTempAirStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMinTempAir(-1);
      } else{
        setting.setMinTempAir(0);
      }
    }
    break;
    case 'maxHumid':{
      setting.setMaxHumidStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMaxHumid(-1);
      } else{
        setting.setMaxHumid(0);
      }
    }
    break;
    case 'minHumid':{
      setting.setMinHumidStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue){
        setting.setMinHumid(-1);
      } else{
        setting.setMinHumid(0);
      }
    }
    break;
    case 'maxLight':{
      setting.setMaxLightStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMaxLight(-1);
      }else{
        setting.setMaxLight(0);
      }
    }
    break;
    case 'minLight':{
      setting.setMinLightStatus(newValue); // ເອົາ key ໃສ່
      if(!newValue) {
        setting.setMinLight(-1);
      }else{
        setting.setMinLight(0);
      }
    }
    break;
    default:{
      print('set status setting provider fails!!! no case');
    }
    break;
  }
}

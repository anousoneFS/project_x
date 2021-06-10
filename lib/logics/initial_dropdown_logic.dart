
import 'package:project_x/providers/setting_provider.dart';

import '../dummy_data.dart';

List initialDropDown(SettingProvider setting, String id, String unit){
  String valueChoose;
  List<dynamic> listItemOption;
  switch(id){
    case 'timePumpActive':{
      valueChoose = setting.getPumpActive.toString();
      listItemOption = listItemTimePumpActive.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxPh':{
      valueChoose = setting.getMaxPh.toString();
      listItemOption = listItemPh.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'minPh':{
      valueChoose = setting.getMinPh.toString();
      listItemOption = listItemPh.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxEc':{
      valueChoose = setting.getMaxEc.toString();
      listItemOption = listItemEc.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'minEc':{
      valueChoose = setting.getMinEc.toString();
      listItemOption = listItemEc.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxTempWater':{
      valueChoose = setting.getMaxTempWater.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'minTempWater':{
      valueChoose = setting.getMinTempWater.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxTempAir':{
      valueChoose = setting.getMaxTempAir.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'minTempAir':{
      valueChoose = setting.getMinTempAir.toString();
      listItemOption = listItemTemp.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxHumid':{
      valueChoose = setting.getMaxHumid.toString();
      listItemOption = listItemHumid.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'minHumid':{
      valueChoose = setting.getMinHumid.toString();
      listItemOption = listItemHumid.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'maxLight':{
      valueChoose = setting.getMaxLight.toString();
      listItemOption = listItemLight.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    case 'minLight':{
      valueChoose = setting.getMinLight.toString();
      listItemOption = listItemLight.keys.toList();
      listItemOption = listItemOption.map((item) => item.toString() + unit).toList();
      listItemOption.add('...');
    }
    break;
    default:{
      // ກັນ Error ໄວ້
      valueChoose =  null;
      listItemOption = listItemDefault.keys.toList();
      listItemOption.add('...');
      print('invalid choice initial value for Drop-Down-Widget. => may be id is wrong');
    }
    break;
  }
  return [valueChoose, listItemOption];
}

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
      print('invalid choice update value for provider fails !!!');
      print('$newValue = ${listItemDefault[newValue]}');
    }
    break;
  }
}

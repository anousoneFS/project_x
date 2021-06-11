import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SensorData {
  final String time;
  final int tempAir;
  final int tempWater;
  final int ec;
  final int ph;
  final int humid;
  final int light;

  SensorData({
    this.time,
    this.tempAir,
    this.tempWater,
    this.ec,
    this.ph,
    this.humid,
    this.light,
  });

  SensorData.formList(List<dynamic> list)
      : this.time = list[0],
        this.tempAir = int.parse(list[1].toString()),
        this.humid = int.parse(list[2].toString()),
        this.ph = int.parse(list[3].toString()),
        this.ec = int.parse(list[4].toString()),
        this.light = int.parse(list[5].toString()),
        this.tempWater = 0;

  SensorData.formJson(Map<String, dynamic> json):
      this.time = json['time'] ?? '10/10/2030 08:00',
        this.tempAir = int.parse(json['temp'].toString()) ?? 0,
        this.humid = int.parse(json['humid'].toString()) ?? 0,
        this.ph = int.parse(json['ph'].toString()) ?? 0,
        this.ec = int.parse(json['ec'].toString()) ?? 0,
        this.light = int.parse(json['light'].toString()) ?? 0,
        this.tempWater = 0;
}

class SensorDataSource extends DataGridSource<SensorData> {
  SensorDataSource({List<SensorData> sensorData}) {
    _sensorData = sensorData;
  }

  List<SensorData> _sensorData;

  @override
  List<SensorData> get dataSource => _sensorData;

  @override
  Object getValue(SensorData sensor, String columnName) {
    switch (columnName) {
      case 'time':
        return sensor.time;
        break;
      case 'tempAir':
        return sensor.tempAir;
        break;
      case 'tempWater':
        return sensor.tempWater;
        break;
      case 'humid':
        return sensor.humid;
        break;
      case 'ph':
        return sensor.ph;
        break;
      case 'ec':
        return sensor.ec;
        break;
      case 'light':
        return sensor.light;
        break;
      default:
        return ' ';
        break;
    }
  }
}


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_x/models/chart_data_model.dart';
import 'package:project_x/models/sensor_data_model.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/widgets/date_range_picker_widget.dart';
import 'package:project_x/widgets/single_line_chart_widget.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  static const routeName = '/chart';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<ChartData> _phData;
    List<ChartData> _ecData;
    List<ChartData> _tempWaterData;
    List<ChartData> _tempAirData;
    List<ChartData> _humidData;
    List<ChartData> _lightData;

    final _initialData = Provider.of<FirebaseApi>(context, listen: true);
    // get ເອົາ sensor data object ໃນຕຳແໜ່ງທີສອດຄອງກັບ indexBegin ແລະ indexEnding
    final sensorDataObject = _initialData.getSubDataObj;
    if (sensorDataObject.length == 0) {
      print("==> sorry no chart data");
    } else {
      _phData = sensorDataObject
          .map((e) => ChartData(
              DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.ph))
          .toList();

      _ecData = sensorDataObject
          .map((e) => ChartData(
              DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.ec))
          .toList();

      _tempAirData = sensorDataObject
          .map((e) => ChartData(
              DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()),
              e.tempAir))
          .toList();

      _tempWaterData = sensorDataObject
          .map((e) => ChartData(
              DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()),
              e.tempWater))
          .toList();

      _humidData = sensorDataObject
          .map((e) => ChartData(
              DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.humid))
          .toList();

      _lightData = sensorDataObject
          .map((e) => ChartData(
              DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.light))
          .toList();
    }

    print('call build in chart screen');
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DateRangePickerWidget(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "ກຣາຟສະແດງຄ່າ pH",
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              SingleLineChartWidget(
                chartData: _phData,
              ),
              Text(
                "ກຣາຟສະແດງຄ່າ EC",
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              SingleLineChartWidget(
                chartData: _ecData,
              ),
              Text(
                "ກຣາຟສະແດງຄ່າ ອຸນຫະພູມຂອງນໍ້າ",
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              SingleLineChartWidget(
                chartData: _tempWaterData,
              ),
              Text(
                "ກຣາຟສະແດງຄ່າ ອຸນຫະພູມຂອງອາກາດ",
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              SingleLineChartWidget(
                chartData: _tempAirData,
              ),
              Text(
                "ກຣາຟສະແດງຄ່າ ຄວາມຊຸມອາກາດ",
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              SingleLineChartWidget(
                chartData: _humidData,
              ),
              Text(
                "ກຣາຟສະແດງຄ່າ ຄວາມເຂັ້ມຂອງແສງ",
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansLao'),
              ),
              SingleLineChartWidget(
                chartData: _lightData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

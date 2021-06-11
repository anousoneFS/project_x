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

    final _initialData = Provider.of<FirebaseApi>(context, listen: true);
    // get ເອົາ sensor data object ໃນຕຳແໜ່ງທີສອດຄອງກັບ indexBegin ແລະ indexEnding
    final sensorDataObject = _initialData.getSubDataObj;

    final List<ChartData> _phData = sensorDataObject
        .map((e) => ChartData(
            DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.ph))
        .toList();

    final List<ChartData> _ecData = sensorDataObject
        .map((e) => ChartData(
            DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.ec))
        .toList();

    final List<ChartData> _tempAirData = sensorDataObject
        .map((e) => ChartData(
            DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.tempAir))
        .toList();

    final List<ChartData> _tempWaterData = sensorDataObject
        .map((e) => ChartData(
            DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()),
            e.tempWater))
        .toList();

    final List<ChartData> _humidData = sensorDataObject
        .map((e) => ChartData(
            DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.humid))
        .toList();

    final List<ChartData> _lightData = sensorDataObject
        .map((e) => ChartData(
            DateFormat('dd-MM-yyyy HH:mm').parse(e.time.toString()), e.light))
        .toList();
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
              Text("PH Chart"),
              SingleLineChartWidget(
                chartData: _phData,
              ),
              Text("EC Chart"),
              SingleLineChartWidget(
                chartData: _ecData,
              ),
              Text("Temperature Water Chart"),
              SingleLineChartWidget(
                chartData: _tempWaterData,
              ),
              Text("Temperature Air Chart"),
              SingleLineChartWidget(
                chartData: _tempAirData,
              ),
              Text("Humid Chart"),
              SingleLineChartWidget(
                chartData: _humidData,
              ),
              Text("Light Chart"),
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

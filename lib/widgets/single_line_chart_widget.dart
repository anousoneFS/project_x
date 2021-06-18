import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_x/models/chart_data_model.dart';
import 'package:project_x/models/sensor_data_model.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SingleLineChartWidget extends StatelessWidget {
  final List<ChartData> chartData;
  SingleLineChartWidget({this.chartData});

  @override
  Widget build(BuildContext context) {
         return  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 4000,
              height: 300,
              child: SfCartesianChart(
                series: <ChartSeries>[
                  LineSeries<ChartData, DateTime>(
                    dataSource: chartData,
                    xValueMapper: (ChartData chart, _) => chart.xAxis ?? DateTime.now(),
                    yValueMapper: (ChartData chart, _) => chart.yAxis ?? 10,
                  ),
                ],
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat('dd/MM,HH:mm'),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 1,
                  name: 'our time',
                  enableAutoIntervalOnZooming: true,
                ),
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                ),
                // zoomPanBehavior: ZoomPanBehavior(
                //   enablePanning: true,
                // ),
              ),
            ),
          );
  }

}


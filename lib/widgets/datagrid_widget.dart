import 'package:flutter/material.dart';
import 'package:project_x/models/sensor_data_model.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get ເອົາຄ່າເລີ່ມຕົ້ນ indexBegin and indexEnding ແລະ listen = true
     final _initialData = Provider.of<FirebaseApi>(context, listen: true);
     // get ເອົາ sensor data object ໃນຕຳແໜ່ງທີສອດຄອງກັບ indexBegin ແລະ indexEnding
    final _data = _initialData.getSubDataObj;
    print("call build in datagrid");
    // assign sensor sub data ໃສ່ sensorDataSource ເພື່ອ get ຄ່າໃຫ້ map ຕາມ mappingName
    final _sensorDataSource = SensorDataSource(sensorData: _data);

    return Scaffold(
      body: SfDataGrid(
        source: _sensorDataSource,
        columns: <GridColumn>[
          GridTextColumn(mappingName: 'time', headerText: 'time'),
          GridNumericColumn(mappingName: 'tempAir', headerText: 'tempA'),
          GridNumericColumn(mappingName: 'tempWater', headerText: 'tempW'),
          GridNumericColumn(mappingName: 'humid', headerText: 'humid'),
          GridNumericColumn(mappingName: 'ph', headerText: 'ph'),
          GridNumericColumn(mappingName: 'ec', headerText: 'ec'),
          GridNumericColumn(mappingName: 'light', headerText: 'light'),
        ],
      ),
    );
  }
}


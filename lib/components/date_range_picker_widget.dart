import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/monitor_provider.dart';
import 'package:provider/provider.dart';
import '../components//button_widget.dart';

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTimeRange dateRange;
  List<List<dynamic>> data;
  MonitorProvider initialData;

  // List<List<String>> data = [
  //   ["08-06-2021 00:00", "29"],
  //   ["09-06-2021 00:00", "30"],
  //   ["10-06-2021 10:15", "32"],
  //   ["11-06-2021 10:30", "31"],
  //   ["12-06-2021 2:00", "28"],
  //   ["13-06-2021 4:00", "35"],
  //   ["14-06-2021 9:15", "36"],
  // ];
  //
  @override
  Widget build(BuildContext context) {
    data = Provider.of<FirebaseApi>(context).getData;
    initialData = Provider.of<MonitorProvider>(context);
    print(" ------ call build in date range ----- ");
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ButtonWidget(
                text: initialData.getFormDate,
                onClicked: () => pickDateRange(context),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Expanded(
              child: ButtonWidget(
                text: initialData.getUntilDate,
                onClicked: () => pickDateRange(context),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data
                    .sublist(
                        initialData.getIndexBegin, initialData.getIndexEnding)
                    .length ??
                0,
            itemBuilder: (ctx, index) {
              return Text(
                  "${data.sublist(initialData.getIndexBegin, initialData.getIndexEnding)[index]}");
            },
          ),
        ),
      ],
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;
    // ໂຕປ່ຽນເອົາໄປສະແດງຜົນຢູ່ from ກັບ until
    final one = newDateRange.start;
    var month = one.month.toString();
    var day = one.day.toString();
    var year = one.year.toString();
    String dateBegin = day + "-" + month + "-" + year;

    final two = newDateRange.end;
    var month2 = two.month.toString();
    // ເພີ່ມອີກ 1 ມື້ ເນືອງຈາກຊຸດຂໍ້ມູນມັນມີ Header ນຳສຳພັນກັບ date
    var day2 = (two.day + 1).toString();
    var year2 = two.year.toString();
    String dateEnd = day2 + "-" + month2 + "-" + year2;
    print(dateBegin);
    print(dateEnd);

    if (data.length <= 1) {
      print("widget.data.length <= 1");
      return;
    }

    // ເລືອກເອົາແຕ່ຂໍ້ມູນທີເປັນ Date ຢ່າງດຽວ ບໍ່ເອົາ time
    List myDate = data.sublist(1).map((e) {
      List subString = e[0].split(' ');
      return subString[0];
    }).toList();
    print(myDate);

    // ຊອກຫາ index ເລີມຕົ້ນ ແລະ ສິ້ນສຸດ ຂອງ myDate ເວລາເລືອກຊ່ວງເວລາ
    final begin = myDate.indexWhere((element) => element == dateBegin);
    final end = myDate.indexWhere((element) => element == dateEnd);
    // ຖ້າເລືອກຊວງເວລາບໍ່ຖືກຕ້ອງຈະບໍ່ດຳເນີນການຕໍ ຊອກ dateBegin ກັບ ຊອກ dateEnd ບໍ່ເຫັນ່
    if (begin == -1 || end == -1) {
      print("Wrong Range select again");
      Fluttertoast.showToast(
        msg: 'ຊ່ວງວັນເວລາທີເລືອກບໍ່ຖືກຕ້ອງ',
        timeInSecForIosWeb: 3,
      );
      return;
    } else {
      //dateEnd ຄືວັນເວລາທີເລືອກໂຕຈິງ
      month2 = two.month.toString();
      day2 = two.day.toString();
      year2 = two.year.toString();
      dateEnd = day2 + "-" + month2 + "-" + year2;
      // update ຄ່າໃນ provider
      initialData.setFormDate(dateBegin);
      initialData.setUntilDate(dateEnd);
      initialData.setIndexBegin(begin + 1);
      initialData.setIndexEnding(end + 1);
    }
  }
}

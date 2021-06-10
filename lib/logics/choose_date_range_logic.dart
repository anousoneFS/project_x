import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_x/providers/monitor_provider.dart';

Future pickDateRange(BuildContext context, List<List<dynamic>> data,
    MonitorProvider initialData) async {
  final initialDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(hours: 24 * 3)),
  );
  final newDateRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year),
    lastDate: DateTime(DateTime.now().year + 1),
    initialDateRange: initialDateRange,
  );

  if (newDateRange == null) return;

  // ໂຕປ່ຽນເອົາໄປສະແດງຜົນຢູ່ from ກັບ until
  // ເຮັດແບບນີ້ເພືອ່ແປງ 09/08/2021 => 9/8/2021 ເອົາເລກສູນທາງໜ້າອອກ
  final one = newDateRange.start;
  var month = one.month.toString();
  var day = one.day.toString();
  var year = one.year.toString();
  String dateBegin = day + "-" + month + "-" + year;

  // ເຮັດແບບນີ້ເພືອ່ແປງ 09/08/2021 => 9/8/2021 ເອົາເລກສູນທາງໜ້າອອກ
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
    day2 = two.day.toString();
    month2 = two.month.toString();
    year2 = two.year.toString();
    dateEnd = day2 + "-" + month2 + "-" + year2;
    initialData.setFormDate(dateBegin);
    initialData.setUntilDate(dateEnd);
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

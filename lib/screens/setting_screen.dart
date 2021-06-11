import 'package:flutter/material.dart';
import 'package:project_x/logics/format_time.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:project_x/widgets/dropdown_time_widget.dart';
import 'package:project_x/widgets/time_picker_widget.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = '/setting';
  SettingProvider _setting;
  TimeOfDay timeFish1;
  TimeOfDay timeFish2;
  String displayTime1;
  String displayTime2;

  Future pickTime1(BuildContext context) async {
    final initialTime = timeFish1;
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;
    // ທຸກຄັ້ງທີເລືອກເວລາຈະ update data ຢູ່ provider
    _setting.setTimeFish1(newTime);
  }

  Future pickTime2(BuildContext context) async {
    final initialTime = timeFish2;
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;
    // ທຸກຄັ້ງທີເລືອກເວລາຈະ update data ຢູ່ provider
    _setting.setTimeFish2(newTime);
  }

  @override
  Widget build(BuildContext context) {
    _setting = Provider.of<SettingProvider>(context);
    // ປ້ອງກັນໄວ້ອີກຊັ້ນໜຶ່ງ ເຖິງວ່າຈະປ້ອງກັນຢູ່ provider setting ແລ້ວກໍ່ຕາມ
    // ກັບເຖິງວ່າມັນຈະເອີ້ນໃຊ້ CircularProgressIndicator() ກໍ່ຕາມ
    if (_setting.getTimeFish.length == 0) {
      timeFish1 = TimeOfDay(hour: 0, minute: 0);
      timeFish2 = TimeOfDay(hour: 0, minute: 0);
    } else {
      timeFish1 = _setting.getTimeFish[0];
      timeFish2 = _setting.getTimeFish[1];
    }
    // ສຳຫຼັບເອົາໄປສະແດງຢູ່ ໜ້າຈໍ
    List<String> formatTime = FormatTime.displayTime([timeFish1, timeFish2]);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TimePickerWidget(
                func: pickTime1,
                time: formatTime[0],
                title: "Time Fish 1",
              ),
              TimePickerWidget(
                func: pickTime2,
                time: formatTime[1],
                title: "Time Fish 2",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ເປີດ Pump ດົນປານໃດ',
                id: 'timePumpActive',
                unit: " ນາທີ",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ PH ຫຼາຍກວ່າ',
                id: 'maxPh',
                unit: "",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ PH ໜ້ອຍກວ່າ',
                id: 'minPh',
                unit: "",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ EC ຫຼາຍກວ່າ',
                id: 'maxEc',
                unit: " ec",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ EC ໜ້ອຍກວ່າ',
                id: 'minEc',
                unit: " ec",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ Temp Water ຫຼາຍກວ່າ',
                id: 'maxTempWater',
                unit: " ອົງສາ",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ Temp Water ໜ້ອຍກວ່າ',
                id: 'minTempWater',
                unit: " ອົງສາ",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ Temp Air ຫຼາຍກວ່າ',
                id: 'maxTempAir',
                unit: " ອົງສາ",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ Temp Air ໜ້ອຍກວ່າ',
                id: 'minTempAir',
                unit: " ອົງສາ",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ Humid ຫຼາຍກວ່າ',
                id: 'maxHumid',
                unit: " %",
              ),
              SizedBox(height: 10,),
              DropDownHeaderWidget(
                title: 'ແຈ້ງເຕືອນເມືອ Humid ໜ້ອຍກວ່າ',
                id: 'minHumid',
                unit: " %",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('ກະລຸນາຢືນຢັນກ່ອນອັບເດດ Setting'),
              content: Text("ທ່ານແນ່ໃຈບໍ່ວ່າຕັ້ງຄ່າຖືກຕ້ອງແລ້ວ?"),
              actions: [
                FlatButton(
                  child: Text('ແນ່ໃຈ'),
                  onPressed: () async{
                    // set all ກ່ອນ
                    await _setting.update();
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('ຍົກເລີກ'),
                  onPressed: () {
                    print("cancel save Data Setting to Firebase by user");
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        },
        backgroundColor: Colors.red,
        child: Text("Save"),
      ),
    );
  }
}

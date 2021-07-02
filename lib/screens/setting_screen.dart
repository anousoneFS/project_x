import 'package:flutter/material.dart';
import 'package:project_x/dummy_data.dart';
import 'package:project_x/logics/format_time.dart';
import 'package:project_x/logics/pick_time_setting.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:project_x/widgets/dropdown_header_widget.dart';
import 'package:project_x/widgets/time_picker_widget.dart';
import 'package:project_x/widgets/time_pump_active_widget.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = '/setting';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingProvider settingProvider;
  TimeOfDay timeFish1;
  TimeOfDay timeFish2;
  String displayTime1;
  String displayTime2;
  bool valValueTime = false;
  bool _isExpanded = true;
  Map<String, bool> allStatus;

  void initState() {
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    super.initState();
  }

  void pickTime1Local(BuildContext context) {
    pickTime1(settingProvider, context, timeFish1);
  }

  void pickTime2Local(BuildContext context) {
    pickTime2(settingProvider, context, timeFish2);
  }

  void changeValTime(bool value) {
    setState(() {
      valValueTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("get all status in setting screen");
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black38,
              height: 1,
            ),
          ),
          LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 1.7,
                  minHeight: constraint.minHeight,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Consumer<SettingProvider>(
                      builder: (_, settingPro, ch) {
                        // ປ້ອງກັນໄວ້ອີກຊັ້ນໜຶ່ງ ເຖິງວ່າຈະປ້ອງກັນຢູ່ provider setting ແລ້ວກໍ່ຕາມ
                        // ກັບເຖິງວ່າມັນຈະເອີ້ນໃຊ້ CircularProgressIndicator() ກໍ່ຕາມ
                        if (settingPro.getTimeFish.length == 0) {
                          timeFish1 = TimeOfDay(hour: 0, minute: 0);
                          timeFish2 = TimeOfDay(hour: 0, minute: 0);
                        } else {
                          timeFish1 = settingPro.getTimeFish[0];
                          timeFish2 = settingPro.getTimeFish[1];
                        }
                        // ສຳຫຼັບເອົາໄປສະແດງຢູ່ ໜ້າຈໍ
                        List<String> formatTime =
                            FormatTime.displayTime([timeFish1, timeFish2]);
                        print("call consumer");
                        return Column(
                          children: [
                            TimePickerWidget(
                              func: pickTime1Local,
                              time: formatTime[0],
                              title: "ໃຫ້ອາຫານປາຄັ້ງທີ 1",
                              rightPadding: 5,
                              leftPadding: 15,
                            ),
                            TimePickerWidget(
                              func: pickTime2Local,
                              time: formatTime[1],
                              title: "ໃຫ້ອາຫານປາຄັ້ງທີ 2",
                              rightPadding: 5,
                              leftPadding: 15,
                            ),
                            TimePumpActiveWidget(
                              title: 'ໄລຍະເວລາທີ່ປໍ້ານໍ້າເປີດ',
                              id: 'timePumpActive',
                              unit: ' ນາທີ',
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    notifyExpand(), // ຕັ້ງຄ່າການແຈ້ງເຕືອນ
                    SizedBox(
                      height: 10,
                    ),
                    _isExpanded
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 0),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: notifyInfo.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == notifyInfo.length) {
                                    print("hi =================");
                                    return Column(
                                      children: [
                                        Divider(
                                          height: 15,
                                          thickness: 1,
                                          color: Colors.black26,
                                        ),
                                        Container(
                                          height: 80,
                                        ),
                                      ],
                                    );
                                  }
                                  return DropDownHeaderWidget(
                                    title: notifyInfo[index]['title'],
                                    id: notifyInfo[index]['id'],
                                    unit: notifyInfo[index]['unit'],
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await showDialog<Null>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('ກະລຸນາຢືນຢັນກ່ອນອັບເດດ Setting'),
                  content: Text("ທ່ານແນ່ໃຈບໍ່ວ່າຕັ້ງຄ່າຖືກຕ້ອງແລ້ວ?"),
                  actions: [
                    FlatButton(
                      child: Text('ແນ່ໃຈ'),
                      onPressed: () async {
                        // set all ກ່ອນ
                        await settingProvider.update();
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
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(
                child: Text(
                  "ບັນທຶກ",
                  style: TextStyle(
                    fontFamily: "NotoSansLao",
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget notifyExpand() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ຕັ້ງຄ່າການແຈ້ງເຕືອນ',
            style: TextStyle(fontSize: 25, fontFamily: 'NotoSansLao'),
          ),
          SizedBox(
            width: 10,
          ),
          _isExpanded
              ? Icon(
                  Icons.expand_more,
                  size: 35,
                  color: Colors.blue,
                )
              : Icon(
                  Icons.expand_less,
                  size: 35,
                  color: Colors.blue,
                ),
        ],
      ),
    );
  }
}

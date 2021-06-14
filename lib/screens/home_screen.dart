import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/home_provider.dart';
import 'package:project_x/widgets/header_card_number_widget.dart';
import 'package:project_x/widgets/status_widget.dart';
import 'package:project_x/widgets/stream_data_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  final FirebaseApp app;

  HomeScreen({this.app});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference _streamData;
  HomeProvider homeProvider;
  bool valSwitchPump = false;
  bool valSwitchServo = false;

  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _streamData = database.reference().child('data_sensor_from_arduino');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final firebaseProvider = Provider.of<FirebaseApi>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        firebaseProvider.getConnectionStatus != 'Unknown'
            ? FirebaseAnimatedList(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                query: _streamData,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  String body = snapshot.value; // ຂໍ້ມູນທີ່ໄດ້ຈາກ Arduino ພຽວໆ
                  List<dynamic> bodySplit = body.split(','); // split ,
                  List<String> title = [
                    'ເວລາ',
                    'ອຸນຫະພູມອາກາດ',
                    'ຄວາມຊຸມ',
                    'ຄ່າ PH',
                    'ຄ່າ EC',
                    'ອຸນຫະພູມນໍ້າ',
                    'ຄ່າແສງ'
                  ];
                  Map<String, dynamic> json = {};
                  for (var i = 0; i < title.length; i++) {
                    json.putIfAbsent('${title[i]}', () => bodySplit[i]);
                  }
                  homeProvider.setData(json);
                  print('*** call homeProvider.setData');
                  return StreamCardWidget(json: json);
                },
              )
            : StreamCardWidget(
                json: Provider.of<HomeProvider>(context).getData),
        SizedBox(
          height: 200,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ເປີດ-ປິດ Pump", style: TextStyle(fontSize: 24, fontFamily: 'NotoSansLao'),),
                CupertinoSwitch(
                  value: valSwitchPump,
                  onChanged: (bool newValue) async {
                    await homeProvider.togglePump();
                    setState(() {
                      print(newValue);
                      valSwitchPump = newValue;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ໃຫ້ອາຫານປາ", style: TextStyle(fontSize: 24, fontFamily: 'NotoSansLao'),),
                CupertinoSwitch(
                  value: valSwitchServo,
                  onChanged: (bool newValue) async {
                    await homeProvider.toggleServo();
                    setState(() {
                      print(newValue);
                      valSwitchServo = newValue;
                    });
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
// HeadCardNumberWidget(
// title: 'ອຸນຫະພູມນໍ້າ',
// number: '33 C',
// ),

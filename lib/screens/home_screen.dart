import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
                  return StreamCardWidget(json:json);
                },
              )
            : StreamCardWidget(json:Provider.of<HomeProvider>(context).getData),
        SizedBox(
          height: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StatusWidget(
              title: 'ສະຖານະປໍ້ານໍ້າ',
              action: 'ເປີດ',
            ),
            StatusWidget(
              title: 'ສະຖານະເຄື່ອງໃຫ້ອາຫານປາ',
              action: 'ປິດ',
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "ເປີດປໍ້ານໍ້າ",
                  style: TextStyle(fontSize: 25, fontFamily: 'NotoSansLao'),
                )),
            TextButton(
                onPressed: () {},
                child: Text("ເປີດເຄື່ອງໃຫ້ອາຫານປາ",
                    style: TextStyle(fontSize: 25, fontFamily: 'NotoSansLao'))),
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

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/home_provider.dart';
import 'package:project_x/style/color_theme.dart';
import 'package:project_x/widgets/control_widget.dart';
import 'package:project_x/widgets/sensor_value_streaming_widget.dart';
import 'package:project_x/widgets/stream_data_widget.dart';
import 'package:provider/provider.dart';

import 'widget/firebase_stream_data_animatelist.dart';
import 'widget/multi_control_widget.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  final FirebaseApp app;

  HomeScreen({this.app});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference _streamData;
  DatabaseReference _getSetting;
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _streamData = database.reference().child('data_sensor_from_arduino');
    _getSetting = database.reference().child('setting');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const LineBottomAppBar(),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              const TitleWidget(title: 'ສະພາບແວດລ້ອມໃນໂຮງເຮືອນ'),
              SizedBox(
                height: 10,
              ),
              // firebaseProvider.getConnectionStatus != 'Unknown' ?
              FirebaseStreamData(
                stream: _streamData,
                setDataMethod: "stream_sensor",
              ),
              Consumer<HomeProvider>(
                builder: (_, data, ch) {
                  return data.getData.values.length != 0
                      ? SensorValueStreamingWidget(json: data.getData)
                      // : CircularProgressIndicator();
                  : Text("No Data");
                  // return SensorValueStreamingWidget(json: data.getData);
                },
              ),
              SizedBox(
                height: 10,
              ),
              const TitleWidget(title: 'ປຸ່ມຄວບຄຸມ'),
              SizedBox(
                height: 10,
              ),
              MultiControlWidget(),
              SizedBox(height: 110),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    print("call title");
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 25),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "NotoSansLao",
        ),
      ),
    );
  }
}

class LineBottomAppBar extends StatelessWidget {
  const LineBottomAppBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("call line appbar");
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child:  Card(
        elevation: 4,
        margin: EdgeInsets.all(0),
        child: Divider(
          height: 1,
          color: Colors.black38,
        ),
      ),
    );
  }
}



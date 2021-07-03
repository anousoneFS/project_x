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
  bool valSwitchAuto = false;
  Map<String, dynamic> json = {};
  bool _isLoading = false;

  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _streamData = database.reference().child('data_sensor_from_arduino');
    super.initState();
  }

  Future<void> controlPump(newValue) async {
    await homeProvider.togglePump();
    setState(() {
      print(newValue);
      valSwitchPump = newValue;
    });
  }

  Future<void> controlServo(newValue) async {
    await homeProvider.toggleServo();
    setState(() {
      print(newValue);
      valSwitchServo = newValue;
    });
  }

  Future<void> controlAuto(newValue) async {
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
              setState(() {
                _isLoading = true;
              });
              await homeProvider.toggleAuto();
              Navigator.of(context).pop();
              setState(() {
                _isLoading = false;
              });
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
    setState(() {
      print(newValue);
      valSwitchAuto = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final firebaseProvider = Provider.of<FirebaseApi>(context);
    return !_isLoading
        ? Stack(
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
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 25),
                      child: Text(
                        "ສະພາບແວດລ້ອມໃນໂຮງເຮືອນ",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: "NotoSansLao",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // firebaseProvider.getConnectionStatus != 'Unknown' ?
                    FirebaseAnimatedList(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      query: _streamData,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        String body =
                            snapshot.value; // ຂໍ້ມູນທີ່ໄດ້ຈາກ Arduino ພຽວໆ
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
                        json = {};
                        for (var i = 0; i < title.length; i++) {
                          json.putIfAbsent('${title[i]}', () => bodySplit[i]);
                        }
                        homeProvider.setData(json);
                        print('*** call homeProvider.setData');
                        return Container();
                      },
                    ),
                    Consumer<HomeProvider>(
                      builder: (_, data, ch) {
                        print('call consumer');
                        return data.getData.values.length != 0
                            ? SensorValueStreamingWidget(json: data.getData)
                            : CircularProgressIndicator();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 25),
                      child: Text(
                        "ປຸ່ມ ຄວບຄຸມ",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: "NotoSansLao",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildSwitchControlWithHeaderWidget(
                          size,
                          'ເປີດ-ປິດ ປໍ້ານໍ້າ',
                          controlPump,
                          valSwitchPump,
                          'assets/icons/pump.svg',
                          GFTheme.lightBlue,
                        ),
                        SizedBox(height: 10),
                        buildSwitchControlWithHeaderWidget(
                          size,
                          'ໃຫ້ອາຫານປາ',
                          controlServo,
                          valSwitchServo,
                          'assets/icons/fish.svg',
                          GFTheme.lightBlue,
                        ),
                        SizedBox(height: 10),
                        buildSwitchControlWithHeaderWidget(
                          size,
                          'ເປີດ-ປິດ ອໍໂຕ້',
                          controlAuto,
                          valSwitchAuto,
                          'assets/icons/machine-learning.svg',
                          GFTheme.lightPeach,
                        ),
                      ],
                    ),
                    SizedBox(height: 110),
                  ],
                ),
              ),
            ],
          )
        : CircularProgressIndicator();
  }

  Widget buildSwitchControlWithHeaderWidget(
      Size size, String title, Function func, bool valueOnOff, String image, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: 40,
              ),
              Spacer(),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontFamily: 'NotoSansLao'),
              ),
              Spacer(),
              Container(
                width: size.width * 0.1,
                child: CupertinoSwitch(
                  activeColor: Colors.red,
                  trackColor: Colors.blueAccent,
                  value: valueOnOff,
                  onChanged: func,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// HeadCardNumberWidget(
// title: 'ອຸນຫະພູມນໍ້າ',
// number: '33 C',
// ),

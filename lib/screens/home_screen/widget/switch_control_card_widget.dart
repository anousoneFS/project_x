import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_x/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SwitchControlCardWidget extends StatefulWidget {
  const SwitchControlCardWidget({
    @required this.title,
    @required this.valueOnOff,
    @required this.image,
    @required this.color,
    @required this.methodId,
  });

  final String title;
  final bool valueOnOff;
  final String image;
  final Color color;
  final String methodId;

  @override
  _SwitchControlCardWidgetState createState() => _SwitchControlCardWidgetState();
}

class _SwitchControlCardWidgetState extends State<SwitchControlCardWidget> {
  HomeProvider homeProvider;
  bool valSwitch;

  void initState() {
    valSwitch = widget.valueOnOff;
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    super.initState();
  }

  void selectMethod(newValue) {
    switch (widget.methodId) {
      case 'auto':
        controlAuto(newValue);
        break;
      case 'pump':
        controlPump(newValue);
        break;
      case 'servo':
        controlServo(newValue);
        break;
      default:
        print("not found");
    }
  }

  Future<void> controlPump(newValue) async {
    await homeProvider.togglePump();
    setState(() {
      print(newValue);
      valSwitch = newValue;
    });
  }

  Future<void> controlServo(newValue) async {
    await homeProvider.toggleServo();
    setState(() {
      print(newValue);
      valSwitch = newValue;
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
              await homeProvider.toggleAuto(newValue);
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
    setState(() {
      valSwitch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("call control widget");
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
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
                widget.image,
                height: 40,
              ),
              Spacer(),
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontFamily: 'NotoSansLao'),
              ),
              Spacer(),
              Container(
                width: size.width * 0.1,
                child: CupertinoSwitch(
                  activeColor: Colors.red,
                  trackColor: Colors.blueAccent,
                  value: valSwitch ?? false,
                  onChanged: selectMethod,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

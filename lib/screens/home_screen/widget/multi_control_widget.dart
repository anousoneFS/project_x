import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:project_x/screens/home_screen/widget/switch_control_card_widget.dart';
import 'package:project_x/style/color_theme.dart';
import 'package:provider/provider.dart';

class MultiControlWidget extends StatefulWidget {
  @override
  State<MultiControlWidget> createState() => _MultiControlWidgetState();
}

class _MultiControlWidgetState extends State<MultiControlWidget> {
  bool valSwitchPump = false;
  bool valSwitchServo = false;
  bool valSwitchAuto;

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    valSwitchAuto = Provider.of<SettingProvider>(context, listen: false).getAutoValue;
    print('valSwitchAuto = ${valSwitchAuto}');
    print("=====> call multi control");
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SwitchControlCardWidget(
          methodId: 'pump',
          title: 'ເປີດ-ປິດ ປໍ້ານໍ້າ',
          valueOnOff: valSwitchPump,
          image: 'assets/icons/pump.svg',
          color: GFTheme.lightBlue,
        ),
        SizedBox(height: 10),
        SwitchControlCardWidget(
          methodId: 'servo',
          title: 'ໃຫ້ອາຫານປາ',
          valueOnOff: valSwitchServo,
          image: 'assets/icons/fish.svg',
          color: GFTheme.lightBlue,
        ),
        SizedBox(height: 10),
        SwitchControlCardWidget(
          methodId: 'auto',
          title: 'ເປີດ-ປິດ ອໍໂຕ້',
          valueOnOff: valSwitchAuto,
          image: 'assets/icons/machine-learning.svg',
          color: GFTheme.lightPeach,
        ),
      ],
    );
  }
}


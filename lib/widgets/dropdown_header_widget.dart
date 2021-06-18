import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x/logics/initial_dropdown_logic.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:provider/provider.dart';

class DropDownWidget extends StatefulWidget {
  final String valueChoose;
  final String unit;
  final List<dynamic> listItemOption;
  final SettingProvider settingProvider;
  final String id;
  final bool ignoreVal;
  final String title;

  DropDownWidget({
    @required this.unit,
    @required this.valueChoose,
    @required this.listItemOption,
    @required this.settingProvider,
    @required this.id,
    @required this.ignoreVal,
    this.title,
  });

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String valueChooseLocal;
  bool ignoreValue;

  void initState() {
    valueChooseLocal = widget.valueChoose;
    ignoreValue = widget.ignoreVal;
    super.initState();
  }
  void onChangeDropDown(dynamic newValue){
    // ໃຊ້ setState ເພາະຖ້າໃຊ້ notifyListener ຂອງ provider ມັນຈະແຈ້ງເຕືອນໄປທຸກອັ້ນ ທຸກຄັ້ງທີ set ຄ່າ
    // split 30 ອົງສາ = [30, ອົງສາ] => 30 ເອົາແຕ່ໂຕທາງໜ້າ ເພາະບໍ່ຊັ້ນມັນຈະເປັນ 30 ອົງສາ ອົງສາ
    List<String> newValueList = newValue.toString().split(' ');

    // ຖາ້ id ບໍ່ຖືກຕ້ອງ ຈະໄດ້ XXX
    if (newValueList[0] == 'XXX') {
      print("newValueList index 0 == XXX !!!!");
      setValueDropDownProvider(
          widget.settingProvider, widget.id, 'null der jao');
    } else {
      // update value in provider
      setValueDropDownProvider(
          widget.settingProvider, widget.id, newValueList[0]);
    }

    if (widget.unit == '' && newValueList[0] == 'XXX') {
      setState(() {
        valueChooseLocal = newValue;
      });
    } else {
      setState(() {
        valueChooseLocal = newValueList[0];
      });
    }
    print('call on change drop-down');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<SettingProvider>(
      builder: (_, data, ch) {
        final settingProvider =
        Provider.of<SettingProvider>(context, listen: false);
        Map<String, dynamic> initialList =
            initialDropDown(settingProvider, widget.id, widget.unit);
        return IgnorePointer(
          ignoring: !initialList['valNotify'],
          // how to get val value in each item
          child: ch,
        );
      },
      child: Row(
        children: [
          Container(
            width: size.width * 0.5,
            height: size.height * 0.055,
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'NotoSansLao',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.only(left: 10, right: 0),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            width: size.width * 0.25,
            height: size.height * 0.06,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: DropdownButton(
                value: valueChooseLocal == 'null'
                    ? '...'
                    : valueChooseLocal + widget.unit,
                items: widget.listItemOption
                    .map(
                      (item) => DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      ),
                    )
                    .toList(),
                onChanged: (newValue) => onChangeDropDown(newValue),   // call this when selected
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                // iconSize: 36,
                isExpanded: false,
                elevation: 5,
                style: TextStyle(
                  color: Colors.black,
                  // fontSize: 18,
                  fontFamily: "NotoSansLao",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownHeaderWidget extends StatefulWidget {
  final String title;
  final String id;
  final String unit;


  DropDownHeaderWidget({
    @required this.title,
    @required this.id,
    @required this.unit,
  });

  @override
  _DropDownHeaderWidgetState createState() => _DropDownHeaderWidgetState();
}

class _DropDownHeaderWidgetState extends State<DropDownHeaderWidget> {
  bool _isFirst = true;
  bool valNotify;
  String valueChoose;
  List<dynamic> listItemOption;
  SettingProvider settingProvider;
  void didChangeDependencies() {
    print("call didChange header out-side");
    if (_isFirst) {
      print("call didChange header Drop-Down<<<<");
      try {
        settingProvider = Provider.of<SettingProvider>(context, listen: false);
        // ດຶງເອົາຄ່າເລີມຕົ້ນມາໃຊ້
        Map<String, dynamic> initialList =
            initialDropDown(settingProvider, widget.id, widget.unit);
        // ====> assign ຄ່າເລີມຕົ້ນ
        valueChoose = initialList['valueChoose'];
        listItemOption = initialList['listItemOption'];
        valNotify = initialList['valNotify'];
        // sleep(Duration(milliseconds: 500)); // delay 500 milliseconds
      } catch (error) {
        print('Have Error on didChange initial dropdown');
        print(error);
      }
    }
    _isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print('call build header drop-down');
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        children: [
          Divider(
            height: 15,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropDownWidget(
                  // setState ມັນ call build ຢູ່ ແຕ່ບໍ່ທັງໝົດ
                  ignoreVal: !valNotify,
                  valueChoose: valueChoose,
                  unit: widget.unit,
                  listItemOption: listItemOption,
                  id: widget.id,
                  settingProvider: settingProvider,
                  title: widget.title,
                ),
                Spacer(),
                Container(
                  width: size.width * 0.18,
                  height: size.height * 0.055,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: CupertinoSwitch(
                      value: valNotify ?? false,
                      onChanged: (bool newValue) {
                        setState(() {
                          // ອັບເດດ status value in setting provider ເພື່ອໃຫ້ເວລາຍ້ອນກັບມາຂໍ້ມູນຍັງຄືເກົ່າ
                          setStatusSwitchCase(settingProvider, widget.id, newValue);
                          valNotify = newValue;
                          print("set state in header");
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

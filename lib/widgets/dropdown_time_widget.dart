import 'package:flutter/material.dart';
import 'package:project_x/logics/initial_dropdown_logic.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';

class DropDownWidget extends StatefulWidget {
  final String id;
  final String unit;

  DropDownWidget({@required this.id, @required this.unit});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  SettingProvider _setting;
  String valueChoose;
  List<dynamic> listItemOption;
  bool _isFirst = true;

  void initState() {
    super.initState();
    print("call initState >>>>>>>");
  }

  void didChangeDependencies() {
    print("call didChange <<<<");
    if (_isFirst) {
      try {
        _setting = Provider.of<SettingProvider>(context, listen: false);
        List<dynamic> initialList = initialDropDown(
            _setting, widget.id, widget.unit);
        valueChoose = initialList[0];
        listItemOption = initialList[1];
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
    print('....... call build for ${widget.id}');
    print("... valueChoose = $valueChoose");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton(
        value: valueChoose == 'null' ? '...' : valueChoose + widget.unit,
        items: listItemOption.map(
              (item) =>
              DropdownMenuItem(
                child: Text(item),
                value: item,
              ),
        )
            .toList(),
        onChanged: (newValue) {
          // ໃຊ້ setState ເພາະຖ້າໃຊ້ notifyListener ຂອງ provider ມັນຈະແຈ້ງເຕືອນໄປທຸກອັ້ນ ທຸກຄັ້ງທີ set ຄ່າ
          // split 30 ອົງສາ = [30, ອົງສາ] => 30 ເອົາແຕ່ໂຕທາງໜ້າ ເພາະບໍ່ຊັ້ນມັນຈະເປັນ 30 ອົງສາ ອົງສາ
          List<String> newValueList = newValue.toString().split(' ');
          print(newValueList);
          // ຖາ້ id ບໍ່ຖືກຕ້ອງ
          if (newValueList[0] == 'XXX') {
            print("newValueList index 0 == XXX !!!!");
            setValueDropDownProvider(_setting, widget.id, 'null der jao');
          } else {
            // update value in provider
            setValueDropDownProvider(_setting, widget.id, newValueList[0]);
          }

          if(widget.unit == '' && newValueList[0] == 'XXX'){
            setState(() {
              valueChoose = newValue;
            });
          }else{
            setState(() {
              valueChoose = newValueList[0];
            });
          }
        },
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 36,
        isExpanded: false,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "NotoSansLao",
        ),
      ),
    );
  }
}

class DropDownHeaderWidget extends StatelessWidget {
  final String title;
  final String id;
  final String unit;

  DropDownHeaderWidget(
      {@required this.title, @required this.id, @required this.unit});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Row(
      children: [
        Container(
          width: size.width * .55,
          child: FittedBox(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 24, color: Colors.black, fontFamily: 'NotoSansLao'),
            ),
          ),
        ),
        Spacer(),
        DropDownWidget(id: id, unit: unit,),
      ],
    );
  }
}

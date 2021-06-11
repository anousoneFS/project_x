import 'package:flutter/material.dart';
import 'package:project_x/widgets/header_card_number_widget.dart';
import 'package:project_x/widgets/status_widget.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              HeadCardNumberWidget(
                title: 'ອຸນຫະພູມນໍ້າ',
                number: '33 C',
              ),
              HeadCardNumberWidget(
                title: 'ອຸນຫະພູມອາກາດ',
                number: '35 C',
              ),
              HeadCardNumberWidget(
                title: 'ຄ່າ Ph',
                number: '3.5',
              ),
              HeadCardNumberWidget(
                title: 'ຄ່າ EC',
                number: '2.3',
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeadCardNumberWidget(
              title: 'ຄ່າແສງ',
              number: '1530 Lux',
            ),
            HeadCardNumberWidget(
              title: 'ຄວາມຊຸມອາກາດ',
              number: '70 %',
            ),
          ],
        ),
        SizedBox(height: 15,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StatusWidget(title: 'ສະຖານະປໍ້ານໍ້າ',action: 'ເປີດ',),
            StatusWidget(title: 'ສະຖານະເຄື່ອງໃຫ້ອາຫານປາ',action: 'ປິດ',),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){}, child: Text("ເປີດປໍ້ານໍ້າ", style: TextStyle(fontSize: 25, fontFamily: 'NotoSansLao'),)),
            TextButton(onPressed: (){}, child: Text("ເປີດເຄື່ອງໃຫ້ອາຫານປາ", style: TextStyle(fontSize: 25, fontFamily: 'NotoSansLao'))),
          ],
        )
      ],
    );
  }
}

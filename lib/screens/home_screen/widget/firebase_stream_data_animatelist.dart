import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:project_x/providers/home_provider.dart';
import 'package:provider/provider.dart';

class FirebaseStreamData extends StatelessWidget {
  final DatabaseReference stream;
  final String setDataMethod;

  const FirebaseStreamData({@required this.stream, @required this.setDataMethod,});
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // if(_isFirst){
    //   setState(() {
    //     n++;
    //   });
    //   if(n > 3){
    //     n = 0;
    //     _isFirst = false;
    //   }
    // }
    return FirebaseAnimatedList(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      query: stream,
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
        Map<String, dynamic> json_data = {};
        for (var i = 0; i < title.length; i++) {
          json_data.putIfAbsent('${title[i]}', () => bodySplit[i]);
        }
        switch (setDataMethod) {
          case 'stream_sensor':
            Future.delayed(Duration.zero, () async {
              await homeProvider.setData(json_data);
            });
            break;
          case 'stream_control':
          // homeProvider.setData(json_data);
            print("case stream control");
            break;
          default:
            print("no case");
        }
        print('*** call homeProvider.setData');
        return Container();
      },
    );
  }
}

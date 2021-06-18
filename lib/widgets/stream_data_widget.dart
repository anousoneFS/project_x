import 'package:flutter/material.dart';

class StreamCardWidget extends StatelessWidget {
  final Map<String, dynamic> json;

  StreamCardWidget({this.json});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      // color: Colors.black12,
      child: GridView.builder(
          // physics: ClampingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: json.values != null ? json.values.length - 1 : 0,
          // ບໍ່ເອົາ ເວລາ
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  json.keys.toList()[index + 1] != null
                      ? Text(
                          '${json.keys.toList()[index + 1]}',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'NotoSansLao'),
                        )
                      : Text("title"),
                  json.values.toList()[index + 1] != null
                      ? Text(
                          '${json.values.toList()[index + 1] ?? 0}',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontFamily: 'RobotoCondensed'),
                        )
                      : Text('null'),
                ],
              ),
            );
          }),
    );
  }
}

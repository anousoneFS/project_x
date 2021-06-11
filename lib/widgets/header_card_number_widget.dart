import 'package:flutter/material.dart';

class HeadCardNumberWidget extends StatelessWidget {
  final String title;
  final String number;
  HeadCardNumberWidget({this.title, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      // color: Colors.lightBlueAccent,
      child: Column(
        children: [
          Text(
            "$title",
            style: TextStyle(
              fontFamily: 'NotoSansLao',
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 80,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(
              "$number",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

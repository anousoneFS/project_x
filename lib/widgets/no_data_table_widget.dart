import 'package:flutter/material.dart';

Widget noDataTableWidget(List<List<dynamic>> data) => Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          data[0][0],
          style: TextStyle(fontSize: 20),
        ),
        Text(
          data[0][1],
          style: TextStyle(fontSize: 20),
        ),
        Text(
          data[0][2],
          style: TextStyle(fontSize: 20),
        ),
        Text(
          data[0][3],
          style: TextStyle(fontSize: 20),
        ),
        Text(
          data[0][4],
          style: TextStyle(fontSize: 20),
        ),
        Text(
          data[0][5],
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
    SizedBox(
      height: 50,
    ),
    Align(
      alignment: Alignment.center,
      child: Text(
        "ບໍ່ມີຂໍ້ມູນ",
        style: TextStyle(fontSize: 30, fontFamily: 'NotoSansLao'),
      ),
    ),
  ],
);

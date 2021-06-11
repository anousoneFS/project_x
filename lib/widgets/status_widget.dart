import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String title;
  final String action;

  StatusWidget({this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        Text(
          ' : ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text(
          "$action",
          style: TextStyle(
            fontFamily: 'NotoSansLao',
            fontSize: 20,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ],
    );
  }
}

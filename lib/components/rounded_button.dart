import '../style/constant.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.title,
    this.func,
  }) : super(key: key);
  final String title;
  final Function func;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: func,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'NotoSansLao',
          ),
        ),
      ),
    );
  }
}

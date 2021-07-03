import 'package:flutter/material.dart';

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key key,
    @required this.title,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: title,
        child: ButtonWidget(
          text: text,
          onClicked: onClicked,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style:
            // ElevatedButton.styleFrom(
            //   minimumSize: Size.fromHeight(40),
            //   primary: Colors.white,
            ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.blue, width: 1),
            ),
          ),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        onPressed: onClicked,
      );
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.5,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontFamily: "NotoSansLao",
            ),
          ),
        ),
        // const SizedBox(width: 8),
        child,
        const SizedBox(width: 2),
        Container(child: Icon(Icons.expand_less)),
      ],
    );
  }
}

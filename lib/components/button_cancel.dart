import 'package:flutter/material.dart';
import 'package:project_x/style/constant.dart';

class ButtonCancel extends StatelessWidget {
  final bool isLogin;
  final Duration animationDuration;
  final AnimationController animationController;
  final GestureTapCallback tagEvent;

  ButtonCancel({
    this.isLogin,
    this.animationController,
    this.animationDuration,
    this.tagEvent,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          height: size.height * 0.1,
          alignment: Alignment.bottomCenter,
          child: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: tagEvent,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

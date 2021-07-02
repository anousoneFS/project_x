import 'package:flutter/material.dart';

import 'animated_switch.dart';

class ControlWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        print("tap...");
      },
      child: Container(
        height: size.width * 0.414,
        width: size.width * 0.4,
        margin: EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.width * 0.06,
                width: size.width * 0.34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.withOpacity(0.45)),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.width * 0.4,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 15,
                      left: size.width * 0.032,
                      child: Image(
                        image: AssetImage("assets/icons/temperature.png"),
                        fit: BoxFit.fill,
                        height: size.width * 0.16,
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 15,
                      child: AnimatedSwitch(
                        // isToggled: controller.isToggled,
                        // index: index,
                        // onTap: () {
                        //   controller.onSwitched(index);
                        // },
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      left: 18,
                      child: Text(
                        "anousone",
                        style: TextStyle(color:Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

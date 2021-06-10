import 'package:flutter/material.dart';

class TestTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
     width: size.width,
      height: size.height,
      color: Colors.lightBlueAccent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ໃຊ້ເຕັມທີ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Header"),
                Text("Header"),
                Text("Header"),
                Text("Header"),
              ],
            ),
            SizedBox(height: 10,),
            Text("Body"),
            Container(
              height: 1000,
              width: 100,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

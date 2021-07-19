import '../otp_component/body.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("ຢັ້ງຢືນລະຫັດ OTP", style: TextStyle(fontFamily: 'NotoSansLao'),),
      ),
      body: Body(
      ),
    );
  }
}
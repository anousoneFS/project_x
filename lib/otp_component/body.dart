import 'package:email_auth/email_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/constant.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'otp_form.dart';
import '../models/user.dart' as Model;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Model.User user = Model.User();

  Future<void> sendOtp() async{
    print("sending otp code to");
   print(user.email);
    EmailAuth.sessionName = 'smart-farm-app';
    var statusOtp = await EmailAuth.sendOtp(receiverMail: user.email);
    if (statusOtp) {
      Fluttertoast.showToast(
        msg: 'Send OTP Code Success',
        timeInSecForIosWeb: 2,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Send OTP Fail',
        timeInSecForIosWeb: 2,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to +1 898 860 ***"),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: TextButton(
                  child: Text("Resend OTP Code"),
                  onPressed: sendOtp,
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}

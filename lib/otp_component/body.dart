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

  Future<void> sendOtp() async {
    print("sending otp code to");
    print(user.email);
    EmailAuth.sessionName = 'CEIT-FARM-APP';
    var statusOtp = await EmailAuth.sendOtp(receiverMail: user.email);
    if (statusOtp) {
      Fluttertoast.showToast(
        msg: 'ສົ່ງລະຫັດ OTP ສຳເລັດ',
        timeInSecForIosWeb: 2,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'ສົ່ງລະຫັດ OTP ບໍ່ສຳເລັດ',
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
                "ກວດສອບລະຫັດ OTP",
                style: headingStyle,
              ),
              Text(
                "ລະບົບໄດ້ສົ່ງລະຫັດ OTP ໃຫ້ແລ້ວ \n ໃຫ້ທ່ານກວດສອບລະຫັດ OTP ຢູ່ Email ຂອງທ່ານ \n ແລ້ວປ້ອນລະຫັດທີໄດ້ໃນຊອງລຸ່ມນີ້",
                style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: TextButton(
                  child: Text(
                    "ສົ່ງລະຫັດ OTP ຊຸດໃໝ່",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'NotoSansLao',
                    ),
                  ),
                  onPressed: sendOtp,
                ),
              ),
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
        Text(
          "ລະຫັດ OTP ນັບຖອຍຫຼັງ ",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'NotoSanslao',
          ),
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

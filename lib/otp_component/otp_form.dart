import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/tab_screen.dart';
import '../models/user.dart' as Model;
import '../screens/home_screen/home_screen.dart';
import '../style/constant.dart';
import '../size_config.dart';
import '../utils.dart';
import 'default_button.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  Model.User user = Model.User();
  String otpText = '';
  FToast fToast;
  Widget myToast = customToast;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      otpText += value;
      focusNode.requestFocus();
    }
  }

  void verify() async {
    print(otpText);
    var statusVerify = EmailAuth.validate(
      receiverMail: user.email,
      userOTP: otpText,
    );
    if (statusVerify) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        )
            .then((value) {
          fToast.showToast(
            child: myToast,
            gravity: ToastGravity.CENTER,
            toastDuration: Duration(seconds: 3),
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
              TabsScreen.routeName, (Route<dynamic> route) => false);
        });
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'ກະລຸນາປ້ອນລະຫັດຜ່ານ 6 ໂຕຂຶ້ນໄປ';
        } else if (e.code == 'email-already-in-use') {
          message = 'Email ໄດ້ຖືກນຳໃຊ້ແລ້ວ';
        } else {
          message = e.message;
        }
        Fluttertoast.showToast(
          msg: message,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
        );
      }
    } else {
      print('otp fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    autofocus: true,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin3FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin4FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin5FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin5FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin6FocusNode),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: TextFormField(
                    focusNode: pin6FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        otpText += value;
                        pin6FocusNode.unfocus();
                        // Then you need to check is the code is correct or not
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: verify,
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_x/components/rounded_button.dart';
import 'package:project_x/screens/login_screen.dart';
import '../components/rounded_input.dart';
import '../style/constant.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = '/reset_password';
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // let add some decoration
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedInput(
                    icon: Icons.email,
                    hint: " ຊື່ Email",
                    textType: TextInputType.emailAddress,
                    textController: emailController,
                    validator: [
                      EmailValidator(
                        errorText: "ຮູບແບບ Email ບໍ່ຖືກຕ້ອງ",
                      ),
                      RequiredValidator(
                        errorText: "ກະລຸນາປ້ອນ Email ໃສ່",
                      )
                    ],
                  ),
                  RoundedButton(
                    title: "ສົ່ງຄຳຮ້ອງຂໍ",
                    func: () {
                      auth.sendPasswordResetEmail(email: emailController.text);
                      Fluttertoast.showToast(
                        msg: 'ກະລຸນາເຊັກ Email',
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                      );
                      print("begin");
                      sleep(Duration(seconds: 3));
                      print("end");
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 5,),
                        Text(
                          "ກັບໄປໜ້າ LogIn",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NotoSansLao',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

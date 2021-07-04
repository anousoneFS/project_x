import 'package:email_auth/email_auth.dart';
import '../components/rounded_input.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/otp_screen.dart';
import '../models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../utils.dart';
import 'rounded_button.dart';
import 'rounded_password_input.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({
    Key key,
    @required this.isLogin,
    @required this.animationDuration,
    @required this.size,
    @required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final model.User user = model.User();
  FToast fToast;
  var waiting = false;

  Widget myToast = customToast;

  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

   void sendOtp() async {
    if(_formKey.currentState.validate()){
      // _formKey.currentState.save();
      user.name = nameController.text;
      user.email = emailController.text;
      user.password = pwdController.text;
    EmailAuth.sessionName = 'smart-farm-app';
    setState(() {
      waiting = true;
    });

    if(confirmPwdController.text == pwdController.text){
      var statusOtp = await EmailAuth.sendOtp(receiverMail: emailController.text);
      if (statusOtp) {
        Fluttertoast.showToast(
          msg: 'Send OTP Success',
          timeInSecForIosWeb: 2,
        );
        Navigator.of(context).pushNamed(OtpScreen.routeName, arguments: user);
      } else {
        Fluttertoast.showToast(
          msg: 'send otp fail',
          timeInSecForIosWeb: 2,
        );
      }
    }else{
      Fluttertoast.showToast(
        msg: 'Password Don\'t Match',
        timeInSecForIosWeb: 2,
      );
    }
    waiting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 5,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: widget.size.width,
              height: widget.defaultLoginSize,
              child: FutureBuilder(
                future: firebase,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SvgPicture.asset(
                            'assets/icons/smart-farm.svg',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RoundedInput(
                            icon: Icons.email,
                            hint: "Email",
                            textController: emailController,
                            validator: [
                              RequiredValidator(errorText: "ກະລຸນາປ້ອນ Email"),
                              EmailValidator(
                                  errorText: "ຮູບແບບ Email ບໍ່ຖືກຕ້ອງ"),
                            ],
                          ),
                          RoundedPasswordInput(
                            icon: Icons.lock,
                            hint: "Password",
                            textController: pwdController,
                          ),
                          RoundedPasswordInput(
                            icon: Icons.lock,
                            hint: "Confirm Password",
                            textController: confirmPwdController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RoundedButton(title: "SIGN UP", func: sendOtp),
                          SizedBox(height: 20,),
                          waiting ? CircularProgressIndicator() : Container(),
                        ],
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

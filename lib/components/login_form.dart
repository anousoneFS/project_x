import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_x/screens/nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input.dart';
import '../components/rounded_password_input.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/reset_password_screen.dart';
import '../screens/tab_screen.dart';
import '../models/user.dart' as Model;

class LoginForm extends StatefulWidget {
  const LoginForm({
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
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Model.User user = Model.User();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  void submit() async {
    if (_formKey.currentState.validate()) {
      user.email = emailController.text;
      user.password = pwdController.text;
      print(user.email);
      print(user.password);

      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
        )
            .then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', user.email);
          _formKey.currentState.reset();
          Fluttertoast.showToast(
            msg: 'ຍິນດີຕ້ອນຮັບເຂົ້າສູ່ລະບົບ',
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
          );
          Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: e.code,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
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
                  return Center(child: Text('Error'));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "ຍິນດີຕ້ອນຮັບ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'NotoSansLao',
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
                          hint: "ໃສ່ຊື່ Email",
                          textType: TextInputType.emailAddress,
                          textController: emailController,
                          validator: [
                            EmailValidator(
                                errorText: "ຮູບແບບ Email ບໍ່ຖືກຕ້ອງ"),
                            RequiredValidator(errorText: "ກະລຸນາປ້ອນ Email ໃສ່")
                          ],
                        ),
                        RoundedPasswordInput(
                          icon: Icons.lock,
                          hint: "ລະຫັດຜ່ານ",
                          textController: pwdController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RoundedButton(
                          title: "ເຂົ້າສູ່ລະບົບ",
                          func: submit,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ResetPasswordScreen.routeName);
                          },
                          child: Text(
                            "ລືມລະຫັດຜ່ານ?",
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 18,
                            ),
                          ),
                        ),
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
    );
  }
}

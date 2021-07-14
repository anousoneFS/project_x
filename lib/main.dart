import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/home_provider.dart';
import 'package:project_x/providers/monitor_provider.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:project_x/screens/chart_screen.dart';
import 'package:project_x/screens/home_screen/home_screen.dart';
import 'package:project_x/screens/login_screen.dart';
import 'package:project_x/screens/monitor_screen.dart';
import 'package:project_x/screens/nav_screen.dart';
import 'package:project_x/screens/otp_screen.dart';
import 'package:project_x/screens/reset_password_screen.dart';
import 'package:project_x/screens/setting_screen.dart';
import 'package:project_x/screens/tab_screen.dart';
import 'package:project_x/screens/tab_screen2.dart';
import 'package:project_x/screens/table_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email');
  await Firebase.initializeApp().then((value) {
    print("<< firebase initialize app success >>");
  });
  runApp(MyApp(
    email: email,
  ));
}

class MyApp extends StatelessWidget {
  final String email;

  MyApp({this.email});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FirebaseApi(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => MonitorProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SettingProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: Colors.black,
          ),
          home: email == null ? LogInScreen() : NavScreen(),
          // home: TabsScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            OtpScreen.routeName: (ctx) => OtpScreen(),
            LogInScreen.routeName: (ctx) => LogInScreen(),
            ResetPasswordScreen.routeName:(ctx) => ResetPasswordScreen(),
            MonitorScreen.routeName: (ctx) => MonitorScreen(),
            // TabsScreen.routeName: (ctx) => TabsScreen(),
            NavScreen.routeName: (ctx) => NavScreen(),
            SettingScreen.routeName: (ctx) => SettingScreen(),
            TableScreen.routeName: (ctx) => TableScreen(),
            ChartScreen.routeName: (ctx) => ChartScreen(),
          }),
    );
  }
}

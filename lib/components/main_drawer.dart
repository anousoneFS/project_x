import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_x/screens/chat_bot_screen/chat_bot_screen.dart';
import 'package:project_x/screens/login_screen.dart';
import 'package:project_x/screens/nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/tab_screen.dart';

class MainDrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  Widget buildListTile(String title, IconData icon, Function tapHandle) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'NotoSansLao',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandle,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                "CEIT-FARM",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          buildListTile(
            'ໜ້າຫຼັກ',
            Icons.home,
            () {
              Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
            },
          ),
          buildListTile(
            'ລະບົບແຈ້ງເຕືອນ',
            Icons.chat,
            () {
              Navigator.of(context).pushNamed(ChatBotScreen.routeName);
            },
          ),
          buildListTile(
            'ອອກຈາກແອັບ',
            Icons.logout,
            () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              auth.signOut().then(
                    (value) => Navigator.of(context).pushReplacementNamed(
                      LogInScreen.routeName,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

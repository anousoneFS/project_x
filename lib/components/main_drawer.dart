import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_x/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/tab_screen.dart';

class MainDrawer extends StatelessWidget {
  final  auth = FirebaseAuth.instance;

  Widget buildListTile(String title, IconData icon, Function tapHandle) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensd',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandle,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                "Lettuce",
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
            'Home',
            Icons.restaurant,
                () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          ),
          buildListTile(
            'Add Line ChatBot',
            Icons.chat,
                () {
            },
          ),
          buildListTile(
            'Log Out',
            Icons.logout,
                () async{
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

import 'package:flutter/material.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/screens/table_screen.dart';
import 'package:provider/provider.dart';

class MonitorScreen extends StatelessWidget {
  static String routeName = "/monitor";

  void saveData(BuildContext ctx) {
    Future.delayed(Duration.zero).then((value) {
      try {
        Provider.of<FirebaseApi>(ctx, listen: false).saveData();
      } catch (error) {
        print("--- Have Error saveData in MonitorScreen ---");
        print(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * 0.085,
          elevation: 4,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.table_chart),
                text: 'Data Table',
              ),
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Chart',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TableScreen(),
            Center(child: Text("chart")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => saveData(context),
          backgroundColor: Colors.blue,
          child: FittedBox(
            child: Icon(
              Icons.download_rounded,
              size: 45,
            ),
          ),
        ),
      ),
    );
  }
}

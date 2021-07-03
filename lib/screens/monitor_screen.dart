import 'package:flutter/material.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/screens/chart_screen.dart';
import 'package:project_x/screens/table_screen.dart';
import 'package:provider/provider.dart';

class MonitorScreen extends StatefulWidget {
  static String routeName = "/monitor";

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            // toolbarHeight: size.height * 0.06,
            elevation: 4,
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Tab(
                      icon: Icon(
                        Icons.table_chart,
                        color: Colors.blue,
                      ),
                      // text: 'Data Table',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Tab(
                      icon: Icon(Icons.stacked_line_chart, color: Colors.blue),
                      // text: 'Chart',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                TableScreen(),
                ChartScreen(),
              ],
            ),
            Positioned(
              bottom: 55,
              right: 15,
              child: ExpandFloatingActionButton(),
            ),
          ],
        ),
        // ສຳຫຼັບປຸ່ມ Download ຂໍ້ມູນ ໃສ່ ໂທລະສັບ

        // floatingActionButton: ExpandFloatingActionButton(),
      ),
    );
  }
}

class ExpandFloatingActionButton extends StatefulWidget {
  @override
  State<ExpandFloatingActionButton> createState() =>
      _ExpandFloatingActionButtonState();
}

class _ExpandFloatingActionButtonState
    extends State<ExpandFloatingActionButton> {
  bool _isExpand = false;

  void toggleExpanded() {
    if (_isExpand)
      _isExpand = false;
    else
      _isExpand = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_isExpand) MultiFloatingActionButtonWidget(),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                setState(() {
                  toggleExpanded();
                });
              },
              icon: _isExpand
                  ? Icon(
                      Icons.expand_less,
                      color: Colors.blue,
                      size: 55,
                    )
                  : Icon(
                      Icons.expand_more,
                      color: Colors.blue,
                      size: 55,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiFloatingActionButtonWidget extends StatelessWidget {
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

  void reverseData(BuildContext ctx) {
    Future.delayed(Duration.zero).then((value) {
      try {
        Provider.of<FirebaseApi>(ctx, listen: false).reversData();
      } catch (error) {
        print("--- Have Error reverseData in MonitorScreen ---");
        print(error);
      }
    });
  }

  Future<void> showAlertDialog(BuildContext context) async {
    await showDialog<Null>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ກະລຸນາຢືນຢັນກ່ອນທຳການດາວໂຫລດຂໍ້ມູນ'),
        content: Text("ທ່ານຕ້ອງການ Save ຂໍ້ມູນລົງເຄື່ອງແທ້ບໍ່?"),
        actions: [
          FlatButton(
            child: Text('ແມ່ນແລ້ວ'),
            onPressed: () {
              saveData(context);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('ຍົກເລີກ'),
            onPressed: () {
              print("cancel save Data to local by user");
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("call build multi floating");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () => reverseData(context),
          backgroundColor: Colors.blue,
          child: FittedBox(
            child: Transform.rotate(
              angle: -1.6,
              child: Icon(
                Icons.compare_arrows_outlined,
                size: 45,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          onPressed: () async {
            await showAlertDialog(context);
          },
          backgroundColor: Colors.blue,
          child: FittedBox(
            child: Icon(
              Icons.download_rounded,
              size: 45,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

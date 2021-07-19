import 'package:flutter/material.dart';
import 'package:project_x/components/main_drawer.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/screens/chart_screen.dart';
import 'package:project_x/screens/table_screen.dart';
import 'package:provider/provider.dart';

class MonitorScreen extends StatefulWidget {
  static String routeName = "/monitor";

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                "ຂໍ້ມູນຈາກເຊັນເຊີ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontFamily: 'NotoSansLao',
                ),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: Colors.white,
              elevation: 4,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(
                    // text: "Table",
                    icon: Icon(
                      Icons.table_chart,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  Tab(
                    // text: "Chart",
                    icon: Icon(
                      Icons.stacked_line_chart,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
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

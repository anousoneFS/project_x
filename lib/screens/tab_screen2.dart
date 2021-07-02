import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/home_provider.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:project_x/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/main_drawer.dart';
import '../screens/home_screen.dart';
import '../screens/monitor_screen.dart';
import 'package:connectivity/connectivity.dart';

class TabsScreen2 extends StatefulWidget {
  @override
  _TabsScreen2State createState() => _TabsScreen2State();
}

class _TabsScreen2State extends State<TabsScreen2> {
  @override
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  final auth = FirebaseAuth.instance;
  bool loading = false;
  bool _isFirst = true;

  String _connectionStatus = '';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _pages = [
      {
        "page": HomeScreen(),
        "title": "Home",
      },
      {
        "page": MonitorScreen(),
        "title": "Monitoring",
      },
      {
        "page": SettingScreen(),
        "title": "Auto Setting",
      },
    ];
    super.initState();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void didChangeDependencies() {
    print('--- Call didChangeDependencies on TabsScreen ----');
    browse();
    super.didChangeDependencies();
  }

  Future<void> browse() async {
    if (_isFirst) {
      try {
        setState(() {
          loading = true;
        });
        await Provider.of<FirebaseApi>(context, listen: false).fetchData();
        // ຖ້າມີ Error ຄຳສັ່ງຕໍ່ໄປຈະບໍ່ຖືກເອີ້ນໃຊ້ຈະເອີ້ນໃຊ້ catch ເລີຍ
        print("=== > if connected the next function was call");
        await Provider.of<SettingProvider>(context, listen: false)
            .fetchData()
            .then((_) {
          Provider.of<FirebaseApi>(context, listen: false)
              .setConnectionStatus('');
        });
      } catch (error) {
        print("---- Have Error fetchData on Tab Screen---");
        // await Provider.of<FirebaseApi>(context, listen: false).fetchDataFormLocalDb();
        // await Provider.of<SettingProvider>(context, listen: false).fetchDataFormLocalDb();
        // print(error);
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
    _isFirst = false;
  }

  void _selectPages(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    print("portraitMode in mainScreen....");
  }

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.blue,),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: size.height * 0.04,
            child: FittedBox(
              child: Text(_pages[_selectedPageIndex]['title'],
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        drawer: MainDrawer(),
        // ເຊັກ loading ກັບ connection ຖ້າ loading = true ແລະ connection != unknown
        // ສະແດງວ່າກຳລັງໂຫລດຂໍ້ມູນຢູ່ ໃຫ້ສະແດງ CircularProgressIndicator()
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: [
              loading && _connectionStatus != 'Unknown'
                  ? Center(child: CircularProgressIndicator())
                  : _pages[_selectedPageIndex]['page'],
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).primaryColor,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                        width: 1,
                        color: Colors.black38,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.home,
                            size: _selectedPageIndex == 0 ? 35 : 26,
                            color: _selectedPageIndex == 0
                                ? Colors.blue
                                : Colors.black38,
                          ),
                          onPressed: () {
                            _selectPages(0);
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.monitor,
                            size: _selectedPageIndex == 1 ? 35 : 26,
                            color: _selectedPageIndex == 1
                                ? Colors.blue
                                : Colors.black38,
                          ),
                          onPressed: () {
                            _selectPages(1);
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.settings,
                            size: _selectedPageIndex == 2 ? 35 : 26,
                            color: _selectedPageIndex == 2
                                ? Colors.blue
                                : Colors.black38,
                          ),
                          onPressed: () {
                            _selectPages(2);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        print('==> connect wifi');
        setState(() => _connectionStatus = 'wifi');
        break;
      case ConnectivityResult.mobile:
        print('==> wifi mobile');
        setState(() => _connectionStatus = 'Mobile');
        break;
      case ConnectivityResult.none:
        print('==> internet Unknown');
        setState(() => _connectionStatus = 'Unknown');
        Provider.of<FirebaseApi>(context, listen: false)
            .setConnectionStatus(_connectionStatus);
        Fluttertoast.showToast(
          msg: 'Connection Failed!',
          timeInSecForIosWeb: 3,
        );
        print('fetch data from Local DB in case Unknown');
        await Provider.of<HomeProvider>(context, listen: false)
            .fetchDataFromLocalDb();
        await Provider.of<FirebaseApi>(context, listen: false)
            .fetchDataFormLocalDb();
        await Provider.of<SettingProvider>(context, listen: false)
            .fetchDataFormLocalDb();
        break;
      default:
        print('==> connectivity failed');
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
    print('@@@ ===> connectionStatus = $_connectionStatus');
    // ເພືອ່ແຈ້ງອັບເດດຄ່າຢູ່ homeScreen
    Provider.of<FirebaseApi>(context, listen: false)
        .setConnectionStatus(_connectionStatus);
  }
}

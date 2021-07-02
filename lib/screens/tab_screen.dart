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
import '../components/main_drawer.dart';
import '../screens/home_screen.dart';
import '../screens/monitor_screen.dart';
import 'package:connectivity/connectivity.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs_screen';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: size.height * 0.04,
          child: FittedBox(
            child: Text(_pages[_selectedPageIndex]['title']),
          ),
        ),
        elevation: 0,
      ),
      drawer: MainDrawer(),
      // ເຊັກ loading ກັບ connection ຖ້າ loading = true ແລະ connection != unknown
      // ສະແດງວ່າກຳລັງໂຫລດຂໍ້ມູນຢູ່ ໃຫ້ສະແດງ CircularProgressIndicator()
      body: loading && _connectionStatus != 'Unknown'
          ? Center(child: CircularProgressIndicator())
          : _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5,),
          child: Container(
            // height: size.height * 0.07,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                selectedFontSize: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Theme.of(context).primaryColor,
                // backgroundColor: Colors.black,
                onTap: _selectPages,
                unselectedItemColor: Colors.white,
                selectedItemColor: Theme.of(context).accentColor,
                currentIndex: _selectedPageIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Container(
                      height: size.height * 0.045,
                      // color: Colors.red,
                      child: FittedBox(
                        child: Icon(Icons.home),
                      ),
                    ),
                    // title: Container(
                    //   height: size.height * 0.028,
                    //   child: FittedBox(
                    //     child: Text("Home"),
                    //   ),
                    // ),
                    title: Text("home"),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Container(
                      height: size.height * 0.045,
                      child: FittedBox(
                        child: Icon(Icons.monitor),
                      ),
                    ),
                    // title: Container(
                    //   height: size.height * 0.028,
                    //   child: FittedBox(
                    //     child: Text("Monitoring"),
                    //   ),
                    // ),
                    title: Text("monitoring"),
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Container(
                      height: size.height * 0.045,
                      child: FittedBox(
                        child: Icon(Icons.settings),
                      ),
                    ),
                    // title: Container(
                    //   height: size.height * 0.028,
                    //   child: FittedBox(
                    //     child: Text("Setting"),
                    //   ),
                    // ),
                    title: Text("setting"),
                  ),
                ],
              ),
            ),
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

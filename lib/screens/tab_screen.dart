import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_x/providers/firebase_api.dart';
import 'package:project_x/providers/setting_provider.dart';
import 'package:project_x/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../screens/home_screen.dart';
import '../screens/monitor_screen.dart';
import 'login_screen.dart';

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

  void initState()  {
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FirebaseApi>(context, listen: false).fetchData();
    // });

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

  Future<void> browse()async{
    if(_isFirst){
      try{
        setState(() {
          loading = true;
        });
        await Provider.of<FirebaseApi>(context, listen: false).fetchData();
        // ຖ້າມີ Error ຄຳສັ່ງຕໍ່ໄປຈະບໍ່ຖືກເອີ້ນໃຊ້ຈະເອີ້ນໃຊ້ catch ເລີຍ
        print("=== > if connected the next function was call");
        await Provider.of<SettingProvider>(context, listen: false).fetchData();
      }catch(error){
        print("---- Have Error fetchData on Tab Screen---");
        await Provider.of<FirebaseApi>(context, listen: false).fetchDataFormLocalDb();
        await Provider.of<SettingProvider>(context, listen: false).fetchDataFormLocalDb();
        // print(error);
      }finally{
        setState(() {
          loading = false;
        });
      }
    }
    _isFirst = false;
  }

  void didChangeDependencies(){
    print('--- Call didChangeDependencies on TabsScreen ----');
    browse();
    super.didChangeDependencies();
  }

  void _selectPages(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        elevation: 0,
      ),
      drawer: MainDrawer(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectPages,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.monitor),
            title: Text("Monitoring"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.settings),
            title: Text("Setting"),
          ),
        ],
      ),
    );
  }
}

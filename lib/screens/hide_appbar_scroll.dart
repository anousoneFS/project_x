import 'package:flutter/material.dart';
import 'package:project_x/components/main_drawer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HideAppbarScroll extends StatefulWidget {
  @override
  State<HideAppbarScroll> createState() => _HideAppbarScrollState();
}

class _HideAppbarScrollState extends State<HideAppbarScroll>
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
              title: Text("Monitoring",
                  style: TextStyle(color: Colors.black, fontSize: 26)),
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
                      size: 40,
                    ),
                  ),
                  Tab(
                    // text: "Chart",
                    icon: Icon(
                      Icons.stacked_line_chart,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            Tab1(),
            Tab2(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("hi"),
    );
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("this is tab 2"),
    );
  }
}

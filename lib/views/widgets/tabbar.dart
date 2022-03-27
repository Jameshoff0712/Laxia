import 'package:flutter/material.dart';


class TabBarWidget extends StatefulWidget {
  final TabController tabController;
  final List<String>  tabMenus;
const TabBarWidget({ Key? key, required this.tabMenus,required this.tabController }) : super(key: key);
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  // @override
  // void initState() {
  //   setState(() {
  //     _tabController = new TabController(length: 8, vsync: this);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              padding: EdgeInsets.only(left: 9, top: 0, right: 16, bottom: 3),
              labelPadding: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 8),
              labelColor: Color.fromARGB(255, 18, 18, 18),
              unselectedLabelColor: Color.fromARGB(255, 156, 161, 161),
              indicatorColor: Color.fromARGB(255, 110, 198, 210),
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: -1, left: 4, right: 4),              
              isScrollable: true,
              onTap: (value){
              },
              tabs: [
                for (final tabMenu in widget.tabMenus) 
                  _buildTab(tabMenu),
              ],
              controller: widget.tabController,
            ),
          ],
        ),
    );
  }
}
Tab _buildTab(String tabMenu) {
  return Tab(
    height: 18,
    child: Text(
      tabMenu,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
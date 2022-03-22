import 'package:flutter/material.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:laxia/views/widgets/tabbar.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  const HomeScreen({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    final List<String> tabMenus = [
    'ホーム',
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 8, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String searchtext="";
    TextEditingController filter=new TextEditingController();
    return Container(
      child:Column(children: [
        SizedBox(height:44),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: SearchbarWidget(searchtext:searchtext ,state:true,filter: filter,),
        ),
        TabBarWidget(tabMenus:tabMenus,tabController: _tabController,),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
            controller:_tabController,
          ),
        ),
      ],)
    );
  }
}

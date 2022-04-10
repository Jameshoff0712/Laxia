import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/appointment/appointment.dart';
import 'package:laxia/views/pages/main/favorite/favorite.dart';
import 'package:laxia/views/pages/main/home/home.dart';
import 'package:laxia/views/widgets/bottom_nav_widget.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = HomeScreen();
  DashboardScreen({Key? key, this.currentTab}) {
    currentTab = 0;
  }

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // int? _currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _currentIndex = widget.currentTab as int;
  }

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(initialPage: 0);
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor:Helper.whiteColor,
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) => {userProperties.setCurrentPageIndex(value)},
        children: const [
          HomeScreen(),
          Appointment(),
          SizedBox(width: 20,),
          FavoriteScreen(),
          Mypage(),
        ],
      ),
      bottomNavigationBar: BottomNav(
          currentIndex: userProperties.currentPageIndex,
          pageController: _pageController),
    );
  }
}

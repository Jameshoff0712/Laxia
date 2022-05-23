import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/models/m_settings.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:laxia/views/widgets/contribution_selector.dart';

class BottomNav extends StatefulWidget {
  final PageController pageController;
  final int currentIndex;

  const BottomNav({
    Key? key,
    required this.currentIndex,
    required this.pageController,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _selectedItemColor = Helper.mainColor;
  final _unselectedItemColor = Helper.darkGrey;
  final _selectedBgColor = Helper.mainColor;
  final _unselectedBgColor = Colors.transparent;
  final _whiteColor = Helper.whiteColor;

  @override
  void initState() {
    super.initState();
  }

  Color _getBgColor(int index) {
    if (index == 2) {
      return _selectedBgColor;
    } else {
      return widget.currentIndex == index
          ? _unselectedBgColor
          : _unselectedBgColor;
    }
  }

  Color _getItemColor(int index) {
    if (index == 2) {
      return _whiteColor;
    } else {
      return widget.currentIndex == index
          ? _selectedItemColor
          : _unselectedItemColor;
    }
  }

  Widget _buildIcon(BuildContext context, String iconData, int index,
          {int badge = 0}) =>
      Container(
        width: MediaQuery.of(context).size.width,
        height: kBottomNavigationBarHeight * 0.6,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Container(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: iconData == "post.svg"
                            ? SvgPicture.asset(
                                "assets/icons/bottombar/" + iconData,
                                fit: BoxFit.cover,
                                width: 24,
                                height: 24,
                              )
                            : SvgPicture.asset(
                                "assets/icons/bottombar/" + iconData,
                                fit: BoxFit.cover,
                                width: 24,
                                height: 24,
                                color: _getItemColor(index),
                              ),
                      ),
                      badge != 0
                          ? Positioned(
                              right: -12.0,
                              top: -12.0,
                              child: Container(
                                height: 20,
                                width: 20,
                                constraints: new BoxConstraints(
                                    maxHeight: 40.0, maxWidth: 40.0),
                                decoration: new BoxDecoration(
                                  color: Helper.notifyBadgeBgColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: badge < 10
                                      ? Text(
                                          "$badge",
                                          style: defaultTextStyle(
                                              Helper.notifyBadgeTxtColor,
                                              FontWeight.w500,
                                              size: 12),
                                        )
                                      : Text(
                                          "9+",
                                          style: defaultTextStyle(
                                            Helper.notifyBadgeTxtColor,
                                            FontWeight.w500,
                                            size: 12,
                                          ),
                                        ),
                                ),
                              ),
                            )
                          : Container(
                              child: SizedBox.shrink(),
                            ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 24.0,
      currentIndex: userProperties.currentPageIndex,
      selectedLabelStyle: TextStyle(color: Helper.mainColor),
      selectedItemColor: Helper.mainColor,
      items: [
        BottomNavigationBarItem(
            icon: _buildIcon(context, "home.svg", 0),
            label: Trans.of(context).home_page),
        BottomNavigationBarItem(
            icon: _buildIcon(context, "reserve.svg", 1),
            label: Trans.of(context).appointment_page),
        BottomNavigationBarItem(
            icon: _buildIcon(context, "post.svg", 7), label: "作成"),
        BottomNavigationBarItem(
            icon: _buildIcon(context, "heart.svg", 3),
            label: Trans.of(context).favorite_page),
        BottomNavigationBarItem(
            icon: _buildIcon(context, "user.svg", 4),
            label: Trans.of(context).my_page)
      ],
      onTap: (value) {
        if (value == 2) {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
              ),
              context: context,
              builder: (context) {
                return ModalBottomSheet();
              });
        } else {
          userProperties.setSearchtext("");
          userProperties.setCurrentPageIndex(value);
          widget.pageController.animateToPage(value,
              duration: const Duration(microseconds: 300),
              curve: Curves.easeIn);
        }
      },
    );
  }
}

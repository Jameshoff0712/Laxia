import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/home/home_search_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/pages/main/home/home.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:provider/provider.dart';

class SearchResultAll extends StatefulWidget {
  final TabController tabController;
  const SearchResultAll(
      {Key? key, required this.tabController})
      : super(key: key);

  @override
  State<SearchResultAll> createState() => _SearchResultAllState();
}

class _SearchResultAllState extends State<SearchResultAll> {
  bool isloading=true,isfirst=true;
  final _con = HomeController();
  late Home_Search_Model home_search;
  Future<void> getData(String searchtext) async {
    try {
      final mid = await _con.getHomeSearch(q: searchtext, perpage: 4.toString());
      setState(() {
         home_search = mid;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  final List<String> tabMenus = [
    'メニュー',
    'クリニック',
    'ドクター',
    // '日記',
    // '症例',
    // 'カウセレポ',
    // '質問',
  ];
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    if(isfirst){
          getData(userProperties.searchtext);
          setState(() {
            isfirst=false;
          });
    }
    return isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    :((home_search.clinics.isNotEmpty||home_search.menus.isNotEmpty||home_search.doctors.isNotEmpty)?Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(250, 240, 242, 245),
      ),
      child: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    home_search.menus.isEmpty?Container():Container(
                      decoration: BoxDecoration(color: Helper.whiteColor),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Helper.whiteColor),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tabMenus[0],
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 51, 51, 51),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.tabController.animateTo(1);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "もっと見る",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 156, 161, 161),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Icon(
                                              Icons.navigate_next,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 156, 161, 161),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  itemCount: home_search.menus.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Menu_Card(
                                        onpress: () {
                                          //Navigator.of(context).pushNamed("/Menu_Detail");
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => Menu_Detail(
                                                      index:
                                                          home_search.menus[index].id)));
                                        },
                                        image: home_search.menus[index].images!.isEmpty
                                            ? "http://error.png"
                                            : home_search.menus[index].images![0].path,
                                        heading:
                                            home_search.menus[index].description == null
                                                ? ""
                                                : home_search.menus[index].description!,
                                        price: home_search.menus[index].price == 0
                                            ? ""
                                            : home_search.menus[index].price!.toString(),
                                        clinic: home_search.menus[index].clinic == null ? '' : home_search.menus[index].clinic!.name!);
                                  }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    home_search.menus.isEmpty?Container():SizedBox(
                      height: 10,
                    ),
                    home_search.clinics.isEmpty?Container():Container(
                      decoration: BoxDecoration(color: Helper.whiteColor),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tabMenus[1],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.tabController.animateTo(2);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "もっと見る",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 156, 161, 161),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 156, 161, 161),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4),
                            itemCount: home_search.clinics.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Clinic_Card(
                                  onpress: () {
                                    // print("object");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Clinic_Detail(
                                                    index: home_search.clinics[index].id)));
                                  },
                                  image:
                                      home_search.clinics[index].photo == null
                                          ? "http://error.png"
                                          : home_search.clinics[index].photo!,
                                  post: "",
                                  name: home_search.clinics[index].name==null?"":home_search.clinics[index].name!,
                                  mark: home_search.clinics[index].avg_rate ==
                                          null
                                      ? ""
                                      : home_search.clinics[index].diaries_count
                                          .toString(),
                                  day: home_search.clinics[index].diaries_count ==
                                          null
                                      ? ""
                                      : home_search.clinics[index].diaries_count
                                          .toString(),
                                  location: (home_search.clinics[index].addr01 ==
                                              null
                                          ? ""
                                          : home_search.clinics[index].addr01!) +
                                      " " +
                                      (home_search.clinics[index].addr02 == null
                                          ? ""
                                          : home_search.clinics[index].addr02!));
                            }),
                        ],
                      ),
                    ),
                    home_search.clinics.isEmpty?Container():SizedBox(
                      height: 10,
                    ),
                    home_search.doctors.isEmpty?Container():Container(
                      decoration: BoxDecoration(color: Helper.whiteColor),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tabMenus[2],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.tabController.animateTo(3);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "もっと見る",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 156, 161, 161),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 156, 161, 161),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: home_search.doctors.length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Doctor_Card(
                                    onpress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Doctor_Detail(
                                                      index: home_search.doctors[index].id)));
                                      // Navigator.of(context).pushNamed("/Doctor_Detail");
                                    },
                                    image: home_search.doctors[index].photo == null
                                        ? "http://error.png"
                                        : home_search.doctors[index].photo!,
                                    name: home_search.doctors[index].hira_name,
                                    mark: home_search.doctors[index].avg_rate.toString(), //home_search.doctors[index]["mark"],
                                    day: home_search.doctors[index].views_count
                                        .toString(), //home_search.doctors[index]["day"],
                                    clinic:
                                        "湘南美容クリニック 新宿院" //home_search.doctors[index].clinic_id .toString()
                                    );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ]),
    )
    : Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            SvgPicture.asset(
              "assets/images/LAXIA.svg",
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '検索結果がありません',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                fontWeight: FontWeight.w700,
                color: Helper.txtColor,
              ),
            )
          ],
        ),
      )
    );
  }
}

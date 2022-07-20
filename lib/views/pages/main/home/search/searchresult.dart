import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/question_card.dart';

class SearchResultAll extends StatefulWidget {
  final TabController tabController;
  final List model;
  const SearchResultAll(
      {Key? key, required this.model, required this.tabController})
      : super(key: key);

  @override
  State<SearchResultAll> createState() => _SearchResultAllState();
}

class _SearchResultAllState extends State<SearchResultAll> {
  final List<String> tabMenus = [
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Container(
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
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.model[0].length,
                                    // physics: const AlwaysScrollableScrollPhysics(),
                                    // scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Menu_Card(
                                          onpress: () {},
                                          image: widget.model[0][index]
                                              ["image"],
                                          heading: widget.model[0][index]
                                              ["heading"],
                                          price: widget.model[0][index]
                                              ["price"],
                                          tax: widget.model[0][index]["tax"],
                                          clinic: widget.model[0][index]
                                              ["clinic"]);
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.model[1].length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Clinic_Card(
                                    onpress: () {
                                      // print("object");
                                      Navigator.of(context)
                                          .pushNamed("/Clinic_Datail");
                                    },
                                    image: widget.model[1][index]["image"],
                                    post: widget.model[1][index]["post"],
                                    name: widget.model[1][index]["name"],
                                    mark: widget.model[1][index]["mark"],
                                    day: widget.model[1][index]["day"],
                                    location: widget.model[1][index]
                                        ["location"]);
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                              itemCount: widget.model[2].length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Doctor_Card(
                                    onpress: () {},
                                    image: widget.model[2][index]["image"],
                                    post: widget.model[2][index]["post"],
                                    name: widget.model[2][index]["name"],
                                    mark: widget.model[2][index]["mark"],
                                    day: widget.model[2][index]["day"],
                                    clinic: widget.model[2][index]["clinic"]);
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                                  tabMenus[3],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.tabController.animateTo(4);
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
                              itemCount: widget.model[3].length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Diary_Card(
                                  avator: widget.model[3][index]["avator"],
                                  check: widget.model[3][index]["check"],
                                  image2: widget.model[3][index]["image2"],
                                  image1: widget.model[3][index]["image1"],
                                  eyes: widget.model[3][index]["eyes"],
                                  clinic: widget.model[3][index]["clinic"],
                                  name: widget.model[3][index]["name"],
                                  onpress: () {},
                                  price: widget.model[3][index]["price"],
                                  sentence: widget.model[3][index]["sentence"],
                                  type: widget.model[3][index]["type"],
                                );
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                                  tabMenus[4],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.tabController.animateTo(5);
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
                              itemCount: widget.model[4].length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Diary_Card(
                                  buttoncolor:
                                      Helper.btnBgMainColor,
                                  buttontext: widget.model[4][index]
                                      ["buttontext"],
                                  hearts: widget.model[4][index]["hearts"],
                                  chats: widget.model[4][index]["chats"],
                                  avator: widget.model[4][index]["avator"],
                                  check: widget.model[4][index]["check"],
                                  image2: widget.model[4][index]["image2"],
                                  image1: widget.model[4][index]["image1"],
                                  eyes: widget.model[4][index]["eyes"],
                                  name: widget.model[4][index]["name"],
                                  onpress: () {},
                                  price: widget.model[4][index]["price"],
                                  sentence: widget.model[4][index]["sentence"],
                                  type: widget.model[4][index]["type"],
                                );
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                                  tabMenus[5],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.tabController.animateTo(6);
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
                              itemCount: widget.model[5].length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox();
                                // return Counseling_Card(
                                //   hearts: widget.model[5][index]["hearts"],
                                //   chats: widget.model[5][index]["chats"],
                                //   avator: widget.model[5][index]["avator"],
                                //   check: widget.model[5][index]["check"],
                                //   image2: widget.model[5][index]["image2"],
                                //   image1: widget.model[5][index]["image1"],
                                //   image3: widget.model[5][index]["image3"],
                                //   image4: widget.model[5][index]["image4"],
                                //   eyes: widget.model[5][index]["eyes"],
                                //   name: widget.model[5][index]["name"],
                                //   onpress: () {},
                                //   sentence: widget.model[5][index]["sentence"],
                                //   type: widget.model[5][index]["type"],
                                //   clinic: widget.model[5][index]["clinic"],
                                // );
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                                  tabMenus[6],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.tabController.animateTo(7);
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
                              itemCount: widget.model[6].length,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox();
                                // return Question_Card(
                                //   isanswer: true,
                                //   hearts: widget.model[6][index]["hearts"],
                                //   chats: widget.model[6][index]["chats"],
                                //   avator: widget.model[6][index]["avator"],
                                //   image2: widget.model[6][index]["image2"],
                                //   image1: widget.model[6][index]["image1"],
                                //   eyes: widget.model[6][index]["eyes"],
                                //   name: widget.model[6][index]["name"],
                                //   onpress: () {},
                                //   sentence: widget.model[6][index]["sentence"],
                                //   type: widget.model[6][index]["type"],
                                // );
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
    );
  }
}

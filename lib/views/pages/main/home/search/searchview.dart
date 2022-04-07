import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:laxia/views/widgets/searchresult_card.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool flag = false, unchange = true;
  List menu_list = [];
  List counts = [];
  Future<void> searchCount() async {
    String mid = await rootBundle.loadString("assets/cfg/searchdefault.json");
    setState(() {
      counts = json.decode(mid);
    });
  }

  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/japanese-city-data.json");
    setState(() {
      menu_list = json.decode(countyText);
    });
  }

  @override
  void initState() {
    initSettings();
    super.initState();
  }
  bool issuffixicon=false;
  String searchtext = "";
  TextEditingController filter = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Visibility(
            child: TextField(
              textInputAction: TextInputAction.search,
              autofocus: true,
            ),
            visible: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                SizedBox(height: 44),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Focus(
                          child: SearchbarWidget(
                            issuffixicon: issuffixicon,
                            onpress: (){
                              setState(() {
                                flag = true;
                                unchange = true;
                                issuffixicon=false;
                              });
                              filter.clear();
                            },
                            state: false,
                            filter: filter,
                            onchange: () {
                              searchCount();
                              if (filter.text.isEmpty) {
                                setState(() {
                                  issuffixicon=false;
                                  flag = true;
                                  unchange = true;
                                });
                              } else {
                                setState(() {
                                  issuffixicon=true;
                                  unchange = false;
                                });
                              }
                            },
                            oncompleted: () {
                              userProperties.setSearchtext(filter.text);
                              Navigator.pop(context);
                            },
                          ),
                          onFocusChange: (hasfocus) {
                            if (hasfocus) {
                              setState(() {
                                flag = true;
                              });
                            }
                          }),
                    ),
                    issuffixicon
                        ? Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "キャンセル",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Helper.mainColor),
                                      ))),
                            ))
                        : SizedBox(width: 0),
                  ],
                ),
              ],
            ),
          ),
          unchange
              ? Container(
                  child: Column(
                    children: [
                      flag
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 13),
                              child: Text(
                                "施術したい箇所やクリニック名で検索してみましょう",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 102, 110, 110),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: 28, bottom: 20),
                              child: Text(
                                "人気検索ワード",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                    ],
                  ),
                )
              : SizedBox(
                  width: 0,
                ),
          unchange
              ? Expanded(
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      flag = false;
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color:Helper.whiteColor),
                      child: AbsorbPointer(
                        absorbing: flag ? true : false,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                children: [
                                  for (int j = 0; j < menu_list.length; j++)
                                    InkWell(
                                      onTap: () {
                                        filter.text = menu_list[j]["label"];
                                        setState(() {
                                          unchange = false;
                                          flag = true;
                                        });
                                        userProperties.setSearchtext(filter.text);
                                        Navigator.of(context).pushNamed("/Pages");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 245, 245, 245),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 6),
                                          child: Text(
                                            menu_list[j]["label"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                color: Color.fromARGB(
                                                    255, 102, 110, 110)),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Container(
                              decoration:  flag?BoxDecoration(
                                boxShadow: [
                                   BoxShadow(
                                        offset:  Offset(1000,1000),
                                        color: Colors.black.withOpacity(.7),
                                        spreadRadius: 1000)
                                    ],
                              ):BoxDecoration(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(250, 240, 242, 245),
                    ), //
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return Column(
                        children: [
                          // menuAppBar(context),
                          Expanded(
                            child: ListView.builder(
                                itemCount: counts.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return SearchResult(
                                    count: counts[index]["count"],
                                    index: index,
                                    onpress: () {},
                                  );
                                }),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
        ],
      ),
    );
  }
}

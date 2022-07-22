import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/static_controller.dart';
import 'package:laxia/models/static/Search_Model.dart';
import 'package:laxia/models/static/midsearch_model.dart';
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
  // List menu_list = [];
  final _con = StaticController();
  late Search_Model search;
  late MidSearch_Model midsearch;
  bool isloading = true,issearch=true;
  Future<void> searchList() async {
    try {
      final mid = await _con.getSearch();
      setState(() {
        search=mid;
        isloading = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }
  Future<void> midSearch(String q) async {
    try {
      final mid = await _con.midSearch(q);
      setState(() {
        midsearch=mid;
        unchange = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }
  @override
  void initState() {
    searchList();
    super.initState();
  }

  bool issuffixicon = false;
  String searchtext = "";
  TextEditingController filter = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: false);
    return isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    :Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Helper.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Focus(
                            child: SearchbarWidget(
                              issuffixicon: issuffixicon,
                              onpress: () {
                                setState(() {
                                  flag = true;
                                  unchange = true;
                                  issuffixicon = false;
                                });
                                filter.clear();
                              },
                              state: false,
                              filter: filter,
                              onchange: () {
                                if (filter.text.isEmpty) {
                                  setState(() {
                                    issuffixicon = false;
                                    flag = true;
                                    unchange = true;
                                  });
                                } else {
                                  setState(() {
                                    issuffixicon = true;
                                  });
                                }
                              },
                              oncompleted: () {
                                midSearch(filter.text);
                                
                                // userProperties.setSearchtext(filter.text);
                                // Navigator.pop(context);
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
                                    child: GestureDetector(
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
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Text(
                                      "施術したい箇所やクリニック名で検索してみましょう",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 102, 110, 110),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20),
                                child: Text(
                                  "直近の検索",
                                  style: TextStyle(
                                      fontFamily: Helper.headFontFamily,
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
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        flag = false;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Helper.whiteColor),
                        child: AbsorbPointer(
                          absorbing: flag ? true : false,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Wrap(
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: [
                                            for (int j = 0; j < search.recent.length; j++)
                                              GestureDetector(
                                                onTap: () {
                                                  filter.text =
                                                      search.recent[j].text;
                                                  setState(() {
                                                    unchange = false;
                                                    flag = true;
                                                  });
                                                  userProperties.setSearchtext(
                                                      filter.text);
                                                  Navigator.of(context)
                                                      .pushNamed("/Pages");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 245, 245, 245),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 6),
                                                    child: Text(
                                                      search.recent[j].text,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11,
                                                          color: Color.fromARGB(
                                                              255,
                                                              102,
                                                              110,
                                                              110)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        child: Text(
                                          "人気検索ワード",
                                          style: TextStyle(
                                              fontFamily: Helper.headFontFamily,
                                              color: Color.fromARGB(
                                                  255, 51, 51, 51),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Wrap(
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: [
                                            for (int j = 0; j < search.global.length; j++)
                                              GestureDetector(
                                                onTap: () {
                                                  filter.text =
                                                      search.global[j].text;;
                                                  setState(() {
                                                    unchange = false;
                                                    flag = true;
                                                  });
                                                  userProperties.setSearchtext(
                                                      filter.text);
                                                  Navigator.of(context)
                                                      .pushNamed("/Pages");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 245, 245, 245),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 6),
                                                    child: Text(
                                                      search.global[j].text,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11,
                                                          color: Color.fromARGB(
                                                              255,
                                                              102,
                                                              110,
                                                              110)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: flag
                                        ? BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(1000, 1000),
                                                  color: Colors.black
                                                      .withOpacity(.7),
                                                  spreadRadius: 1000)
                                            ],
                                          )
                                        : BoxDecoration(),
                                  )
                                ],
                              ),
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
                      child: LayoutBuilder(builder:
                          (context, BoxConstraints viewportConstraints) {
                        return Column(
                          children: [
                            // menuAppBar(context),
                            Expanded(
                              child: ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    SearchResult(
                                      count: midsearch.menus,
                                      index: 1,
                                    ),
                                    SearchResult(
                                      count: midsearch.clinics,
                                      index: 2,
                                    ),
                                    SearchResult(
                                      count: midsearch.doctors,
                                      index: 3,
                                    ),
                                    SearchResult(
                                      count: midsearch.diaries,
                                      index: 4,
                                    ),
                                    SearchResult(
                                      count: midsearch.cases,
                                      index: 5,
                                    )
                                  ],),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

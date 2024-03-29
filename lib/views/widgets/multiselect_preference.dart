import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/static/areas_model.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:provider/provider.dart';
import 'package:laxia/provider/surgery_provider.dart';

class MultiSelectDart extends StatefulWidget {
  final String buttontxt, title;
  final List<Area_Model> areas;
  final double width;
  const MultiSelectDart(
      {Key? key,
      required this.areas,
      required this.width,
      required this.buttontxt,
      required this.title})
      : super(key: key);

  @override
  State<MultiSelectDart> createState() => _MultiSelectDartState();
}

class _MultiSelectDartState extends State<MultiSelectDart> {
  List<List<bool>> selected = [[]];
  int currentpage = 0;
  List<bool> willSelect = [];
  PageController page = PageController();
  @override
  void initState() {
    for (int i = 0; i < widget.areas.length; i++) {
      // print("object"+i.toString());
      setState(() {
        willSelect.add(false);
        selected.add([]);
      });
      for (int j = 0; j < widget.areas[i].all_Citys!.length; j++) {
        setState(() {
          selected[i].add(false);
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PrefProvider prefprovider =
        Provider.of<PrefProvider>(context, listen: true);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Hiragino Kaku Gothic Pro w6",
                        fontWeight: FontWeight.w700)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          prefprovider.setButtonText("");
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 25,
                        )),
                    GestureDetector(
                      onTap: () {
                        for (int i = 0; i < widget.areas.length; i++) {
                          for (int j = 0;
                              j < widget.areas[i].all_Citys!.length;
                              j++) {
                            setState(() {
                              selected[i][j] = false;
                              willSelect[i] = true;
                            });
                          }
                        }
                      },
                      child: Text("クリア",
                          style: TextStyle(
                              color: Helper.maintxtColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Wrap(
            // alignment: WrapAlignment.spaceBetween,
            runSpacing: 10,
            spacing: 0,
            children: [
              for (int j = 0;
                  j < widget.areas[currentpage].all_Citys!.length;
                  j++)
                !selected[currentpage][j]
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected[currentpage][j] =
                                  !selected[currentpage][j];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                    width: 1, color: Helper.mainColor),
                                color: selected[currentpage][j]
                                    ? Helper.mainColor
                                    : Helper.whiteColor),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.areas[currentpage].all_Citys![j]
                                        .name!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: selected[currentpage][j]
                                            ? Helper.whiteColor
                                            : Helper.mainColor),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/arrowclear.svg",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
            ],
          ),
          // Container(
          //   alignment: Alignment.center,
          //   height: 1,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.25), //color of shadow
          //         spreadRadius: 2,
          //         offset: Offset(0, 2),
          //         //first paramerter of offset is left-right
          //         //second parameter is top to down
          //       ),
          //       //you can set more BoxShadow() here
          //     ],
          //   ),
          // ),
          Container(
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: widget.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(builder:
                              (context, BoxConstraints viewportConstraints) {
                            return ListView.builder(
                                itemCount: widget.areas.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      page.jumpToPage(index);
                                      setState(() {
                                        currentpage = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: currentpage == index
                                              ? Helper.whiteColor
                                              : Color.fromARGB(
                                                  255, 248, 250, 249),
                                          border: currentpage == index
                                              ? Border(
                                                  left: BorderSide(
                                                      width: 5,
                                                      color: Helper.mainColor),
                                                )
                                              : Border(
                                                  top: BorderSide(
                                                      width:
                                                          index == 0 ? 1 : 0.5,
                                                      color: Color.fromARGB(
                                                          255, 239, 239, 239)),
                                                  left: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 239, 239, 239)),
                                                  right: BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 239, 239, 239)),
                                                  bottom: BorderSide(
                                                      width: 0.5,
                                                      color: Color.fromARGB(255,
                                                          239, 239, 239)))),
                                      width: double.infinity,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Text(
                                            widget.areas[index].name!,
                                            softWrap: true,
                                            style: TextStyle(
                                                color: (currentpage == index)
                                                    ? Helper.mainColor
                                                    : Helper.maintxtColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                                });
                          }),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: page,
                        children: [
                          for (int i = 0; i < widget.areas.length; i++)
                            Container(
                              color: Helper.whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      for (int j = 0;
                                          j <
                                              widget.areas[currentpage]
                                                  .all_Citys!.length;
                                          j++)
                                        setState(() {
                                          selected[currentpage][j] =
                                              willSelect[currentpage];
                                        });
                                      setState(() {
                                        willSelect[currentpage] =
                                            !willSelect[currentpage];
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            border: Border.all(
                                                width: 1,
                                                color: Helper.mainColor),
                                            color: Helper.whiteColor),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          child: Text(
                                            "すべて",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Helper.mainColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          // alignment: WrapAlignment.spaceBetween,
                                          runSpacing: 10,
                                          spacing: 10,
                                          children: [
                                            for (int j = 0;
                                                j <
                                                    widget.areas[currentpage]
                                                        .all_Citys!.length;
                                                j++)
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selected[currentpage][j] =
                                                        !selected[currentpage]
                                                            [j];
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22),
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Helper.mainColor),
                                                      color:
                                                          selected[currentpage]
                                                                  [j]
                                                              ? Helper.mainColor
                                                              : Helper
                                                                  .whiteColor),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 3),
                                                    child: Text(
                                                      widget.areas[currentpage]
                                                          .all_Citys![j].name!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: selected[
                                                                      currentpage]
                                                                  [j]
                                                              ? Helper
                                                                  .whiteColor
                                                              : Helper
                                                                  .mainColor),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              prefprovider.initSelected();
              for (int i = 0; i < widget.areas.length; i++) {
                for (int j = 0; j < widget.areas[i].all_Citys!.length; j++) {
                  if (selected[i][j]) {
                    prefprovider.setSelectedCurePos(
                        widget.areas[i].all_Citys![j].id,
                        widget.areas[i].all_Citys![j].name!);
                  }
                }
              }

              prefprovider.setButtonText("");
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Helper.btnBgMainColor),
                width: 290,
                height: 42,
                child: Center(
                  //padding: EdgeInsets.symmetric(horizontal: 114, vertical: 12),
                  child: Text(
                    prefprovider.btnText.isEmpty
                        ? widget.buttontxt
                        : prefprovider.btnText,
                    style: TextStyle(
                        fontFamily: "Hiragino Kaku Gothic Pro w6",
                        color: Helper.whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}

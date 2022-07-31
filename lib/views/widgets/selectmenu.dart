import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/static_controller.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/models/static/menulist_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:provider/provider.dart';
import 'package:laxia/provider/surgery_provider.dart';

class SelectMenu extends StatefulWidget {
  const SelectMenu(
      {Key? key})
      : super(key: key);

  @override
  State<SelectMenu> createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu> {
  int currentpage = 0;
  int subcurrent=-1;
  bool isloading=true;
  final _con = StaticController();
  late List<Menulist_Model> menu_list;
  Future<void> getData() async {
    try {
      
      setState(() {
        isloading = false;
      });
      menu_list = await _con.getMenuList();

    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }
  PageController page = PageController();
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('施術',
                style: TextStyle(
                    fontFamily: "Hiragino Kaku Gothic Pro w6",
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(height: 5,),
          Container(
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    child: Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(builder:
                              (context, BoxConstraints viewportConstraints) {
                            return ListView.builder(
                                itemCount: menu_list.length,
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
                                      child: SizedBox(
                                        height: 44,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                menu_list[index].name,
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: (currentpage ==
                                                            index)
                                                        ? Helper.mainColor
                                                        : Helper.maintxtColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
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
                          for (int i = 0; i < menu_list.length; i++)
                            Container(
                              color: Helper.whiteColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                                    menu_list[currentpage]
                                                        .menus.length;
                                                j++)
                                              GestureDetector(
                                                onTap: () {
                                                  subcurrent=menu_list[currentpage].menus[j].id;
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
                                                          subcurrent==menu_list[currentpage].menus[j].id
                                                              ? Helper.mainColor
                                                              : Helper
                                                                  .whiteColor),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 3),
                                                    child: Text(
                                                      menu_list[
                                                              currentpage]
                                                          .menus[j]
                                                          .name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: subcurrent==menu_list[currentpage].menus[j].id
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
              // surgeryProvider.initSelected();
              // for (int i = 0; i < widget.treatments.length; i++) {
              //   for (int j = 0;
              //       j < widget.treatments[i].all_childrens!.length;
              //       j++) {
              //     if (selected[i][j]) {
              //       surgeryProvider.setSelectedCurePos(
              //           widget.treatments[i].all_childrens![j].id,
              //           widget.treatments[i].all_childrens![j].name!);
              //     }
              //   }
              // }
              // diaryProperties
              //     .setOperatinTypes(surgeryProvider.getSelectedCurePos);

              // surgeryProvider.setButtonText("");
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Helper.btnBgMainColor),
                    width: 290,
                    height: 42,
                child: Center(
                  
                  child: Text(
                    '選択を確定する',
                    style: TextStyle(
                        fontFamily: Helper.headFontFamily,
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

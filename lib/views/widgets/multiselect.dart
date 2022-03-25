import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:laxia/models/menu_model.dart';

class MultiSelectDart extends StatefulWidget {
  final List menu_list;
  final double width;
  const MultiSelectDart(
      {Key? key, required this.menu_list, required this.width})
      : super(key: key);

  @override
  State<MultiSelectDart> createState() => _MultiSelectDartState();
}

class _MultiSelectDartState extends State<MultiSelectDart> {
  List<List<bool>> selected = [[]];
  int currentpage = 0;
  PageController page = PageController();
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.menu_list.length; i++) {
      setState(() {
        selected.add([]);
      });
      for (int j = 0; j < widget.menu_list[i]["children"].length; j++) {
        setState(() {
          selected[i].add(false);
        });
      }
    }
    return Container(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: widget.width,
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return ListView.builder(
                          itemCount: widget.menu_list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                                child: InkWell(
                              onTap: () {
                                page.jumpToPage(index);
                                setState(() {
                                  currentpage = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: currentpage == index
                                        ? Colors.white
                                        : Color.fromARGB(255, 248, 250, 249),
                                    border: currentpage == index
                                        ? Border(
                                            left: BorderSide(
                                                width: 5, color: Colors.blue),
                                          )
                                        : Border(
                                            top: BorderSide(
                                                width: index == 0 ? 1 : 0.5,
                                                color: Colors.grey),
                                            left: BorderSide(
                                                width: 1, color: Colors.grey),
                                            right: BorderSide(
                                                width: 1, color: Colors.grey),
                                            bottom: BorderSide(
                                                width: 0.5,
                                                color: Colors.grey))),
                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child:
                                        Text(widget.menu_list[index]["label"]),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: page,
                  children: [
                    for (int i = 0; i < widget.menu_list.length; i++)
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 110, 198, 210)),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                child: Text(
                                  "すべて",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 110, 198, 210)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                primary: false,
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    runSpacing: 10,
                                    spacing: 10,
                                    children: [
                                      for (int j = 0;
                                          j <
                                              widget
                                                  .menu_list[currentpage]
                                                      ["children"]
                                                  .length;
                                          j++)
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selected[currentpage][j] =
                                                  !selected[currentpage][j];
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 110, 198, 210)),
                                                color: selected[currentpage][j]
                                                    ? Color.fromARGB(
                                                        255, 110, 198, 210)
                                                    : Colors.white),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 3),
                                              child: Text(
                                                widget.menu_list[currentpage]
                                                    ["children"][j]["label"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: selected[currentpage]
                                                            [j]
                                                        ? Colors.white
                                                        : Color.fromARGB(255,
                                                            110, 198, 210)),
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
    );
  }
}

import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diary_addpage_card.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String searchdata = "";
  int page = 0;
  bool isend = false, isloading = true, isexpanding = true;
  bool expanded = true;
  int index = -1;
  late Diary diary_data;
  final _con = HomeController();
  late Diary mid;
  List categoryList = [];
  Future<void> getData({required String page, String? q = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        mid = await _con.getDiaryData(page: page, q: q);
        for (int i = 0; i < mid.data.length; i++) {
          categoryList.addAll(mid.data[i].categories!);
        }
        if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
        setState(() {
          if (isloading) {
            diary_data = mid;
            isloading = false;
          } else {
            diary_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });

        print(mid);
      }
    } catch (e) {
      setState(() {
        isexpanding = true;
        isend = true;
        print(e.toString());
      });
    }
  }

  @override
  void initState() {
    getData(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '日記を投稿する',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/AddDiaryStep1");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    primary: Helper.mainColor,
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '新しい日記を投稿',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isloading
                ? Container(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.transparent,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Column(children: [
                    categoryList.length > 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: ListTile(
                              title: Text(
                                '全ての日記',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : SizedBox(),
                    NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          if (isexpanding) {
                            getData(page: (page + 1).toString());
                            setState(() {
                              page += 1;
                            });
                          }
                        }
                        return true;
                      },
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: mid.data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        mid.data[index].categories!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int subIndex) {
                                      return DiaryAddPage_Card(
                                        avator: mid.data[index].patient_photo!,
                                        name: mid.data[index]
                                            .categories![subIndex].name,
                                        image1: diary_list[index]["image1"],
                                        image2: diary_list[index]["image2"],
                                        sentence: diary_list[index]["sentence"],
                                        clinic: mid.data[index].clinic_name,
                                        type: mid.data[index]
                                            .categories![subIndex].name,
                                        check: mid.data[index].doctor_name!,
                                        eyes: diary_list[index]["eyes"],
                                        onpress: () {},
                                        price: diary_list[index]["price"],
                                        buttontext: diary_list[index]["status"],
                                        fontcolor: (diary_list[index]
                                                    ["status"] ==
                                                "未公開"
                                            ? Color.fromARGB(255, 102, 110, 110)
                                            : Color.fromARGB(
                                                255, 240, 154, 55)),
                                        buttoncolor: (diary_list[index]
                                                    ["status"] ==
                                                "未公開"
                                            ? Color.fromARGB(50, 102, 110, 110)
                                            : Color.fromARGB(50, 240, 154, 55)),
                                      );
                                    });
                              }),
                          isexpanding
                              ? Container()
                              : Container(
                                  height: 100,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: new CircularProgressIndicator(),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ]),
          ],
        ),
      ),
    );
  }
}

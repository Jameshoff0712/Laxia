import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step2.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/models/doctor_model.dart';

class AddDiaryStep1Page extends StatefulWidget {
  final bool? isMyDiary;
  const AddDiaryStep1Page({Key? key, this.isMyDiary = false}) : super(key: key);
  @override
  _AddDiaryStep1PageState createState() => _AddDiaryStep1PageState();
}

class _AddDiaryStep1PageState extends State<AddDiaryStep1Page> {
  List<String> addList = [
    "選択してください",
    "選択してください",
    "選択してください",
    "選択してください",
    "選択してください"
  ];
  bool isAddEnabled = true, isUsed = false;
  //File imageURI;
  // late OfferController _con;

  // _AddDiaryStep1PageState() : super(OfferController()) {
  //   _con = controller as OfferController;
  // }

  enableAddButton() {
    setState(() {
      isAddEnabled = true;
    });
  }

  disableAddButton() {
    setState(() {
      isAddEnabled = false;
    });
  }

  AddDiaryStep1Page() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("下書きに保存しますか？"),
          content: Text("まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
              style: TextStyle(fontSize: 14)),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new FlatButton(
                  textColor: Color.fromARGB(255, 110, 198, 210),
                  child: new Text('保存しない'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  color: Color.fromARGB(255, 110, 198, 210),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('保存する'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/AddDiaryStep2");
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    isUsed = false;
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep1Page.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    if (surgeryProvider.selectedCurePos.isNotEmpty) {
      setState(() {
        isAddEnabled = true;
      });
    } else {
      setState(() {
        isAddEnabled = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '基本情報を入力',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                title: Text(
                  '基本情報',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 14.0, 18.0, 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術日",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Text(
                          addList[0],
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy/MM/dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                addList[0] =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 14.0, 18.0, 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術箇所",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            isUsed
                                ? surgeryProvider.getSelectedCurePosStr
                                : "選択してください",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            surgeryProvider.selectedCurePosStr.clear();
                            surgeryProvider.setButtonText("次へ");
                            Navigator.of(context).pushNamed("/SelectSurgery");
                            setState(() {
                              isUsed = true;
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 14.0, 18.0, 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "クリニック",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            addList[2],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.9,
                                ),
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Helper.whiteColor,
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(
                                                    Icons.arrow_back_ios,
                                                    size: 20,
                                                  )),
                                              Text(
                                                "クリニック名で検索",
                                                style: defaultTextStyle(
                                                    Helper.titleColor,
                                                    FontWeight.w700,
                                                    size: 18),
                                              ),
                                              Icon(
                                                Icons.arrow_back_ios,
                                                size: 20,
                                                color: Helper.whiteColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: SearchbarWidget(
                                            state: false,
                                            filter: TextEditingController(),
                                            hinttext: "クリニックを検索",
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: LayoutBuilder(builder:
                                              (context,
                                                  BoxConstraints
                                                      viewportConstraints) {
                                            return ListView.builder(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                itemCount: clinic_list.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        addList[2] =
                                                            clinic_list[index]
                                                                ["name"];
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      19,
                                                                  vertical: 16),
                                                              child: Text(
                                                                clinic_list[
                                                                        index]
                                                                    ["name"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 14.0, 18.0, 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "担当ドクター",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            addList[3],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.9,
                                ),
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Helper.homeBgColor,
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 20,
                                                  )),
                                              Text(
                                                "担当ドクターを選択",
                                                style: defaultTextStyle(
                                                    Helper.titleColor,
                                                    FontWeight.w700,
                                                    size: 18),
                                              ),
                                              Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Helper.whiteColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: SearchbarWidget(
                                            state: false,
                                            filter: TextEditingController(),
                                            hinttext: "ドクターを検索",
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: LayoutBuilder(builder:
                                              (context,
                                                  BoxConstraints
                                                      viewportConstraints) {
                                            return ListView.builder(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                itemCount: doctor_list.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        addList[3] =
                                                            doctor_list[index]
                                                                ["name"];
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Helper.homeBgColor,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 4),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 65,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Helper
                                                                      .whiteColor),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 35,
                                                                    width: 35,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              17.5),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imageUrl:
                                                                            doctor_list[index]["image"],
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                Image.asset(
                                                                          'assets/images/loading.gif',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Image.asset(
                                                                          'assets/images/profile.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: SizedBox(
                                                                  width: 12,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  color: Helper
                                                                      .whiteColor,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            doctor_list[index]['name'],
                                                                            style: defaultTextStyle(Helper.titleColor,
                                                                                FontWeight.w700,
                                                                                size: 16.0),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          Text(
                                                                            doctor_list[index]["post"],
                                                                            style: defaultTextStyle(Helper.maintxtColor,
                                                                                FontWeight.w700,
                                                                                size: 10.0),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        doctor_list[index]
                                                                            [
                                                                            "clinic"],
                                                                        style: defaultTextStyle(
                                                                            Helper
                                                                                .maintxtColor,
                                                                            FontWeight
                                                                                .w400,
                                                                            size:
                                                                                12.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 14.0, 18.0, 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術内容",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Text(
                          addList[4],
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.9,
                                ),
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container();
                                });
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 20),
                title: Text(
                  '施術前の写真',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            imagePicker(context),
            !widget.isMyDiary!
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 76,
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed:
                            isAddEnabled ? () => AddDiaryStep1Page() : null,
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          primary: Helper.mainColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '次に進む',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDiaryStep2Page(isMyDiary: widget.isMyDiary)));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 70),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        side: const BorderSide(
                            color: Helper.mainColor,
                            width: 1,
                            style: BorderStyle.solid),
                        primary: Helper.whiteColor,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '次へ進む',
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              color: Helper.mainColor),
                        ),
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

Widget imagePicker(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 12.0, top: 0, right: 12, bottom: 12),
    child: GestureDetector(
      child: Row(
        children: <Widget>[
          InkWell(
            //onTap: () => context.getImageFromGallery(),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 15),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/photo.svg",
                    width: 36,
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('写真を追加', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 9),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //PhotoCarouselWidget(offerList: _con.offers, heroTag: 'offer_trending_carousel'),
                  // PhotoCarouselWidget(),
                  // PhotoCarouselWidget(),
                  // PhotoCarouselWidget(),
                  // PhotoCarouselWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

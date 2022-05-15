import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/select_clinic.dart';
import 'package:laxia/views/pages/main/contribution/select_doctor.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step2.dart';
import 'package:intl/intl.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';

class AddCounselStep1Page extends StatefulWidget {
  final bool? isMyDiary;
  const AddCounselStep1Page({Key? key, this.isMyDiary = false})
      : super(key: key);
  @override
  _AddCounselStep1PageState createState() => _AddCounselStep1PageState();
}

class _AddCounselStep1PageState extends State<AddCounselStep1Page> {
  List<String> addList = [
    "選択してください",
    "選択してください",
    "選択してください",
    "選択してください",
    "選択してください"
  ];
  bool isAddEnabled = true, isUsed = false;
  int index = 0;
  List images = [[]];
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        images[index].add(File(pickedImage.path));
      });
    }
  }

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

  _AddCounselStep2Page() {
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
                    Navigator.of(context).pushNamed("/AddCounselStep2");
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
    images.add([]);
    images.add([]);
    images.add([]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImageFromGallery() async {
    // var image = await AddCounselStep1Page.pickImage(source: ImageSource.gallery);

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
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('カウセレポを入力',
            style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.5,
            )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Helper.titleColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '基本情報',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Helper.txtColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術箇所",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                surgeryProvider.selectedCurePosStr.isNotEmpty
                                    ? surgeryProvider.getSelectedCurePosStr
                                    : "選択してください",
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Helper.txtColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  surgeryProvider.selectedCurePosStr.clear();
                                  surgeryProvider.setButtonText("次へ");
                                  Navigator.of(context)
                                      .pushNamed("/SelectSurgery");
                                  setState(() {
                                    isUsed = true;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Helper.txtColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "クリニック",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                userProperties.getSelectedClinic != ""
                                    ? userProperties.getSelectedClinic
                                    : "選択してください",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Helper.txtColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                      ),
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return SelectClinic();
                                      });
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Helper.txtColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "担当ドクター",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                userProperties.getSelectedDoctor != ""
                                    ? userProperties.getSelectedDoctor
                                    : "選択してください",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Helper.txtColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                      ),
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return SelectDoctor();
                                      });
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Helper.txtColor),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "カウンセリング日",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                addList[0],
                                style: TextStyle(
                                    color: Helper.txtColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2200, 6, 7),
                                      onChanged: (date) {}, onConfirm: (date) {
                                    setState(() {
                                      addList[0] = date.year.toString() +
                                          "年" +
                                          date.month.toString() +
                                          "月" +
                                          date.day.toString() +
                                          "日";
                                    });
                                    // diaryProperties.setDate(
                                    //     date.year.toString() +
                                    //         "/" +
                                    //         date.month.toString() +
                                    //         "/" +
                                    //         date.day.toString());
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.jp);
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                'どんなことに悩んでいますか？',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    setState(() {
                      isAddEnabled = true;
                    });
                  } else {
                    setState(() {
                      isAddEnabled = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: '例)二重幅が狭いことに悩んでいました',
                  hintStyle: TextStyle(
                    color: Helper.txtColor,
                    fontSize: 14,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '自分の写真',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            imagePicker(context, 0),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '理想の写真',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            imagePicker(context, 1),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '理想じゃない写真',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            imagePicker(context, 2),
            SizedBox(height: 48,),
            !widget.isMyDiary!
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: ElevatedButton(
                        onPressed:
                            isAddEnabled ? () => _AddCounselStep2Page() : null,
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
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCounselStep2Page(
                                    isMyDiary: widget.isMyDiary)));
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
            SizedBox(height: 48),  
          ],
        ),
      ),
    ));
  }

  Widget imagePicker(BuildContext context, int subindex) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 12, bottom: 0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  index = subindex;
                });
                _openImagePicker();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 14),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/photo.svg",
                      width: 36,
                      height: 29,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('写真を追加',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.5)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhotoCarouselWidget(
                      ImageList: images[subindex],
                      onRemove: (int) {
                        setState(() {
                          images[subindex].removeAt(int);
                        });
                      },
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

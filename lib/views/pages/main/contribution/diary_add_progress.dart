import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/widgets/state_slider_widget.dart';

class AddDiaryProgressPage extends StatefulWidget {
  final bool? isMyDiary;
  const AddDiaryProgressPage({Key? key, this.isMyDiary = false}) : super(key: key);
  @override
  _AddDiaryProgressPageState createState() => _AddDiaryProgressPageState();
}

class _AddDiaryProgressPageState extends State<AddDiaryProgressPage> {
  bool isAddEnabled = true;
  int index = 0;
  List images = [];
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        images.add(File(pickedImage.path));
      });
    }
  }

  AddDiaryPage() {
    Navigator.of(context).pushNamed("/AddDiaryList");
  }

  void onDonePress() {
    // Do what you want
    print("End of slides");
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryProgressPage.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('術後経過を入力',
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
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '施術日からの経過日数',
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
                            "経過日数",
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
                                "選択してください",
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
                                  // showModalBottomSheet(
                                  //     constraints: BoxConstraints(
                                  //       maxHeight:
                                  //           MediaQuery.of(context).size.height *
                                  //               0.9,
                                  //     ),
                                  //     isScrollControlled: true,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.only(
                                  //           topLeft: Radius.circular(15.0),
                                  //           topRight: Radius.circular(15.0)),
                                  //     ),
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return SelectDoctor();
                                  //     });
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
                '経過写真',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            imagePicker(context),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '施術箇所の具合',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            StateSliderWidget(
              state_str: "痛み",
              state_val: 0,
            ),
            StateSliderWidget(
              state_str: "腫れ",
              state_val: 0,
            ),
            StateSliderWidget(
              state_str: "傷あと",
              state_val: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  '経過日記',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
                ),
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
                  hintText: '施術5日目の経過です。腫れもだいふひいてきました。',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 156, 161, 161),
                      fontSize: 14,
                      height: 1.8,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            !widget.isMyDiary! ?Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 85,
                padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () => AddDiaryPage() : null,
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
                    child: Text(
                      '次に進む',
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            )
            : Center(
                    child: Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AddDiaryStep2Page(
                        //             isMyDiary: widget.isMyDiary)));
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

  Widget imagePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 12, bottom: 0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
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
                              fontWeight: FontWeight.w700,
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
                      ImageList: images,
                      onRemove: (int) {
                        setState(() {
                          images.removeAt(int);
                        });
                      },
                      bRemove: true,
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

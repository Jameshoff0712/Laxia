import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:provider/provider.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/controllers/question_controller.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends StateMVC<AddQuestion> {
  bool isAddEnabled = false;
  bool isUsed = false;
  //File imageURI;
  late QuestionController _con;
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

  _AddQuestionState() : super(QuestionController()) {
    _con = controller as QuestionController;
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

  _AddQuestion() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(children: [
            Container(
              width: 300,
              height: 200,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 14),
                    child: Text(
                      "投稿を途中でやめますか？",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        color: Helper.titleColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: Helper.titleColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new FlatButton(
                          textColor: Helper.mainColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 0),
                            child: Text(
                              'いいえ',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          color: Helper.mainColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Text(
                                'はい',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          onPressed: () {
                            // diaryProperties.setMedias(images);
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("/Pages");
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        );
        // return AlertDialog(
        //   title: Text("投稿を途中でやめますか？"),
        //   content: Text("まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
        //       style: TextStyle(fontSize: 14)),
        //   actions: <Widget>[
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         new FlatButton(
        //           textColor: Color.fromARGB(255, 110, 198, 210),
        //           child: new Text('いいえ'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //         new FlatButton(
        //           color: Color.fromARGB(255, 110, 198, 210),
        //           textColor: Colors.white,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(15)),
        //           child: new Text('はい'),
        //           onPressed: () {
        //             //Navigator.of(context).pop();
        //             Navigator.of(context).pushNamed("/Pages");
        //           },
        //         )
        //       ],
        //     )
        //   ],
        // );
      },
    );
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddQuestion.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);

    if (surgeryProvider.selectedCurePos.isNotEmpty &&
        _con.question_titleCtrl.text.isNotEmpty &&
        _con.question_contentCtrl.text.isNotEmpty) {
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
          '質問内容を入力',
          style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 25, color: Helper.titleColor),
          onPressed: () {
            surgeryProvider.selectedCurePosStr.clear();
            surgeryProvider.selectedCurePos.clear();
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
                '質問の詳細',
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
                            "質問したい施術内容",
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
                              Expanded(
                                child: Text(
                                  surgeryProvider.selectedCurePosStr.isNotEmpty
                                      ? surgeryProvider.getSelectedCurePosStr
                                      : "選択してください",
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Helper.txtColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.5),
                                ),
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
            // Container(
            //   decoration: BoxDecoration(color: Colors.white),
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 12.0),
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Flexible(
            //             flex: 1,
            //             child: Text(
            //               "質問したい施術内容",
            //               style: TextStyle(
            //                   color: Color.fromARGB(255, 18, 18, 18),
            //                   fontWeight: FontWeight.w400,
            //                   fontSize: 14,
            //                   height: 1.5),
            //             ),
            //           ),
            //           Flexible(
            //             flex: 1,
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: Text(
            //                     surgeryProvider.selectedCurePos.isEmpty
            //                         ? "選択してください"
            //                         : surgeryProvider.getSelectedCurePosStr,
            //                     style: TextStyle(
            //                         color: Helper.titleColor,
            //                         fontWeight: FontWeight.w400,
            //                         fontSize: 14,
            //                         height: 1.3),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 25,
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     surgeryProvider.setButtonText("次へ");
            //                     Navigator.of(context)
            //                         .pushNamed("/SelectSurgery");
            //                     setState(() {isAddEnabled = true;});
            //                   },
            //                   child: Icon(
            //                     Icons.arrow_forward_ios,
            //                     color: Colors.grey,
            //                     size: 20,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 8,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ]),
            //   ),
            // ),
            const SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: TextFormField(
                      controller: _con.question_titleCtrl,
                      keyboardType: TextInputType.text,
                      maxLength: 40,
                      //onSaved: (input) => editTitle(input),
                      onChanged: (text) {
                        if (surgeryProvider.selectedCurePos.isNotEmpty &&
                            _con.question_titleCtrl.text.isNotEmpty &&
                            _con.question_contentCtrl.text.isNotEmpty) {
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
                          hintText: '質問タイトルを入力(40文字以内)',
                          hintStyle: TextStyle(
                              color: Helper.txtColor,
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w400),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Helper.txtColor)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Helper.txtColor),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          counterText: ""),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: TextFormField(
                      controller: _con.question_contentCtrl,
                      keyboardType: TextInputType.multiline,
                      maxLength: 1000,
                      maxLines: 10,
                      onChanged: (text) {
                        if (surgeryProvider.selectedCurePos.isNotEmpty &&
                            _con.question_titleCtrl.text.isNotEmpty &&
                            _con.question_contentCtrl.text.isNotEmpty) {
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
                        hintText: '質問の詳細を入力(1000文字以内)',
                        hintStyle: TextStyle(
                            color: Helper.txtColor,
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            imagePicker(context),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 85,
                padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () => _AddQuestion() : null,
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
          ],
        ),
      ),
    );
  }

  Widget imagePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 16, bottom: 0),
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
                      ImageList: images,
                      onRemove: (int) {
                        setState(() {
                          images.removeAt(int);
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

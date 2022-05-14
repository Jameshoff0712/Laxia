import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDiaryStep4Page extends StatefulWidget {
  final bool? isMyDiary;
  const AddDiaryStep4Page({Key? key, this.isMyDiary = false}) : super(key: key);
  @override
  _AddDiaryStep4PageState createState() => _AddDiaryStep4PageState();
}

class _AddDiaryStep4PageState extends State<AddDiaryStep4Page> {
  bool isAddEnabled = true;
  // late OfferController _con;

  // _AddDiaryStep4PageState() : super(OfferController()) {
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

  AddDiaryStep5Page() {
    Navigator.of(context).pushNamed("/AddDiaryStep5");
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep4Page.pickImage(source: ImageSource.gallery);

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
        title: Text('施術について',
            style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.w400,
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
              padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
              child: Text(
                'どんなことで悩んでいましたか？',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.w400,
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
                  hintText: '例)目が一重で目つきがキツイことで悩んでいました。',
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
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
              child: Text(
                'クリニック、ドクターを選択した理由は？',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.w400,
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
                  hintText: '例)二重部門でラシアでの評価も高く信頼できると思ったからです。',
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
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
              child: Text(
                'このメニューを選んだ理由は？',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.w400,
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
                  hintText: '例)二重切開が良いと思ったのですが、私のまぶただと埋没でも大丈夫ということで、埋没にしました。',
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
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
              child: Text(
                '施術の流れや施術中の痛みは？',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.w400,
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
                  hintText: '例)施術は15分ほどで終わりました。麻酔をしていたので特に痛みはなかったです。',
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
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
              child: Text(
                'ドクターやスタッフの対応はどうでしたか？',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.w400,
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
                  hintText: '例)ドクターもスタッフの方も優しく声をかけていただき、安心して施術に向かうことができきました。',
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
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
              child: Text(
                'この施術をしたいと思ってる人へアドバイスを',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontWeight: FontWeight.w400,
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
                  hintText: '例)毎日自分の顔が見るのが楽しみになりました。もし迷っているなら、是非オススメします。',
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
            !widget.isMyDiary!
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 67,
                      padding: EdgeInsets.only(top: 22, left: 16, right: 16),
                      child: ElevatedButton(
                        onPressed:
                            isAddEnabled ? () => AddDiaryStep4Page() : null,
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
                    padding: EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
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
                          '修正を完了',
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

import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/models/counsel_question_model.dart';
import 'package:laxia/views/widgets/counsel_question_card.dart';

class AddCounselStep2Page extends StatefulWidget {
  @override
  _AddCounselStep2PageState createState() => _AddCounselStep2PageState();
}

class _AddCounselStep2PageState extends State<AddCounselStep2Page> {
  bool isAddEnabled = true;
  int selectstar = 0;
  // late OfferController _con;

  // _AddCounselStep2PageState() : super(OfferController()) {
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

  AddCounselPage() {
    Navigator.of(context).pushNamed("/AddCounselList");
  }

  CounselDownloadPage() {
    Navigator.of(context).pushNamed("/AddCounselList");
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddCounselStep2Page.pickImage(source: ImageSource.gallery);

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
        title: Text(
          'カウセレポを入力',
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
                  'このクリニックを選んだ理由は？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
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
                  hintText: '例)ラシアの他の口コミをみて、ここのクリニックの田中先生に相談してみようと思い選択しました。',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                title: Text(
                  '質問・相談した内容は？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: CounselQuestion_list.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CounselQuestion_Card(
                        index: index + 1,
                        question: CounselQuestion_list[index].question,
                        answer: CounselQuestion_list[index].answer,
                        onpress: () {},
                      );
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                title: Text(
                  'カウンセリングの様子はどうでしたか？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
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
                  hintText:
                      '例)真摯に質問や相談に乗ってくれました。価格も相談に乗っていただき自分にあった施術を提案していただいた。',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                title: Text(
                  'カウンセリング後の感想',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
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
                  hintText: '例)自分にあった二重幅を知ることができた。料金も良心的であると思いました。',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                title: Text(
                  'カウンセリングの満足度',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        selectstar > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () => AddCounselPage() : null,
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
                      'レポートを投稿する',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    CounselDownloadPage();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 110, 198, 210),
                        width: 2,
                        style: BorderStyle.solid),
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    onSurface: Color.fromARGB(255, 110, 198, 210),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'レポートを下書き保存する',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 110, 198, 210)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Star(int sindex, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          selectstar = sindex + 1;
        });
      },
      child: Container(
        //decoration: BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "icons/star.svg",
              width: 42,
              height: 42,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

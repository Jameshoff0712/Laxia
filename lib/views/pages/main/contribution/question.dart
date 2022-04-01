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
  //File imageURI;
  late QuestionController _con;

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

  AddQuestion() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("投稿を途中でやめますか？"),
          content: Text("まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
              style: TextStyle(fontSize: 14)),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new FlatButton(
                  textColor: Color.fromARGB(255, 110, 198, 210),
                  child: new Text('いいえ'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  color: Color.fromARGB(255, 110, 198, 210),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: new Text('はい'),
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/Pages");
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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 22, color: Colors.black),
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
                  '質問の詳細',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 14.0, 18.0, 14.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "質問したい施術内容",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          surgeryProvider.selectedCurePos.isEmpty
                              ? "選択してください"
                              : surgeryProvider.getSelectedCurePosStr,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          surgeryProvider.setButtonText("次へ");
                          Navigator.of(context).pushNamed("/SelectSurgery");
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 3.0, 18.0, 0.0),
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
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(1, 210, 210, 212)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 3.0, 18.0, 8.0),
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
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            imagePicker(context),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () => AddQuestion() : null,
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
                      '質問を投稿',
                      style: TextStyle(fontSize: 18),
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
}

Widget imagePicker(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(12.0),
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
                    "icons/photo.svg",
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
                  PhotoCarouselWidget(),
                  PhotoCarouselWidget(),
                  PhotoCarouselWidget(),
                  PhotoCarouselWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDiaryStep1Page extends StatefulWidget {
  @override
  _AddDiaryStep1PageState createState() => _AddDiaryStep1PageState();
}

class _AddDiaryStep1PageState extends State<AddDiaryStep1Page> {
  bool isAddEnabled = true;
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
                          "選択してください",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/TreatmentPart"),
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
                        Text(
                          "選択してください",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/TreatmentPart"),
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
                        Text(
                          "選択してください",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/TreatmentPart"),
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
                        Text(
                          "選択してください",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/TreatmentPart"),
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
                          "選択してください",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/TreatmentPart"),
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
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () => AddDiaryStep1Page() : null,
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

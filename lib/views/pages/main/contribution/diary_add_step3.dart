import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDiaryStep3Page extends StatefulWidget {
  @override
  _AddDiaryStep3PageState createState() => _AddDiaryStep3PageState();
}

class _AddDiaryStep3PageState extends State<AddDiaryStep3Page> {
  bool isAddEnabled = true;
  List<int> selectstar = [];
  //File imageURI;
  // late OfferController _con;

  // _AddDiaryStep3PageState() : super(OfferController()) {
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

  AddDiaryStep4Page() {
    Navigator.of(context).pushNamed("/AddDiaryStep4");
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    for (int qindex = 0; qindex < 9; qindex++) {
      setState(() {
          selectstar.add(0);
      });
    }
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep3Page.pickImage(source: ImageSource.gallery);

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
          '総合評価',
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
                  '施術について',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "施術前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 0,
                        selectstar[0] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "施術前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 1,
                        selectstar[1] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "施術前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 2,
                        selectstar[2] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  'クリニックについて',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "院内の雰囲気、設備、清潔感はいかがでしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 3,
                        selectstar[3] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "スタッフの対応はいかがでしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 4,
                        selectstar[4] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "プライバシーへの配慮はいかがでしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 5,
                        selectstar[5] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  'ドクターについて',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "治療前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 6,
                        selectstar[6] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "ご自分の要望・意見を考慮してもらえましたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 7,
                        selectstar[7] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 3.0),
                  child: Text(
                    "術前、術中、術後の対応はいかがでしたか？",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
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
                        i, 8,
                        selectstar[8] > i
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
                  onPressed: isAddEnabled ? () => AddDiaryStep4Page() : null,
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

  Widget Star(int sindex, int qindex, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          selectstar[qindex] = sindex + 1;
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
              "assets/icons/star.svg",
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
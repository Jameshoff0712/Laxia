import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDiaryStep3Page extends StatefulWidget {
  String? diary_id;
  AddDiaryStep3Page({Key? key, this.diary_id = ''}) : super(key: key);
  @override
  _AddDiaryStep3PageState createState() => _AddDiaryStep3PageState();
}

class _AddDiaryStep3PageState extends State<AddDiaryStep3Page> {
  bool isAddEnabled = true;
  bool initDetail = true;
  List<int> selectstar = [];
  // bool isAllSelected = false;
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

  AddDiaryStep4Page({String? diary_id}) {
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
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    for(int i = 0; i < 9; i++){
      if(selectstar[i] == 0) {
        setState(() {
          isAddEnabled = false;
        });
        break;
      }
      else 
        setState(() {
          isAddEnabled = true;
        });
    }
    if(initDetail && widget.diary_id != '') {
      setState(() {
        selectstar = diaryProperties.rates;
        initDetail = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('総合評価',
            style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              
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
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
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
                '施術について',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: Text(
                    "施術前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        0,
                        selectstar[0] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "施術前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        1,
                        selectstar[1] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "施術前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        2,
                        selectstar[2] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 16, bottom: 6),
              child: Text(
                'クリニックについて',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: Text(
                    "院内の雰囲気、設備、清潔感はいかがでしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        3,
                        selectstar[3] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "スタッフの対応はいかがでしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        4,
                        selectstar[4] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "プライバシーへの配慮はいかがでしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        5,
                        selectstar[5] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                'ドクターについて',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: Text(
                    "治療前の説明は十分でしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        6,
                        selectstar[6] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "ご自分の要望・意見を考慮してもらえましたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        7,
                        selectstar[7] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
                  child: Text(
                    "術前、術中、術後の対応はいかがでしたか？",
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 18, 18),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        8,
                        selectstar[8] > i
                            ? Color.fromARGB(255, 242, 201, 76)
                            : Color.fromARGB(255, 222, 222, 222)),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 8,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 85,
                padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(255, 194, 194, 194),
                          ),
                  child: ElevatedButton(
                    onPressed: isAddEnabled ? (){
                      diaryProperties.setRates(selectstar);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDiaryStep4Page(
                            diary_id: widget.diary_id,
                      )));
                     } : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      primary: Helper.mainColor,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                      splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '次に進む',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }

  Widget Star(int sindex, int qindex, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectstar[qindex] = sindex + 1;
        });
      },
      child: Container(
        //decoration: BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/star.svg",
              width: 30,
              height: 30,
              color: color,
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}

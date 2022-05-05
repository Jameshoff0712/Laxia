import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDiaryStep5Page extends StatefulWidget {
  @override
  _AddDiaryStep5PageState createState() => _AddDiaryStep5PageState();
}

class _AddDiaryStep5PageState extends State<AddDiaryStep5Page> {
  bool isNextEnabled = false;
  List<bool> chk_status = [];

  // late OfferController _con;

  // _AddDiaryStep5PageState() : super(OfferController()) {
  //   _con = controller as OfferController;
  // }

  AddDiaryPage() {
    Navigator.of(context).pushNamed("/AddDiaryList");
  }

  DiaryDownloadPage() {
    Navigator.of(context).pushNamed("/AddDiaryList");
  }

  @override
  void initState() {
    setState(() {
      chk_status.add(false);
      chk_status.add(false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ガイドラインの確認',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  title: Text(
                    '投稿・画像削除ガイドライン',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                    'ここにガイドラインの文章を入れるここにガイドライ\nンの文章を入れるここにガイドラインの文章を入れる\nここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れるここにガイドライ\nンの文章を入れるここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れる\nここにガイドラインの文章を入れるここにガイドライ\nンの文章を入れるここにガイドラインの文章を入れる\n'),
              ),
              checkCondition(chk_status[0], 0, 'このガイドラインに同意する'),
              checkCondition(chk_status[1], 1, '口コミ投稿に関してクリニック側から謝礼や割引を得ていない'),
              Container(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 76,
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed:
                          isNextEnabled ? () => AddDiaryPage() : null,
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
                          '口コミを投稿する',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 76,
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () { DiaryDownloadPage(); },
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
                        child: Text(
                          'レポートを下書き保存する',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 110, 198, 210)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkCondition(bool status, int index, String strCondition) {
    return InkWell(
      onTap: () {
        setState(() {
          chk_status[index] = !status;
        });

        if (chk_status[0] && chk_status[1]) {
          setState(() {
            isNextEnabled = true;
          });
        } else {
          setState(() {
            isNextEnabled = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                "assets/icons/check_circle.svg",
                width: 25,
                height: 25,
                color: (status)
                    ? Color.fromARGB(255, 110, 198, 210)
                    : Color.fromARGB(255, 156, 161, 161),
              ),
            ),
            Expanded(child: Text(strCondition)),
          ],
        ),
      ),
    );
  }
}

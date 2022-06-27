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
        title: Text('ガイドラインの確認',
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
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16, top: 24, bottom: 24),
                child: Text('投稿・画像削除ガイドライン',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromARGB(255, 18, 18, 18),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      
                    )),
              ),
              Container(
                height: 500,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                    'ここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れる\nここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れる\nここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れる\nここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\n\nここにガイドラインの文章を入れる\nここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\nここにガイドラインの文章を入れる\nここにガイドラインの文章を入れるここにガイドラインの文章を入れるここにガイドラインの文章を入れる\nここにガイドラインの文章を入れる',
                    style: TextStyle(
                      color: Color.fromARGB(255, 18, 18, 18),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              checkCondition(chk_status[0], 0, 'このガイドラインに同意する'),
              SizedBox(
                height: 20,
              ),
              checkCondition(chk_status[1], 1, '口コミ投稿に関してクリニック側から謝礼や割引を得ていない'),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(255, 194, 194, 194),
                          ),
                  child: ElevatedButton(
                    onPressed: isNextEnabled ? () => AddDiaryPage() : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      primary: Helper.mainColor,
                      onPrimary: Colors.white,
                      onSurface: Color.fromARGB(255, 194, 194, 194),
                      splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '口コミを投稿する',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(255, 194, 194, 194),
                          ),
                  child: ElevatedButton(
                    onPressed: () {
                      DiaryDownloadPage();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      side: const BorderSide(
                          color: Helper.mainColor,
                          width: 2,
                          style: BorderStyle.solid),
                      primary: Colors.white,
                      onPrimary: Helper.mainColor,
                      onSurface: Color.fromARGB(255, 194, 194, 194),
                      splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'レポートを下書き保存する',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkCondition(bool status, int index, String strCondition) {
    return GestureDetector(
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
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(right: 12),
              child: SvgPicture.asset(
                "assets/icons/check_circle.svg",
                width: 15,
                height: 15,
                color: (status)
                    ? Helper.mainColor
                    : Color.fromARGB(255, 156, 161, 161),
              ),
            ),
            Expanded(
                child: Text(strCondition,
                    style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      
                    ))),
          ],
        ),
      ),
    );
  }
}

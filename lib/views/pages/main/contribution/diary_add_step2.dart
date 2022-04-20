import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step4.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddDiaryStep2Page extends StatefulWidget {
  final bool? isMyDiary;
  const AddDiaryStep2Page({Key? key, this.isMyDiary = false}) : super(key: key);
  @override
  _AddDiaryStep2PageState createState() => _AddDiaryStep2PageState();
}

class _AddDiaryStep2PageState extends State<AddDiaryStep2Page> {
  bool isAddEnabled = true;
  //File imageURI;
  // late OfferController _con;

  // _AddDiaryStep2PageState() : super(OfferController()) {
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

  AddDiaryStep3Page() {
    Navigator.of(context).pushNamed("/AddDiaryStep3");
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep2Page.pickImage(source: ImageSource.gallery);

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
          '施術費用を入力',
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
                  '施術費用',
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
                  padding: const EdgeInsets.fromLTRB(0.0, 3.0, 18.0, 3.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "腫れづらいスクエア二施術",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text('円')
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
                  padding: const EdgeInsets.fromLTRB(0.0, 3.0, 18.0, 3.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "麻酔費用",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text('円')
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
                  padding: const EdgeInsets.fromLTRB(0.0, 3.0, 18.0, 3.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "処方薬の費用",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text('円')
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
                  padding: const EdgeInsets.fromLTRB(0.0, 3.0, 18.0, 3.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "その他の費用",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text('円')
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
                  padding: const EdgeInsets.fromLTRB(0.0, 17.0, 18.0, 17.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "合計金額: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "0",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "円",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ]),
                ),
              ),
            ),
            !widget.isMyDiary!
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 76,
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed:
                            isAddEnabled ? () => AddDiaryStep3Page() : null,
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
                            style: TextStyle(fontSize: 18),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddDiaryStep4Page(
                                    isMyDiary: widget.isMyDiary)));
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
}

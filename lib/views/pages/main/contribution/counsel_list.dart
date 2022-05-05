import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/widgets/counsel_card.dart';

class AddCounselPage extends StatefulWidget {
  @override
  _AddCounselPageState createState() => _AddCounselPageState();
}

class _AddCounselPageState extends State<AddCounselPage> {
  @override
  void initState() {
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
          'カウンセリングレポート',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/AddCounselStep1");
                  },
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '新しくレポートを作成',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            counseling_list.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: ListTile(
                      title: Text(
                        '全てのカウンセリングレポート',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : SizedBox(),
            Column(
              children: [
                // menuAppBar(context),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: counseling_list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CounselAddPage_Card(
                        avator: counseling_list[index]["avator"],
                        name: counseling_list[index]["name"],
                        image1: counseling_list[index]["image1"],
                        image2: counseling_list[index]["image2"],
                        sentence: counseling_list[index]["sentence"],
                        clinic: counseling_list[index]["clinic"],
                        type: counseling_list[index]["type"],
                        check: counseling_list[index]["check"],
                        eyes: counseling_list[index]["eyes"],
                        onpress: () {},
                        price: counseling_list[index]["price"],
                        buttontext: counseling_list[index]["status"],
                        fontcolor: (counseling_list[index]["status"] == "未公開"
                            ? Color.fromARGB(255, 102, 110, 110)
                            : Color.fromARGB(255, 240, 154, 55)),
                        buttoncolor: (counseling_list[index]["status"] == "未公開"
                            ? Color.fromARGB(50, 102, 110, 110)
                            : Color.fromARGB(50, 240, 154, 55)),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

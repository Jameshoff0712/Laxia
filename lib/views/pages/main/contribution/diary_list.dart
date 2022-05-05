import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diary_addpage_card.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
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
          '日記を投稿する',
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
                    Navigator.of(context).pushNamed("/AddDiaryStep1");
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
                          '新しい日記を投稿',
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
            diary_list.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: ListTile(
                      title: Text(
                        '全ての日記',
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
                    itemCount: diary_list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return DiaryAddPage_Card(
                        avator: diary_list[index]["avator"],
                        name: diary_list[index]["name"],
                        image1: diary_list[index]["image1"],
                        image2: diary_list[index]["image2"],
                        sentence: diary_list[index]["sentence"],
                        clinic: diary_list[index]["clinic"],
                        type: diary_list[index]["type"],
                        check: diary_list[index]["check"],
                        eyes: diary_list[index]["eyes"],
                        onpress: () {},
                        price: diary_list[index]["price"],
                        buttontext: diary_list[index]["status"],
                        fontcolor: (diary_list[index]["status"] == "未公開"
                            ? Color.fromARGB(255, 102, 110, 110)
                            : Color.fromARGB(255, 240, 154, 55)),
                        buttoncolor: (diary_list[index]["status"] == "未公開"
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

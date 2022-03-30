import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:laxia/models/counsel_model.dart';
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
          style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
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
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed("/TreatmentPart"),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: ListTile(
              title: Text(
                '全てのカウンセリングレポート',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: ListView.builder(
                        itemCount: Counsel_list.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CounselAddPage_Card(
                            avator: Counsel_list[index].avator,
                            name: Counsel_list[index].name,
                            image1: Counsel_list[index].image1,
                            image2: Counsel_list[index].image2,
                            sentence: Counsel_list[index].sentence,
                            clinic: Counsel_list[index].clinic,
                            type: Counsel_list[index].type,
                            check: Counsel_list[index].check,
                            eyes: Counsel_list[index].eyes,
                            onpress: () {},
                            price: Counsel_list[index].price,
                            buttontext: Counsel_list[index].status,
                            fontcolor: (Counsel_list[index].status == "未公開" ? Color.fromARGB(255, 102, 110, 110) : Color.fromARGB(255, 240, 154, 55)),
                            buttoncolor: (Counsel_list[index].status == "未公開" ? Color.fromARGB(50, 102, 110, 110) : Color.fromARGB(50, 240, 154, 55)),
                          );
                        }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class AddDiaryProgressPage extends StatefulWidget {
  @override
  _AddDiaryProgressPageState createState() => _AddDiaryProgressPageState();
}

class _AddDiaryProgressPageState extends State<AddDiaryProgressPage> {
  bool isAddEnabled = true;

  AddDiaryPage() {
    Navigator.of(context).pushNamed("/AddDiaryList");
  }

  void onDonePress() {
    // Do what you want
    print("End of slides");
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryProgressPage.pickImage(source: ImageSource.gallery);

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
          '術後経過を入力',
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
                  '施術日からの経過日数',
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 14.0, 18.0, 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "経過日数",
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
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  '経過写真',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            imagePicker(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  '施術箇所の具合',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            stateSlider(context, '痛み'),
            stateSlider(context, '腫れ'),
            stateSlider(context, '傷あと'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  '経過日記',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (text) {
                  if (text.isNotEmpty) {
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
                  hintText: '例)施術5日目の経過です。腫れもだいふひいてきました。',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 76,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () => AddDiaryPage() : null,
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
                      '施術経過を投稿する',
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
                      "icons/photo.svg",
                      width: 36,
                      height: 36,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:
                          Text('写真を追加', style: TextStyle(color: Colors.white)),
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

  Widget stateSlider(BuildContext context, String posStr) {
    return Container(
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 0, bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(right: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(padding: EdgeInsets.only(right: 10), child: Text(posStr)),
            Expanded(
              //height: 80,
              //padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlutterSlider(
                jump: true,
                values: [0],
                min: 0,
                max: 100,
                fixedValues: [
                  FlutterSliderFixedValue(percent: 0, value: ""),
                  FlutterSliderFixedValue(percent: 33, value: ""),
                  FlutterSliderFixedValue(percent: 66, value: ""),
                  FlutterSliderFixedValue(percent: 100, value: ""),
                ],
                // ignoreSteps: [
                //   FlutterSliderIgnoreSteps(from: 1, to: 32),
                //   FlutterSliderIgnoreSteps(from: 33, to: 65),
                //   FlutterSliderIgnoreSteps(from: 67, to: 99),
                // ],
                step: FlutterSliderStep(step: 33),
                handlerWidth: 25,
                hatchMark: FlutterSliderHatchMark(
                  linesDistanceFromTrackBar: -12,
                  labelsDistanceFromTrackBar: -50,
                  density: 0.15,
                  displayLines: true,
                  bigLine: FlutterSliderSizedBox(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20))),
                  smallLine: FlutterSliderSizedBox(height: 1, width: 1),
                  labels: [
                    FlutterSliderHatchMarkLabel(
                        percent: 0,
                        label: Text('なし', style: TextStyle(fontSize: 10))),
                    FlutterSliderHatchMarkLabel(
                        percent: 33,
                        label: Text('少しある', style: TextStyle(fontSize: 10))),
                    FlutterSliderHatchMarkLabel(
                        percent: 66,
                        label: Text('ある', style: TextStyle(fontSize: 10))),
                    FlutterSliderHatchMarkLabel(
                        percent: 100,
                        label: Text('かなりある', style: TextStyle(fontSize: 10))),
                  ],
                ),
                //rangeSlider: true,
                //visibleTouchArea: true,
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBarHeight: 5,
                  activeTrackBarHeight: 5,
                  activeTrackBarDraggable: true,
                  inactiveTrackBar: BoxDecoration(color: Colors.black12),
                  activeTrackBar: BoxDecoration(color: Colors.black12),
                ),
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 0, 184, 169),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                selectByTap: true,
                onDragging: (handlerIndex, lowerValue, upperValue) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DiaryDetailFixPage extends StatefulWidget {
  const DiaryDetailFixPage({Key? key}) : super(key: key);

  @override
  State<DiaryDetailFixPage> createState() => _DiaryDetailFixPageState();
}

class _DiaryDetailFixPageState extends State<DiaryDetailFixPage> {
  int currentSlider = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: '',
                        placeholder: (context, url) => Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: [
                      Text(
                        "たっきーの二重施術日記",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          height: 1.5,
                          color: Helper.titleColor,
                        ),
                      ),
                      Text(
                        "施術 2020/03/1 経過 150日",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 8,
                          height: 1.5,
                          color: Helper.txtColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      primary: Color.fromARGB(255, 249, 161, 56),
                      onPrimary: Colors.white,
                      onSurface: Color.fromARGB(255, 110, 198, 210),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "投稿を修正",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5,
                              color: Helper.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    "icons/upright.svg",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  ImageSlideshow(
                    width: double.infinity,
                    height: 480,
                    initialPage: 0,
                    indicatorColor: Colors.blue,
                    indicatorBackgroundColor: Colors.grey,
                    onPageChanged: (value) {
                      setState(() {
                        currentSlider = value + 1;
                      });
                    },
                    autoPlayInterval: 3000,
                    isLoop: true,
                    children: [
                      for (int j = 0; j < 5; j++)
                        Image.asset(
                          'images/canada.png',
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(179, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "$currentSlider/5",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.5,
                            color: Helper.whiteColor),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "二重整形150日後の経過日記",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            height: 1.5,
                            color: Color.fromARGB(255, 31, 31, 31)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("");
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            side: const BorderSide(
                                color: Helper.mainColor,
                                width: 2,
                                style: BorderStyle.solid),
                            primary: Colors.white,
                            onPrimary: Colors.white,
                            onSurface: Helper.mainColor,
                          ),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '二重埋没',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Helper.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("");
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            side: const BorderSide(
                                color: Helper.mainColor,
                                width: 2,
                                style: BorderStyle.solid),
                            primary: Colors.white,
                            onPrimary: Colors.white,
                            onSurface: Helper.mainColor,
                          ),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '目頭切開',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Helper.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: Container(
                        padding: const EdgeInsets.only(right: 25),
                        child: Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text('痛み')),
                            Expanded(
                              //height: 80,
                              //padding: EdgeInsets.symmetric(horizontal: 10),
                              child: FlutterSlider(
                                jump: true,
                                values: [0],
                                min: 0,
                                max: 100,
                                fixedValues: [
                                  FlutterSliderFixedValue(
                                      percent: 0, value: ""),
                                  FlutterSliderFixedValue(
                                      percent: 33, value: ""),
                                  FlutterSliderFixedValue(
                                      percent: 66, value: ""),
                                  FlutterSliderFixedValue(
                                      percent: 100, value: ""),
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
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  smallLine: FlutterSliderSizedBox(
                                      height: 1, width: 1),
                                  labels: [
                                    FlutterSliderHatchMarkLabel(
                                        percent: 0,
                                        label: Text('なし',
                                            style: TextStyle(fontSize: 10))),
                                    FlutterSliderHatchMarkLabel(
                                        percent: 33,
                                        label: Text('少しある',
                                            style: TextStyle(fontSize: 10))),
                                    FlutterSliderHatchMarkLabel(
                                        percent: 66,
                                        label: Text('ある',
                                            style: TextStyle(fontSize: 10))),
                                    FlutterSliderHatchMarkLabel(
                                        percent: 100,
                                        label: Text('かなりある',
                                            style: TextStyle(fontSize: 10))),
                                  ],
                                ),
                                //rangeSlider: true,
                                //visibleTouchArea: true,
                                trackBar: FlutterSliderTrackBar(
                                  inactiveTrackBarHeight: 5,
                                  activeTrackBarHeight: 5,
                                  activeTrackBarDraggable: true,
                                  inactiveTrackBar:
                                      BoxDecoration(color: Colors.black12),
                                  activeTrackBar:
                                      BoxDecoration(color: Colors.black12),
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
                                onDragging:
                                    (handlerIndex, lowerValue, upperValue) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                "icons/menubar/heart.svg",
                                width: 25,
                                height: 25,
                              ),
                              Text(
                                '223',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  height: 1.5,
                                  color: Helper.txtColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                "icons/menubar/star.svg",
                                width: 25,
                                height: 25,
                              ),
                              Text(
                                'お気に入り',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  height: 1.5,
                                  color: Helper.txtColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              SvgPicture.asset(
                                "icons/menubar/comment.svg",
                                width: 25,
                                height: 25,
                              ),
                              Text(
                                '20',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  height: 1.5,
                                  color: Helper.txtColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fillColor: Color.fromARGB(255, 243, 243, 243),
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                              onChanged: (text) {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

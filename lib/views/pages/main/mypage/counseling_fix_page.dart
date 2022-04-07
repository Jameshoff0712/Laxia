import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';

class CounselingFixPage extends StatefulWidget {
  const CounselingFixPage({Key? key}) : super(key: key);

  @override
  State<CounselingFixPage> createState() => _CounselingFixPageState();
}

class _CounselingFixPageState extends State<CounselingFixPage> {
  List lImageList = [];

  @override
  void initState() {
    super.initState();

    lImageList = [
      "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg",
      "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-2.jpg",
      "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
      "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-4.jpg"
    ];
  }

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
                  "assets/icons/upright.svg",
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "二重切開(施術名)東京中央美容外科のカウンセリング",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.4,
                  color: Helper.titleColor,
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                height: 25,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Helper.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 0), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                    ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/menubar/clinic.svg",
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "湘南美容クリニック 新宿院",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.5,
                            color: Helper.mainColor,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(width: double.infinity),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Helper.mainColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 246, 246),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/menubar/part.svg",
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "田中圭 医師",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.5,
                            color: Helper.mainColor,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(width: double.infinity),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Helper.mainColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "どんなことで悩んでいたのか？",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 1.5,
                    color: Helper.titleColor,
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "笑った時や目をぎゅっと閉じた時に涙袋を書くから涙袋が2つあるみたいになる皮膚のたるみが出る前に取りたい\n笑った時や目をぎゅっと閉じた時に涙袋を書くから涙袋が2つあるみたいになる皮膚のたるみが出る前に取りたい",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                  color: Helper.titleColor,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "自分の写真",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5,
                      color: Helper.titleColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //PhotoCarouselWidget(offerList: _con.offers, heroTag: 'offer_trending_carousel'),
                              PhotoCarouselWidget(ImageList: lImageList ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "理想の写真",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5,
                      color: Helper.titleColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //PhotoCarouselWidget(offerList: _con.offers, heroTag: 'offer_trending_carousel'),
                              PhotoCarouselWidget(ImageList: lImageList ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

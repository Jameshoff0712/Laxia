import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxia/common/helper.dart';

class DiaryFixPage extends StatefulWidget {
  const DiaryFixPage({Key? key}) : super(key: key);

  @override
  State<DiaryFixPage> createState() => _DiaryFixPageState();
}

class _DiaryFixPageState extends State<DiaryFixPage> {
  bool isVisible = false;
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
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image(
                                image: AssetImage(
                                  'images/user/eyebefore.jpg',
                                ),
                              )),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.zero),
                              color: Color.fromARGB(128, 0, 0, 0),
                            ),
                            alignment: AlignmentDirectional.bottomStart,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Before",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    height: 1.5,
                                    color: Helper.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image(
                                image: AssetImage(
                                  'images/user/eyeafter.jpg',
                                ),
                              )),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.zero),
                              color: Color.fromARGB(128, 0, 0, 0),
                            ),
                            alignment: AlignmentDirectional.bottomStart,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "After",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    height: 1.5,
                                    color: Helper.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    '施術の満足度',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 1.5,
                      color: Helper.mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 206, 176, 88),
                      size: 15,
                    ),
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      height: 1.5,
                      color: Helper.titleColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
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
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "クイックコスメティーク法",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Helper.titleColor,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "240,000円",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          height: 1.5,
                                          color:
                                              Color.fromARGB(255, 249, 161, 56),
                                        ),
                                      ),
                                      Text(
                                        "（税込）",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          height: 1.5,
                                          color: Helper.titleColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed("");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      primary: Color.fromARGB(255, 249, 161, 56),
                                      onPrimary: Colors.white,
                                      onSurface:
                                          Color.fromARGB(255, 110, 198, 210),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "予約",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 8,
                                              height: 1.5,
                                              color: Helper.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
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
                  "クリニック・メニューについて",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 1.5,
                    color: Color.fromARGB(255, 31, 31, 31),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/menubar/ping.svg",
                          width: 14,
                          height: 14,
                          color: Helper.mainColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "あやか",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.5,
                            color: Helper.titleColor,
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "あやか",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: Helper.titleColor,
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                          )),
                          Text(
                            "24000",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: Helper.titleColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "さらに表示",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: Helper.mainColor,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Helper.mainColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

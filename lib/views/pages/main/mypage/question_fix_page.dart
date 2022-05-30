import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';

class QuestionFixPage extends StatefulWidget {
  const QuestionFixPage({Key? key}) : super(key: key);

  @override
  State<QuestionFixPage> createState() => _QuestionFixPageState();
}

class _QuestionFixPageState extends State<QuestionFixPage> {
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
                        
                        color: Helper.titleColor,
                      ),
                    ),
                    Text(
                      "施術 2020/03/1 経過 150日",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                        
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
            child: Column(children: [
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
                height: 20,
              ),
              Text(
                "4,5ヶ月前に瞼の脂肪吸引・埋没を行ったのですが、瞼は以前同様腫れぼったく、二重も線が薄く元の奥二重線の方が強く残り、三重のようになっています。\nたしか保証は付けていなかったのですが、あまりにも変な仕上がりになってしまったのでなおしたいです。\n抜糸は、同じだけの金額や腫れがかかってしまうのでしょうか？\nまた、これから三重の状態が綺麗な二重になる可能性はあるのでしょうか？",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                  color: Helper.titleColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PhotoCarouselWidget(ImageList: lImageList,bRemove: false, onRemove: (int ) {  }, ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'コメント',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    
                    color: Helper.titleColor,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 27,
                    width: 27,
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
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 27,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 231, 231, 231),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 231, 231, 231),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          fillColor: Color.fromARGB(255, 243, 243, 243),
                          filled: true,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (text) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/menubar/heart.svg",
                          width: 25,
                          height: 25,
                        ),
                        Text(
                          '223',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            
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
                          "assets/icons/menubar/star.svg",
                          width: 25,
                          height: 25,
                        ),
                        Text(
                          'お気に入り',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            
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
                          "assets/icons/menubar/comment.svg",
                          width: 25,
                          height: 25,
                        ),
                        Text(
                          '20',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            
                            color: Helper.txtColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 30,
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
                            
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}

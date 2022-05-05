import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/instructions.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/diary_medialist.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/post_treatment_card.dart';

class Diary_Detail extends StatefulWidget {
  final bool? isMyDiary;
  const Diary_Detail({ Key? key, this.isMyDiary = false }) : super(key: key);

  @override
  State<Diary_Detail> createState() => _Diary_DetailState();
}

class _Diary_DetailState extends State<Diary_Detail> {
   List diary_Details = [];
  bool isfavourite = false,isVisible=false,isPostVisible=false,isStar = false;

  Future<void> get_question_info() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_diary.json");
    setState(() {
      diary_Details.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    get_question_info();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return diary_Details.isNotEmpty? Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap:(){
                    Navigator.of(context).pushNamed("/Mypage");
                  },
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: diary_Details[0]["avator"],
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
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diary_Details[0]["name"],
                      style: TextStyle(
                          color: Helper.titleColor, fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    Row(
                      children: [
                        Text(
                          "施術",
                          style: TextStyle(
                              color: Helper.maintxtColor, fontWeight: FontWeight.bold,fontSize: 8),
                        ),
                        Text(
                          diary_Details[0]["start"],
                          style: TextStyle(
                              color: Helper.maintxtColor, fontWeight: FontWeight.w400,fontSize: 8),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          "経過",
                          style: TextStyle(
                              color: Helper.maintxtColor, fontWeight: FontWeight.bold,fontSize: 8),
                        ),
                        Text(
                          diary_Details[0]["end"]+"日",
                          style: TextStyle(
                              color: Helper.maintxtColor, fontWeight: FontWeight.w400,fontSize: 8),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                !widget.isMyDiary! ?
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 110, 198, 210),
                        width: 2,
                        style: BorderStyle.solid),
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    onSurface: Color.fromARGB(255, 110, 198, 210),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'フォロー',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 110, 198, 210)),
                        ),
                      ],
                    ),
                  ),
                )
                : ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDiaryStep1Page(isMyDiary: widget.isMyDiary)));
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
                  "assets/icons/upright_nobg.svg",
                  width: 20,
                  height: 20,
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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          height: 60,
          decoration: BoxDecoration(color: Helper.whiteColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isStar = !isStar;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isStar
                        ? Icon(
                            Icons.star,
                            color: Helper.btnBgYellowColor,
                            size: 30,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Helper.txtColor,
                            size: 30,
                          ),
                    Text(
                      "お気に入り",
                      style: TextStyle(
                          color: isStar
                              ? Helper.btnBgYellowColor
                              : Helper.txtColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isfavourite = !isfavourite;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isfavourite
                        ? Icon(
                            Icons.favorite,
                            color: Helper.btnBgYellowColor,
                            size: 30,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Helper.txtColor,
                            size: 30,
                          ),
                    Text(
                      "223",
                      style: TextStyle(
                          color: isfavourite
                              ? Helper.btnBgYellowColor
                              : Helper.txtColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Helper.btnBgYellowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "同じクリニックを予約",
                      style: defaultTextStyle(Helper.whiteColor, FontWeight.w700,
                          size: 14),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/Reservation");
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            decoration:BoxDecoration(color: Helper.whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3.5,
                      crossAxisSpacing: 7,
                      crossAxisCount: 2,
                      childAspectRatio: 1),
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget(onBoardingInstructions: [
                              diary_Details[0]["image1"],
                            ],
                            startindex: 1,)));
                      },
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              width: 426,
                              height: 426,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: diary_Details[0]["image1"],
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/loading.gif',
                                    fit: BoxFit.fill,
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Helper.blackColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30))),
                                child: Center(
                                  child: Text(
                                    "Before",
                                    style: TextStyle(
                                        color: Helper.whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget( onBoardingInstructions: [
                              diary_Details[0]["image1"],
                            ],
                            startindex: 1,)));
                      },
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              width: 426,
                              height: 426,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: diary_Details[0]["image2"],
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/loading.gif',
                                    fit: BoxFit.fill,
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Helper.blackColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30))),
                                child: Center(
                                  child: Text(
                                    "After",
                                    style: TextStyle(
                                        color: Helper.whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                 alignment: WrapAlignment.start,
                runSpacing: 10,
                spacing: 10,
                children: [
                for(int i=0;i<diary_Details[0]["treatment"].length;i++)
                InkWell(
                  onTap: () {
                    //
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                22),
                        border: Border.all(
                            width: 1,
                            color:Helper.mainColor),
                        color: Helper.whiteColor),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3),
                      child: Text(
                        diary_Details[0]["treatment"][i]["label"],
                        style: TextStyle(
                            fontWeight:
                                FontWeight.w400,
                            fontSize: 12,
                            color:Helper.mainColor),
                      ),
                    ),
                  ),
                )
              ],),    
              Row(
                children: [
                  Text(
                    "施術の満足度",
                    style: defaultTextStyle(Helper.mainColor, FontWeight.w700,
                        size: 16.0),
                  ),
                  SizedBox(width: 12,),
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 18,
                    ),
                     SizedBox(width: 12,),
                  Text(
                      diary_Details[0]["mark"],
                    style: defaultTextStyle(
                        Helper.titleColor, FontWeight.w700,
                        size: 14.0),
                  ),
              ],),
              CureMethod_Card(
                  image:  diary_Details[0]["image"],
                  heading:  diary_Details[0]["heading"],
                  price:  diary_Details[0]["price"],
                  tax:  diary_Details[0]["tax"],
                  clinic:  diary_Details[0]["clinic"],
                  doctor:  diary_Details[0]["check"]),
              SizedBox(height: 24,),
              Text(
                 "クリニック・メニューについて",
                style: defaultTextStyle(
                    Color.fromARGB(255, 31, 31, 31), FontWeight.w700,
                    size: 18.0),
              ),
              SizedBox(height: 8,),
              Container(
                padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/tag_fill.svg",
                          width: 14,
                          height: 14,
                          color: Helper.mainColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          diary_Details[0]["clinic_menu"][0]["label"],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            
                            color: Helper.titleColor,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                      child: Container(
                          child: Column(children: [
                            for(int i=0;i<diary_Details[0]["clinic_menu"][0]["list"].length;i++)
                              Container(
                                child: Row(children: [
                                  Text(
                                    diary_Details[0]["clinic_menu"][0]["list"][i]["label"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      
                                      color: Helper.maintxtColor,
                                    ),
                                  ),
                                  Expanded(child: SizedBox(width: 0,)),
                                  Text(
                                    diary_Details[0]["clinic_menu"][0]["list"][i]["value"].toString()+"円",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      
                                      color: Helper.maintxtColor,
                                    ),
                                  ),
                                ],),
                              ),
                            
                          ],),
                      ),
                    ),                     
                  ],
                ),
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: isVisible ? null : 0.0,
                  child: Column(
                    children: [
                      SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/tag_fill.svg",
                                  width: 14,
                                  height: 14,
                                  color: Helper.mainColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  diary_Details[0]["clinic_menu"][1]["label"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                              child:Text(
                                diary_Details[0]["clinic_menu"][1]["description"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  
                                  color: Helper.maintxtColor,
                                ),
                              ),
                            ),                     
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                        child: Column( 
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/tag_fill.svg",
                                  width: 14,
                                  height: 14,
                                  color: Helper.mainColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  diary_Details[0]["clinic_menu"][2]["label"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                              child: Container(
                                width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    for(int i=0;i<diary_Details[0]["clinic_menu"][2]["list"].length;i++)
                                      Container(
                                        child: Text(
                                          "・"+diary_Details[0]["clinic_menu"][2]["list"][i],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Helper.maintxtColor,
                                          ),
                                        ),
                                      ),
                                    
                                  ],),
                              ),
                            ),                     
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/tag_fill.svg",
                                  width: 14,
                                  height: 14,
                                  color: Helper.mainColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  diary_Details[0]["clinic_menu"][3]["label"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                              child:Text(
                                diary_Details[0]["clinic_menu"][3]["description"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  
                                  color: Helper.maintxtColor,
                                ),
                              ),
                            ),                     
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/tag_fill.svg",
                                  width: 14,
                                  height: 14,
                                  color: Helper.mainColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  diary_Details[0]["clinic_menu"][4]["label"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                              child:Text(
                                diary_Details[0]["clinic_menu"][4]["description"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Helper.maintxtColor,
                                ),
                              ),
                            ),                     
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        
                        color: Helper.mainColor,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Icon(
                      isVisible?Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,
                      color: Helper.mainColor,
                    )
                  ],
                ),
              ),
              SizedBox(height: 19,),
              Text(
                "施術前",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Helper.titleColor,
                ),
              ),
              SizedBox(height: 4,),
              Container(
                alignment: Alignment.center,
                height: 120,
                child: GridView.builder(
                  scrollDirection:Axis.horizontal,
                  itemCount:3,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 1,
                        childAspectRatio: 1),
                    itemBuilder:  (BuildContext context, int index){
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => Diary_MediaList(post_treatment:  diary_Details[0]["post-treatment"], before: {"label":"施術前","images":diary_Details[0]["before_image"]["images"]},)));
                        },
                        child: SizedBox(
                          height: 78,
                          width: 78,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:  diary_Details[0]["before_image"]["images"][index],
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                  }),
              ),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "施術後の経過",
                    style: TextStyle(
                        color: Helper.titleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                      decoration:BoxDecoration( color: Color.fromARGB(255, 245, 245, 245),borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              "新しい順",
                              style: TextStyle(
                                  color: Helper.titleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: 6,),
                            Icon(
                              FontAwesomeIcons.syncAlt,
                              size: 15,
                              color:Helper.titleColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                child: ListView.builder(
                  itemCount:!isPostVisible?3: diary_Details[0]["post-treatment"].length,
                  physics:NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemBuilder: (BuildContext context, int index) {
                    return Post_Treatment_Card(post_treatment:diary_Details[0]["post-treatment"][index]);
                  }
                ),
              ),
              GestureDetector(
                      onTap: (){
                        setState(() {
                          isPostVisible = !isPostVisible;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "すべての日記を表示",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              
                              color: Helper.mainColor,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(
                            isPostVisible?Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,
                            color: Helper.mainColor,
                          )
                        ],
                      ),
                    ),
              SizedBox(height: 19,),
              Text(
                "この施術の日記",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Helper.titleColor,
                ),
              ),
              SizedBox(height: 4,),
              Container(
                decoration: BoxDecoration(color: Helper.homeBgColor),
                child: Column(children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:175/291,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: diary_Details[0]["home"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Home_Card(
                        onpress: () {
                      },
                        title: diary_Details[0]["home"][index]["title"],
                        type: diary_Details[0]["home"][index]["type"],
                        clinic: diary_Details[0]["home"][index]["clinic"],
                        recommend: diary_Details[0]["home"][index]["recommend"],
                        source: diary_Details[0]["home"][index]["source"],
                        name: diary_Details[0]["home"][index]["name"],
                        doctorimage: diary_Details[0]["home"][index]["doctorimage"],
                        chat: diary_Details[0]["home"][index]["chat"],
                      );
                    }),
                ],),
              )
            ],),
          ),
        ),
      ),
    ):Scaffold();
  }
}
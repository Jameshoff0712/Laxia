import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/models/instructions.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/diary_medialist.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/post_treatment_card.dart';

class Diary_Detail extends StatefulWidget {
  final bool? isMyDiary;
  final int index;
  const Diary_Detail({ Key? key, this.isMyDiary = false, required this.index }) : super(key: key);

  @override
  State<Diary_Detail> createState() => _Diary_DetailState();
}

class _Diary_DetailState extends State<Diary_Detail> {
 bool isVisible=false,isPostVisible=false;
 bool isloading = true,isfavorite=false, islike=false;
  final _con = HomeController();
  late DiaryDetail_Model diary_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getDiaryDetail(index: index);
      setState(() {
        diary_detail = mid;
         isfavorite=diary_detail.diary.is_favorite==null?false:diary_detail.diary.is_favorite!;
         islike=diary_detail.diary.is_like!;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> postToogleFavorite(index) async {
    try {
      final res=await _con.postToogleFavorite(index:index, domain: 'diaries');
      if(res==true){
        setState(() {
          isfavorite=!isfavorite;
        });
      }
    } catch (e) {
    }
  }
  Future<void> postToogleLike(index) async {
    try {
      final res=await _con.postToogleLike(index:index, domain: 'diaries');
      if(res==true){
        setState(() {
          islike=!islike;
        });
      }
    } catch (e) {
    }
  }
  @override
  void initState() {
    getData(index: widget.index);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    :Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
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
                        imageUrl: diary_detail.owner.photo==null?"http://error.png":diary_detail.owner.photo!,
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
                      diary_detail.owner.name==null?"":diary_detail.owner.name!,
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
                          diary_detail.diary.treat_date==null?"":diary_detail.diary.treat_date!,
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
                          '150'+"日", //diary_detail["end"]
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
                            
                            color: Color.fromARGB(255, 26, 16, 16),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16.5,),
              GestureDetector(
                onTap: () {
                  postToogleLike(widget.index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    islike
                        ? Icon(
                            Icons.star,
                            color: Helper.starColor,
                            size: 22,
                          )
                        : Icon(
                            Icons.star_border,
                            color: Helper.txtColor,
                            size: 22,
                          ),
                    Text(
                      "お気に入り",
                      style: TextStyle(
                          color: islike
                              ? Helper.starColor
                              : Helper.txtColor,
                          fontSize: 10,
                          
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 26.5,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    postToogleFavorite(widget.index);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isfavorite
                        ? Icon(
                            Icons.favorite,
                            color: Helper.btnBgYellowColor,
                            size: 22,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Helper.txtColor,
                            size: 22,
                          ),
                    Text(
                      diary_detail.diary.likes_count==null?"":diary_detail.diary.likes_count.toString(),
                      style: TextStyle(
                          color: isfavorite
                              ? Helper.btnBgYellowColor
                              : Helper.txtColor,
                          fontSize: 10,
                          
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 29,),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "同じクリニックを予約",
                        style: defaultTextStyle(Helper.whiteColor, FontWeight.w700,
                            size: 16),
                      ),
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
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget(onBoardingInstructions: [
                                  diary_detail.medias!.isEmpty?"http://": diary_detail.medias![0].path,
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
                                  imageUrl:diary_detail.medias!.isEmpty?"http://":  diary_detail.medias![0].path,
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
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget( onBoardingInstructions: [
                                  (diary_detail.medias!.length<=2)?"http://": diary_detail.medias![1].path,
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
                                  imageUrl:(diary_detail.medias!.length<=2)?"http://": diary_detail.medias![1].path,
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
                for(int i=0;i<diary_detail.diary.categories!.length;i++)
                GestureDetector(
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
                        diary_detail.diary.categories![i].name,
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
                      "4.8",// ' diary_detail["mark"]',
                    style: defaultTextStyle(
                        Helper.titleColor, FontWeight.w700,
                        size: 14.0),
                  ),
              ],),
              CureMethod_Card(
                  image:"http://error.png",//  diary_detail["image"],
                  heading:"クイックコスメティーク法",// ' diary_detail["heading"]',
                  price:"240,000",// ' diary_detail["price"]',
                  tax: "（税込）",//  'diary_detail["tax"]',
                  clinic:"湘南美容クリニック 新宿院" ,//' diary_detail["clinic"]',
                  doctor:  diary_detail.diary.doctor_name==null?"":diary_detail.diary.doctor_name!),
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
                         ' 施術費用',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            
                            color: Helper.titleColor,
                          ),
                        )
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                    //   child: Container(
                    //       child: Column(children: [
                    //         for(int i=0;i<diary_detail["clinic_menu"][0]["list"].length;i++)
                    //           Container(
                    //             child: Row(children: [
                    //               Text(
                    //                 diary_detail["clinic_menu"][0]["list"][i]["label"],
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w700,
                    //                   fontSize: 16,
                                      
                    //                   color: Helper.maintxtColor,
                    //                 ),
                    //               ),
                    //               Expanded(child: SizedBox(width: 0,)),
                    //               Text(
                    //                 diary_detail["clinic_menu"][0]["list"][i][" "].toString()+"円",
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w700,
                    //                   fontSize: 16,
                                      
                    //                   color: Helper.maintxtColor,
                    //                 ),
                    //               ),
                    //             ],),
                    //           ),
                            
                    //       ],),
                    //   ),
                    // ),                     
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
                      for(int i=0;i<diary_detail.text_questions.length;i++)
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
                                 diary_detail.text_questions[i].name!,
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
                                diary_detail.text_questions[i].pivot!.answer==null?"":diary_detail.text_questions[i].pivot!.answer!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Helper.maintxtColor,
                                ),
                              ),
                            ),         
                             SizedBox(height: 8,),            
                          ],
                        ),
                      ),
                     
                      // Container(
                      //   padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                      //   child: Column( 
                      //     children: [
                      //       Row(
                      //         children: [
                      //           SvgPicture.asset(
                      //             "assets/icons/tag_fill.svg",
                      //             width: 14,
                      //             height: 14,
                      //             color: Helper.mainColor,
                      //           ),
                      //           SizedBox(
                      //             width: 6,
                      //           ),
                      //           Text(
                      //            "このクリニック、ドクターを選んだ理由は？",
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w700,
                      //               fontSize: 14,
                                    
                      //               color: Helper.titleColor,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                      //         child:Text(
                      //           diary_detail.text_questions.isEmpty?"":diary_detail.text_questions[1].name!,
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.w700,
                      //             fontSize: 14,
                                  
                      //             color: Helper.maintxtColor,
                      //           ),
                      //         ),
                      //       ), 
                      //       // Padding(
                      //       //   padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:8),
                      //       //   child: Container(
                      //       //     width: double.infinity,
                      //       //       child: Column(
                      //       //         crossAxisAlignment: CrossAxisAlignment.start,
                      //       //         children: [
                      //       //         for(int i=0;i<diary_detail["clinic_menu"][2]["list"].length;i++)
                      //       //           Container(
                      //       //             child: Text(
                      //       //               "・"+diary_detail["clinic_menu"][2]["list"][i],
                      //       //               style: TextStyle(
                      //       //                 fontWeight: FontWeight.w700,
                      //       //                 fontSize: 14,
                      //       //                 color: Helper.maintxtColor,
                      //       //               ),
                      //       //             ),
                      //       //           ),
                                    
                      //       //       ],),
                      //       //   ),
                      //       // ),                     
                      //     ],
                      //   ),
                      // ),
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
              // Container(
              //   alignment: Alignment.center,
              //   height: 120,
              //   child: GridView.builder(
              //     scrollDirection:Axis.horizontal,
              //     itemCount:3   ,
              //     physics: AlwaysScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //       padding: EdgeInsets.symmetric(vertical: 10),
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           mainAxisSpacing: 10,
              //           crossAxisSpacing: 5,
              //           crossAxisCount: 1,
              //           childAspectRatio: 1),
              //       itemBuilder:  (BuildContext context, int index){
              //         return GestureDetector(
              //           onTap: (){
              //             // Navigator.of(context).push(MaterialPageRoute(builder: (_) => Diary_MediaList(post_treatment:  diary_detail["post-treatment"], before: {"label":"施術前","images":diary_detail["before_image"]["images"]},)));
              //           },
              //           child: SizedBox(
              //             height: 78,
              //             width: 78,
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(8),
              //               child: CachedNetworkImage(
              //                 fit: BoxFit.cover,
              //                 imageUrl:  diary_detail["before_image"]["images"][index],
              //                 placeholder: (context, url) => Image.asset(
              //                   'assets/images/loading.gif',
              //                   fit: BoxFit.cover,
              //                 ),
              //                 errorWidget: (context, url, error) =>
              //                     Image.asset(
              //                   'assets/images/profile.png',
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //     }),
              // ),
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
                  GestureDetector(
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
                  itemCount:(!isPostVisible&&(diary_detail.progresses!.length>3))? 3: diary_detail.progresses!.length,
                  physics:NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemBuilder: (BuildContext context, int index) {
                    return Post_Treatment_Card(post_treatment:diary_detail.progresses![index]);
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
              // Container(
              //   decoration: BoxDecoration(color: Helper.homeBgColor),
              //   child: Column(children: [
              //     GridView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              //       scrollDirection: Axis.vertical,
              //       gridDelegate:
              //       SliverGridDelegateWithFixedCrossAxisCount(
              //           childAspectRatio:175/291,
              //           crossAxisCount: 2,
              //           crossAxisSpacing: 10,
              //           mainAxisSpacing: 10),
              //       itemCount: diary_detail["home"].length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Home_Card(
              //           onpress: () {
              //         },
              //           title: diary_detail["home"][index]["title"],
              //           type: diary_detail["home"][index]["type"],
              //           clinic: diary_detail["home"][index]["clinic"],
              //           recommend: diary_detail["home"][index]["recommend"],
              //           source: diary_detail["home"][index]["source"],
              //           name: diary_detail["home"][index]["name"],
              //           doctorimage: diary_detail["home"][index]["doctorimage"],
              //           chat: diary_detail["home"][index]["chat"],
              //         );
              //       }),
              //   ],),
              // )
            ],),
          ),
        ),
      ),
    );
  }
}
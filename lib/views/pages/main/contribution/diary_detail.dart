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
import 'package:laxia/views/pages/main/reservation/reservation.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:laxia/views/pages/main/mypage/user_page.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/post_treatment_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class Diary_Detail extends StatefulWidget {
  final bool? isMyDiary;
  final int index;
  const Diary_Detail({ Key? key, this.isMyDiary = false, required this.index }) : super(key: key);

  @override
  State<Diary_Detail> createState() => _Diary_DetailState();
}

class _Diary_DetailState extends State<Diary_Detail> {
  // final apiUrl = dotenv.env["DEV_API_URL"];
 bool isVisible=false,isPostVisible=false;
 bool isloading = true,isfavorite=false,isfollow=false, islike=false;
  final _con = HomeController();
  late DiaryDetail_Model diary_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getDiaryDetail(index: index);
      setState(() {
        diary_detail = mid;
         isfavorite=diary_detail.diary.is_favorite==null?false:diary_detail.diary.is_favorite!;
         islike=diary_detail.diary.is_like!;
         isfollow=diary_detail.owner.is_follow!;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> postToogleFollow(index) async {
    try {
      final res=await _con.postToogleFollow(index:diary_detail.owner.id);
      if(res==true){
        setState(() {
          isfollow=!isfollow;
        });
      }
    } catch (e) {
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
  String getday(){
    if(diary_detail.progresses!.length==0)
      return '0';
    return diary_detail.progresses![diary_detail.progresses!.length-1].from_treat_day.toString();
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
                    // Navigator.of(context).pushNamed("/Mypage");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => UserPage(id: diary_detail.owner.id)));
                  },
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: diary_detail.owner.photo==null?"http://error.png":(diary_detail.owner.photo!),
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
                          getday()+"日", //diary_detail["end"]
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
                InkWell(
                  onTap: () {
                    postToogleFollow(diary_detail.owner.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                         border: Border.all(color:Color.fromARGB(255, 110, 198, 210),width: 2,style: BorderStyle.solid),
                         color:isfollow? Color.fromARGB(255, 110, 198, 210):Colors.white
                    ),
                    child: Padding(
                      padding:  const EdgeInsets.fromLTRB(12, 2, 12, 3),
                      child: Text(
                        'フォロー',
                        style: TextStyle(
                            fontSize: 13,
                            color:isfollow?Helper.whiteColor : Color.fromARGB(255, 110, 198, 210),),
                      ),
                    ),
                  ),
                )
                : ElevatedButton(
                  onPressed: () async{
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDiaryStep1Page(isMyDiary: widget.isMyDiary, diary_id: widget.index.toString(),)));
                    setState(() {
                      isloading = true;
                    });
                    getData(index: widget.index);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    primary: Color.fromARGB(255, 249, 161, 56),
                    onPrimary: Colors.white,
                    onSurface: Color.fromARGB(255, 110, 198, 210),
                    splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
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
                SizedBox(width: 15),
                SvgPicture.asset(
                  "assets/icons/upright_nobg.svg",
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 15),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
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
                              ? SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  width: 22,
                                  height: 22,
                                  color: Helper.starColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/borderstar.svg",
                                  width: 22,
                                  height: 22,
                                  // color: Colors.red,
                                  color: Color.fromARGB(255, 155, 155, 155),
                                ),
                          Text(
                            "お気に入り",
                            style: TextStyle(
                                color:Helper.txtColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        postToogleFavorite(widget.index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isfavorite
                              ? SvgPicture.asset(
                                  "assets/icons/red_heart.svg",
                                  width: 22,
                                  height: 22,
                                  color: Colors.red,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/heart.svg",
                                  width: 22,
                                  height: 22,
                                  color: Color.fromARGB(255, 155, 155, 155),
                                ),
                          Text(
                            diary_detail.diary.likes_count!.toString(),
                            style: TextStyle(
                                color:Helper.txtColor,
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
                  splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
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
                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Reservation(clinic_id: diary_detail.diary.clinic_id!, treat: diary_detail.menus![0] )));
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
                                  imageUrl:diary_detail.medias!.isEmpty?"http://error.png":  (diary_detail.medias![0].path),
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
                  for (int i = 0; i < diary_detail.diary.ave_rate!.round(); i++)
                    Icon(
                      Icons.star,
                      color: Helper.starColor,
                      size: 18,
                    ),
                     SizedBox(width: 12,),
                  Text(
                      diary_detail.diary.ave_rate.toString(),// ' diary_detail["mark"]',
                    style: defaultTextStyle(
                        Helper.titleColor, FontWeight.w700,
                        size: 14.0),
                  ),
              ],),
              CureMethod_Card(
                  image:diary_detail.menus![0].photo!,
                  heading:diary_detail.menus![0].name,// ' diary_detail["heading"]',
                  price:diary_detail.menus![0].price.toString(),// ' diary_detail["price"]',
                  tax: "（税込）",//  'diary_detail["tax"]',
                  clinic:diary_detail.diary.clinic_name!,//' diary_detail["clinic"]',
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
                            
                            color: Helper.maintxtColor,
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
              diary_detail.beforemedias!.isEmpty?Container():
              SizedBox(height: 19,),
              diary_detail.beforemedias!.isEmpty?Container():
              Text(
                "施術前",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Helper.titleColor,
                ),
              ),
              diary_detail.beforemedias!.isEmpty?Container():
              SizedBox(height: 4,),
              diary_detail.beforemedias!.isEmpty?Container():
              Container(
                alignment: Alignment.center,
                height: 120,
                child: GridView.builder(
                  scrollDirection:Axis.horizontal,
                  itemCount: diary_detail.beforemedias!.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 1,
                        childAspectRatio: 1),
                    itemBuilder:  (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => Diary_MediaList( before_medias: diary_detail.beforemedias!, processes: diary_detail.progresses!,)));
                        },
                        child: SizedBox(
                          height: 78,
                          width: 78,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:  diary_detail.beforemedias![index].path,
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
              diary_detail.progresses!.isEmpty?Container():
              SizedBox(height: 24,),
              diary_detail.progresses!.isEmpty?Container():
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
              diary_detail.progresses!.isEmpty?Container():
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
               diary_detail.diaries.isEmpty?Container():GestureDetector(
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
              diary_detail.diaries.isEmpty?Container():
              SizedBox(height: 19,),
              diary_detail.diaries.isEmpty?Container():
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
                  ListView.builder(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: diary_detail.diaries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Diary_Card(
                              avator:
                                  diary_detail.diaries[index].patient_photo == null
                                      ? "http://error.png"
                                      : diary_detail.diaries[index].patient_photo!,
                              check: diary_detail.diaries[index].doctor_name == null
                                  ? ""
                                  : diary_detail.diaries[index].doctor_name!,
                              image2: diary_detail.diaries[index].after_image == null
                                  ? "http://error.png"
                                  : diary_detail.diaries[index].after_image!,
                              image1:
                                  diary_detail.diaries[index].before_image == null
                                      ? "http://error.png"
                                      : diary_detail.diaries[index].before_image!,
                              eyes: diary_detail.diaries[index].views_count == null
                                  ? ""
                                  : diary_detail.diaries[index].views_count!
                                      .toString(),
                              clinic: diary_detail.diaries[index].clinic_name == null
                                  ? ""
                                  : diary_detail.diaries[index].clinic_name!,
                              name: diary_detail.diaries[index].patient_nickname == 
                                      null
                                  ? ""
                                  : diary_detail.diaries[index].patient_nickname!,
                              onpress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Diary_Detail(
                                        index: diary_detail.diaries[index].id)));
                              },
                              price: diary_detail.diaries[index].price == null
                                  ? ""
                                  : diary_detail.diaries[index].price.toString(),
                              sentence:
                                  diary_detail.diaries[index].doctor_name == null
                                      ? ""
                                      : diary_detail.diaries[index].doctor_name!,
                              type: diary_detail.diaries[index].doctor_name == null
                                  ? ""
                                  : diary_detail.diaries[index].doctor_name!,
                            );
                    }),
                ],),
              )
            ],),
          ),
        ),
      ),
    );
  }
}
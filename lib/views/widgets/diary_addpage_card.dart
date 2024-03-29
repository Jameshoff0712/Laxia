import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_progress.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step1.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:laxia/common/helper.dart';
import 'package:provider/provider.dart';

class DiaryAddPage_Card extends StatefulWidget {
  final VoidCallback onpress;
  final String title;
  final String photo;
  final String categories;
  final String clinic_name;
  final String doctor_name;
  final int diary_id;

  // final Color? buttoncolor, fontcolor;
  // final String avator, name, image1, image2, sentence, type, check, price, eyes;
  // final String? buttontext, hearts, chats, clinic;
  const DiaryAddPage_Card(
      {Key? key,
      required this.title,
      required this.photo,
      required this.categories,
      required this.clinic_name,
      required this.doctor_name,
      required this.diary_id,
      required this.onpress
      // required this.onpress,
      // required this.avator,
      // required this.name,
      // this.buttontext = "",
      // required this.image1,
      // required this.image2,
      // required this.sentence,
      // required this.type,
      // this.clinic = "",
      // required this.check,
      // required this.price,
      // this.buttoncolor,
      // this.fontcolor,
      // this.hearts = "",
      // this.chats = "",
      // required this.eyes
      })
      : super(key: key);

  @override
  State<DiaryAddPage_Card> createState() => _DiaryAddPage_CardState();
}

class _DiaryAddPage_CardState extends State<DiaryAddPage_Card> {
  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: widget.onpress,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      // 'ryu',
                      widget.title,
                      style: TextStyle(
                          fontSize: 16,
                          
                          fontWeight: FontWeight.w700,
                          color: Helper.maintxtColor),
                    ),
                    // widget.buttontext!.isEmpty
                    //     ? SizedBox(
                    //         width: 1,
                    //       )
                    //     : Expanded(
                    //         child: Align(
                    //         alignment: Alignment.topRight,
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(3),
                    //             color: widget.buttoncolor,
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 6, vertical: 4),
                    //             child: Text(
                    //               widget.buttontext!,
                    //               style: TextStyle(
                    //                   color: widget.fontcolor,
                    //                   fontSize: 10,
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //           ),
                    //         ),
                    //       ))
                  ],
                ),
                SizedBox(height: 6,),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.photo,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, left: 15),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/menubar/karute.svg",
                                      width: 12,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      // 'ryu',
                                      widget.categories,
                                      style: TextStyle(
                                          fontSize: 12,
                                          
                                          fontWeight: FontWeight.w400,
                                          color: Helper.txtColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              widget.clinic_name.isEmpty
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/menubar/clinic.svg",
                                                width: 12,
                                                height: 12,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                widget.clinic_name,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    
                                                    fontWeight: FontWeight.w400,
                                                    color: Helper.txtColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/menubar/part.svg",
                                      width: 12,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.doctor_name,
                                      style: TextStyle(
                                          fontSize: 12,
                                          
                                          fontWeight: FontWeight.w400,
                                          color: Helper.txtColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: ElevatedButton(
                      onPressed: () { 
                        diaryProperties.clearmenu();
                        Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AddDiaryProgressPage(diary_id: widget.diary_id.toString(),)));},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        splashFactory: NoSplash.splashFactory,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
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
                              '経過を追加する',
                              style: TextStyle(
                                  fontSize: 12,
                                  
                                  fontWeight: FontWeight.w700,
                                  color: Helper.mainColor,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 32, right: 32),
                    child: ElevatedButton(
                      onPressed: () {
                        diaryProperties.clearmenu();
                        Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AddDiaryStep1Page(diary_id: widget.diary_id.toString(),)));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        splashFactory: NoSplash.splashFactory,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
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
                              '日記を編集する',
                              style: TextStyle(
                                  fontSize: 12,
                                  
                                  fontWeight: FontWeight.w700,
                                  color: Helper.mainColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

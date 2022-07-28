import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/counsel_question_model.dart';
import 'package:laxia/models/counseling/councelingdetail_model.dart';
import 'package:laxia/models/question/media_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/select_clinic.dart';
import 'package:laxia/views/pages/main/contribution/select_doctor.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step2.dart';
import 'package:intl/intl.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';

class AddCounselStep1Page extends StatefulWidget {
  final String? counsel_id;
  final bool? isMyDiary;
  const AddCounselStep1Page({Key? key, this.isMyDiary = false, this.counsel_id = ''})
      : super(key: key);
  @override
  _AddCounselStep1PageState createState() => _AddCounselStep1PageState();
}

class _AddCounselStep1PageState extends State<AddCounselStep1Page> {
  bool initDetail = true;
  String date_counsel = '';
  String content_worry = '';
  bool isAddEnabled = true, isUsed = false;
  MyController _conMy = MyController();
  int index = 0;
  List<List<String>> images = [[], [], []];
  List<List<int>> imageIds = [[], [], []];
  final _picker = ImagePicker();
  late CouncelingDetail_Model counselDetail;
  Future<void> _openImagePicker() async {
    try{
      final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
      if(pickedImage == null) return;

      final Media_model res = await _conMy.imageUpload(pickedImage.path);
      setState(() {
        images[index].add(pickedImage.path);
        imageIds[index].add(res.id);
      });
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> getCounselDetail() async {
    counselDetail = await _conMy.getCounselDetail(widget.counsel_id!);
    
  }

  _AddCounselStep2Page() {
    showDialog(
      context: context,
      builder: (context) {
        PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(children: [
            Container(
              width: 300,
              height: 200,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 14),
                    child: Text(
                      "下書きに保存しますか？",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        
                        fontWeight: FontWeight.w700,
                        color: Helper.titleColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
                        style: TextStyle(
                          fontSize: 14,
                          
                          fontWeight: FontWeight.w400,
                          color: Helper.titleColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new FlatButton(
                          textColor: Helper.mainColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 0),
                            child: Text(
                              '保存しない',
                              style: TextStyle(
                                fontSize: 16,
                                
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          color: Helper.mainColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Text(
                                '保存する',
                                style: TextStyle(
                                  fontSize: 16,
                                  
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          onPressed: () {
                            // diaryProperties.setMedias(images);
                            diaryProperties.setCounselImageIds(imageIds);
                            print(imageIds);
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddCounselStep2Page(
                                  counsel_id: widget.counsel_id,
                            )));
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 14,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Helper.titleColor,
                ),
              ),
            )
          ]),
        );
      },
    );
  }

  @override
  void initState() {
    // images.add([]);
    // images.add([]);
    // images.add([]);
    if(widget.counsel_id != '')
      getCounselDetail();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getImageFromGallery() async {
    // var image = await AddCounselStep1Page.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    if (surgeryProvider.selectedCurePos.isNotEmpty 
        && diaryProperties.clinic_id != '' 
        && diaryProperties.doctor_id != '' 
        && diaryProperties.getDate != '' 
        && diaryProperties.counsel_content!= ''
    ) {
      setState(() {
        isAddEnabled = true;
      });
    } else {
      setState(() {
        isAddEnabled = false;
      });
    }

    if(initDetail && widget.counsel_id != ''){
      surgeryProvider.selectedCurePos = [];
      surgeryProvider.selectedCurePosStr = [];
      for(int i =0; i< counselDetail.counceling.categories!.length; i++){
        surgeryProvider.selectedCurePos.add(counselDetail.counceling.categories![i].id);
        surgeryProvider.selectedCurePosStr.add(counselDetail.counceling.categories![i].name);
      }
      diaryProperties.clinic_id = counselDetail.counceling.clinic_id.toString();
      userProperties.selectedClinic = counselDetail.counceling.clinic_name!;
      diaryProperties.doctor_id = counselDetail.counceling.clinic_id.toString();
      userProperties.selectedDoctor = counselDetail.counceling.doctor_name!;
      diaryProperties.date = counselDetail.counceling.counseling_date!;
      diaryProperties.counsel_content = counselDetail.counceling.content!;
      // setState(() {
      //   imageIds = [[], [], []];
      //   for(int i=0; i<counselDetail.counceling.media_self!.length; i++)
      //     imageIds[0].add(counselDetail.counceling.media_self![i].id);
      //   for(int i=0; i<counselDetail.counceling.media_like!.length; i++)
      //     imageIds[1].add(counselDetail.counceling.media_like![i].id);
      //   for(int i=0; i<counselDetail.counceling.media_dislike!.length; i++)
      //     imageIds[2].add(counselDetail.counceling.media_dislike![i].id);

      //   images = [[], [], []];
      //   for(int i=0; i<counselDetail.counceling.media_self!.length; i++)
      //     images[0].add(counselDetail.counceling.media_self![i].path);
      //   for(int i=0; i<counselDetail.counceling.media_like!.length; i++)
      //     images[1].add(counselDetail.counceling.media_like![i].path);
      //   for(int i=0; i<counselDetail.counceling.media_dislike!.length; i++)
      //     images[2].add(counselDetail.counceling.media_dislike![i].path);
      // });

      diaryProperties.counsel_reason = counselDetail.counceling.reason!;
      diaryProperties.counsel_before = counselDetail.counceling.before_counseling!;
      diaryProperties.counsel_after = counselDetail.counceling.after_ccounseling!;
      diaryProperties.counsel_rate = counselDetail.counceling.rate!;
      for(int i=0; i< counselDetail.questions.length; i++){
        diaryProperties.counsel_questions.add(new CounselQuestion_Model(counselDetail.questions[i].question!, counselDetail.questions[i].answer!));
      }
      
      setState(() {
        initDetail = false;
      });

    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('カウセレポを入力',
            style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              
            )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Helper.titleColor,
          ),
          onPressed: () {
            diaryProperties.date = '';
            surgeryProvider.selectedCurePos.clear();
            surgeryProvider.selectedCurePosStr.clear();
            userProperties.selectedClinic = '';
            diaryProperties.clinic_id = '';
            userProperties.selectedDoctor = '';
            diaryProperties.doctor_id = '';
            Navigator.pop(context);
          },
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 240, 242, 245),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  '基本情報',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200), width: 1.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "施術箇所",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    surgeryProvider.selectedCurePosStr.isNotEmpty
                                        ? surgeryProvider.getSelectedCurePosStr
                                        : "選択してください",
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: surgeryProvider.selectedCurePosStr.isNotEmpty? Helper.titleColor : Helper.txtColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    surgeryProvider.selectedCurePosStr.clear();
                                    surgeryProvider.selectedCurePos.clear();
                                    surgeryProvider.setButtonText("次へ");
                                    Navigator.of(context)
                                        .pushNamed("/SelectSurgery");
                                    setState(() {
                                      isUsed = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Helper.txtColor,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "クリニック",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  userProperties.getSelectedClinic != ""
                                      ? userProperties.getSelectedClinic
                                      : "選択してください",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: userProperties.getSelectedClinic != ""? Helper.titleColor: Helper.txtColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        constraints: BoxConstraints(
                                          maxHeight:
                                              MediaQuery.of(context).size.height *
                                                  0.9,
                                        ),
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.0),
                                              topRight: Radius.circular(15.0)),
                                        ),
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context) {
                                          return SelectClinic();
                                        });
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Helper.txtColor,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "担当ドクター",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  userProperties.getSelectedDoctor != ""
                                      ? userProperties.getSelectedDoctor
                                      : "選択してください",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: userProperties.getSelectedDoctor != ""? Helper.titleColor :Helper.txtColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        constraints: BoxConstraints(
                                          maxHeight:
                                              MediaQuery.of(context).size.height *
                                                  0.9,
                                        ),
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.0),
                                              topRight: Radius.circular(15.0)),
                                        ),
                                        backgroundColor: Colors.white,
                                        context: context,
                                        builder: (context) {
                                          return SelectDoctor(clinic_id: diaryProperties.getClinicID.toString());
                                        });
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Helper.txtColor,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "カウンセリング日",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  diaryProperties.getDate != ''? diaryProperties.getDate : '選択してください',
                                  style: TextStyle(
                                      color: diaryProperties.getDate != ''? Helper.titleColor : Helper.txtColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2018, 3, 5),
                                        maxTime: DateTime(2200, 6, 7),
                                        onChanged: (date) {}, onConfirm: (date) {
                                      setState(() {
                                        date_counsel = date.year.toString() +
                                            "年" +
                                            date.month.toString() +
                                            "月" +
                                            date.day.toString() +
                                            "日";
                                      });
                                      diaryProperties.setDate(
                                          date.year.toString() +
                                              "/" +
                                              date.month.toString() +
                                              "/" +
                                              date.day.toString());
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.jp);
                                  },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Helper.txtColor,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  'どんなことに悩んでいますか？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                     ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (val) {
                    setState(() {
                      content_worry = val;
                    });
                    diaryProperties.setCounselContent(val);
                  },
                  decoration: InputDecoration(
                    hintText: '例)二重幅が狭いことに悩んでいました',
                    hintStyle: TextStyle(
                      color: Helper.txtColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  '自分の写真',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      ),
                ),
              ),
              imagePicker(context, 0),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  '理想の写真',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      ),
                ),
              ),
              imagePicker(context, 1),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  '理想じゃない写真',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      ),
                ),
              ),
              imagePicker(context, 2),
              SizedBox(
                height: 48,
              ),
              !widget.isMyDiary!
                  ? Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(255, 194, 194, 194),
                          ),
                          child: ElevatedButton(
                            onPressed:
                                isAddEnabled ? () { 
                                  print(imageIds);
                                  // diaryProperties.setCounselImageIds(imageIds);
                                  
                                  // print(diaryProperties.getCounselImageIds);
                                  _AddCounselStep2Page(); } : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              primary: Helper.mainColor,
                              onPrimary: Colors.white,
                              onSurface: Color.fromARGB(255, 194, 194, 194),
                              splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                '次に進む',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCounselStep2Page(
                                      isMyDiary: widget.isMyDiary)));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 70),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          side: const BorderSide(
                              color: Helper.mainColor,
                              width: 1,
                              style: BorderStyle.solid),
                          primary: Helper.whiteColor,
                          splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '次へ進む',
                            style: TextStyle(
                                fontSize: 14,
                                
                                fontWeight: FontWeight.w700,
                                color: Helper.mainColor),
                          ),
                        ),
                      ),
                    )),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget imagePicker(BuildContext context, int subindex) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 12, bottom: 0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  index = subindex;
                });
                _openImagePicker();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 14),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 194, 194, 194),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/photo.svg",
                      width: 36,
                      height: 29,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('写真を追加',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              height: 1.5)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhotoCarouselWidget(
                      ImageList: images[subindex],
                      onRemove: (int) {
                        setState(() {
                          images[subindex].removeAt(int);
                          imageIds[subindex].removeAt(int);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

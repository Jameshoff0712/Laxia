import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/counsel_post_model.dart';
import 'package:laxia/models/counsel_question_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/views/pages/main/contribution/question_answer.dart';
import 'package:laxia/views/widgets/ToggleSwitchButton.dart';
import 'package:laxia/views/widgets/counsel_question_card.dart';
import 'package:provider/provider.dart';

import '../../../../provider/surgery_provider.dart';
import '../../../../provider/user_provider.dart';

class AddCounselStep2Page extends StatefulWidget {
  final String? counsel_id;
  final bool? isMyDiary;
  const AddCounselStep2Page({Key? key, this.isMyDiary = false, this.counsel_id = ''})
      : super(key: key);
  @override
  _AddCounselStep2PageState createState() => _AddCounselStep2PageState();
}

class _AddCounselStep2PageState extends State<AddCounselStep2Page> {
  bool initDetail = true;
  bool isAddEnabled = true;
  int selectstar = 0;
  bool _notificationStatus = true;
  MyController _conMy = MyController();
  List<CounselQuestion_Model> CounselQuestion_list = [];

  TextEditingController conReason = TextEditingController();
  TextEditingController conBefore = TextEditingController();
  TextEditingController conAfter = TextEditingController();

  // String reason = '';
  // String feeling = '';
  // String impress = '';

  String doctor_id = '';
  String clinic_id = '';
  String date = '';
  String content = '';
  List<int> categories = [];
  List<List<int>> imageIds = [[], [], []];
  // late OfferController _con;

  // _AddCounselStep2PageState() : super(OfferController()) {
  //   _con = controller as OfferController;
  // }

  Future<void> post() async {
    CounselPostModel newQuestion = new CounselPostModel(
        clinic_id: clinic_id,
        doctor_id: doctor_id,
        date: date,
        content: content,
        categories: categories,
        imageIds: imageIds,
        reason: conReason.text,
        before_counsel: conBefore.text,
        after_counsel: conAfter.text,
        rate: selectstar.toString(),
        question: CounselQuestion_list
        );
        print(newQuestion);
    if(widget.counsel_id != ''){
      dynamic result = await _conMy.editCounsel(newQuestion, widget.counsel_id!);
      print('edit');
      print(widget.counsel_id);
      print(result.data);
    }
    else{
      dynamic result = await _conMy.postCounsel(newQuestion);
      print('post');
      print(result.data);
    }
    // print(result.data);
  }
  enableAddButton() {
    setState(() {
      isAddEnabled = true;
    });
  }

  disableAddButton() {
    setState(() {
      isAddEnabled = false;
    });
  }

  AddCounselPage() {
    Navigator.of(context).pushNamed("/AddCounselList");
  }

  CounselDownloadPage() {
    Navigator.of(context).pushNamed("/AddCounselList");
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddCounselStep2Page.pickImage(source: ImageSource.gallery);

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
    // if (conReason.text != '' && conBefore.text != '' && conAfter.text != '' && selectstar != 0 ) {
    //   setState(() {
    //     isAddEnabled = true;
    //   });
    // } else {
    //   setState(() {
    //     isAddEnabled = false;
    //   });
    // }

    if(initDetail && widget.counsel_id != '') {
      setState(() {
        conReason.text = diaryProperties.getCounselReason;
        conBefore.text = diaryProperties.getCounselBefore;
        conAfter.text = diaryProperties.getCounselAfter;
        selectstar = diaryProperties.getCounselRate;
        CounselQuestion_list = diaryProperties.getCounselQuestions;
        initDetail = false;
      });
    }
    if (conReason.text != '' && conBefore.text != '' && conAfter.text != '' && selectstar != 0 && CounselQuestion_list.length > 0) {
      setState(() {
        isAddEnabled = true;
      });
    } else {
      setState(() {
        isAddEnabled = false;
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
            Navigator.pop(context);
          },
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 240, 242, 245),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  'このクリニックを選んだ理由は？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: conReason,
                  cursorColor: Helper.mainColor,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (text) {
                    // setState(() {
                    //   conReason.text = text;
                    // });
                  },
                  decoration: InputDecoration(
                    hintText: '例)ラシアの他の口コミをみて、ここのクリニックの田中先生に相談してみようと思い選択しました。',
                    hintStyle: TextStyle(
                      color: Helper.txtColor,
                      fontSize: 14,
                      height: 1.8,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  '質問・相談した内容は？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                        ),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return QuestionAnswer(onAdd: (value){
                            setState(() {
                              CounselQuestion_list.add(value);
                            });
                            // CounselQuestion_list.add(value);
                            // print(CounselQuestion_list);
                          });
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    side: const BorderSide(
                        color: Helper.mainColor,
                        width: 2,
                        style: BorderStyle.solid),
                    primary: Colors.white,
                    onPrimary: Helper.mainColor,
                    onSurface: Colors.grey,
                    splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          color: Helper.mainColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          ' 質問・相談を追加',
                          style: TextStyle(
                              fontSize: 14,
                              
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: CounselQuestion_list.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CounselQuestion_Card(
                          index: index + 1,
                          question: CounselQuestion_list[index].question,
                          answer: CounselQuestion_list[index].answer,
                          onpress: () {},
                        );
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  'カウンセリングの様子はどうでしたか？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: conBefore,
                  cursorColor: Helper.mainColor,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (text) {
                    // setState(() {
                    //   conBefore.text= text;
                    // });
                  },
                  decoration: InputDecoration(
                    hintText:
                        '例)真摯に質問や相談に乗ってくれました。価格も相談に乗っていただき自分にあった施術を提案していただいた。',
                    hintStyle: TextStyle(
                      color: Helper.txtColor,
                      fontSize: 14,
                      height: 1.8,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  'カウンセリング後の感想',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: conAfter,
                  cursorColor: Helper.mainColor,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (text) {
                    // setState(() {
                    //   conAfter.text = text;
                    // });
                  },
                  decoration: InputDecoration(
                    hintText: '例)自分にあった二重幅を知ることができた。料金も良心的であると思いました。',
                    hintStyle: TextStyle(
                      color: Helper.txtColor,
                      fontSize: 14,
                      height: 1.8,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                child: Text(
                  'カウンセリングの満足度',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Star(
                              i,
                              selectstar > i
                                  ? Color.fromARGB(255, 242, 201, 76)
                                  : Color.fromARGB(255, 222, 222, 222)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '5段階評価で入力してください。',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Helper.txtColor,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              !widget.isMyDiary!
                  ? Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                          child: ElevatedButton(
                            onPressed:
                                isAddEnabled ? () async{ 
                                  setState(() {
                                    doctor_id = diaryProperties.getDoctorID;
                                    clinic_id = diaryProperties.getClinicID;
                                    date = diaryProperties.getDate;
                                    categories.addAll(surgeryProvider.getSelectedCurePos);
                                    content = diaryProperties.getCounselContent;
                                    for(int i = 0; i<3; i++)
                                      imageIds[i].addAll(diaryProperties.getCounselImageIds[i]);
                                  });
                                  diaryProperties.clinic_id = '';
                                  userProperties.selectedClinic = '';
                                  diaryProperties.doctor_id = '';
                                  userProperties.selectedDoctor = '';
                                  diaryProperties.date = '';
                                  diaryProperties.counsel_content = '';
                                  surgeryProvider.selectedCurePos = [];
                                  surgeryProvider.selectedCurePosStr = [];
                                  diaryProperties.counsel_imageIds = [[], [], []];

                                  diaryProperties.counsel_reason = '';
                                  diaryProperties.counsel_before = '';
                                  diaryProperties.counsel_after = '';
                                  diaryProperties.counsel_rate = 0;
                                  diaryProperties.counsel_questions = [];
                                  await post();
                                  AddCounselPage(); 
                                  } : null,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              primary: Helper.mainColor,
                              onPrimary: Colors.white,
                              onSurface: Colors.grey,
                              splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'レポートを投稿する',
                                style: TextStyle(
                                    fontSize: 14,
                                    
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              CounselDownloadPage();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              side: const BorderSide(
                                  color: Helper.mainColor,
                                  width: 2,
                                  style: BorderStyle.solid),
                              primary: Colors.white,
                              onPrimary: Helper.mainColor,
                              onSurface: Colors.grey,
                              splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'レポートを下書き保存する',
                                style: TextStyle(
                                    fontSize: 14,
                                    
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          height: 6,
                          color: Color.fromARGB(255, 222, 222, 222),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 23, left: 16, bottom: 6),
                          child: Text(
                            '公開設定',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(255, 102, 110, 110),
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                height: 1.5),
                          ),
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'レポートを公開',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    
                                    color: Helper.titleColor,
                                  ),
                                ),
                                ToggleSwitchButton(
                                  value: _notificationStatus,
                                  activeColor: Helper.mainColor,
                                  onChanged: (value) => setState(() {
                                    _notificationStatus = value;
                                  }),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 48,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 62),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Helper.mainColor,
                                  )),
                              child: Text(
                                "編集を完了",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  
                                  color: Helper.mainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget Star(int sindex, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectstar = sindex + 1;
        });
      },
      child: Container(
        //decoration: BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/star.svg",
              width: 30,
              height: 30,
              color: color,
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}

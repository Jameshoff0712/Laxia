import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/diary_post_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step5.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDiaryStep4Page extends StatefulWidget {
  String? diary_id;
  final bool? isMyDiary;
  AddDiaryStep4Page({Key? key, this.isMyDiary = false, this.diary_id = ''}) : super(key: key);
  @override
  _AddDiaryStep4PageState createState() => _AddDiaryStep4PageState();
}

class _AddDiaryStep4PageState extends State<AddDiaryStep4Page> {
  // List<String> questions = ['', '', '', '', '', ''];
  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  TextEditingController con3 = TextEditingController();
  TextEditingController con4 = TextEditingController();
  TextEditingController con5 = TextEditingController();
  TextEditingController con6 = TextEditingController();
  bool status = true;
  bool isAddEnabled = true;
  bool initDetail = true;
  MyController _conMy = MyController();
  // late OfferController _con;

  // _AddDiaryStep4PageState() : super(OfferController()) {
  //   _con = controller as OfferController;
  // }

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

  // AddDiaryStep5Page() {
  //   Navigator.of(context).pushNamed("/AddDiaryStep5");
  // }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep4Page.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    // for(int i = 0; i < 6; i++){
    //   if(questions[i] == '') {
    //     setState(() {
    //       isAddEnabled = false;
    //     });
    //     break;
    //   }
    //   else 
    //     setState(() {
    //       isAddEnabled = true;
    //     });
    // }

    if(initDetail && widget.diary_id != '') {
      print(diaryProperties.questions);
      setState(() {
        con1.text = diaryProperties.questions[0];
        con2.text = diaryProperties.questions[1];
        con3.text = diaryProperties.questions[2];
        con4.text = diaryProperties.questions[3];
        con5.text = diaryProperties.questions[4];
        con6.text = diaryProperties.questions[5];
        // questions = diaryProperties.questions;
        initDetail = false;
      });
    }
    if(con1.text != ''
      && con2.text != ''
      && con3.text != ''
      && con4.text != ''
      && con5.text != ''
      && con6.text != '') {
        setState(() {
          isAddEnabled = true;
        });
    } else {
      setState(() {
        isAddEnabled = false;
      });
    }
    // print('123');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('施術について',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
                child: Text(
                  'どんなことで悩んでいましたか？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: con1,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  onChanged: (text) {
                    setState(() {
                      status = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '例)目が一重で目つきがキツイことで悩んでいました。',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 156, 161, 161),
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
                child: Text(
                  'クリニック、ドクターを選択した理由は？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: con2,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  onChanged: (text) {
                    setState(() {
                      status = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '例)二重部門でラシアでの評価も高く信頼できると思ったからです。',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 156, 161, 161),
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
                child: Text(
                  'このメニューを選んだ理由は？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: con3,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  onChanged: (text) {
                    setState(() {
                      status = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '例)二重切開が良いと思ったのですが、私のまぶただと埋没でも大丈夫ということで、埋没にしました。',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 156, 161, 161),
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
                child: Text(
                  '施術の流れや施術中の痛みは？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: con4,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  onChanged: (text) {
                    setState(() {
                      status = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '例)施術は15分ほどで終わりました。麻酔をしていたので特に痛みはなかったです。',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 156, 161, 161),
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
                child: Text(
                  'ドクターやスタッフの対応はどうでしたか？',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: con5,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  onChanged: (text) {
                    setState(() {
                      status = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '例)ドクターもスタッフの方も優しく声をかけていただき、安心して施術に向かうことができきました。',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 156, 161, 161),
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, bottom: 8),
                child: Text(
                  'この施術をしたいと思ってる人へアドバイスを',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.5),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: con6,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  onChanged: (text) {
                    setState(() {
                      status = true;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '例)毎日自分の顔が見るのが楽しみになりました。もし迷っているなら、是非オススメします。',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 156, 161, 161),
                        fontSize: 14,
                        height: 1.8,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              !widget.isMyDiary!
                  ? Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 177,
                        padding: EdgeInsets.only(top: 22, left: 16, right: 16, bottom: 110),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color.fromARGB(255, 194, 194, 194),
                            ),
                          child: ElevatedButton(
                            onPressed:
                                isAddEnabled ? () { 
                                  diaryProperties.setQuestions([con1.text,con2.text,con3.text,con4.text,con5.text,con6.text]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddDiaryStep5Page(
                                        diary_id: widget.diary_id,
                                  )));
                                } : null,
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
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        height: 45,
                      margin: EdgeInsets.only(top: 22),
                      child: ElevatedButton(
                        onPressed: isAddEnabled ? () async {
                          DiaryPostModel newDiary = new DiaryPostModel(
                            clinic_id: diaryProperties.getClinicID, 
                            doctor_id: diaryProperties.getDoctorID,
                            date: diaryProperties.getDate, 
                            categories: surgeryProvider.getSelectedCurePos, 
                            imageIds: diaryProperties.getDiaryImageIds, 
                            questions: diaryProperties.getQuestions, 
                            rates: diaryProperties.getRates, 
                            cost_op: diaryProperties.getCostOp,
                            cost_anes: diaryProperties.getCostAnesthetic, 
                            cost_drug: diaryProperties.getCostDrug, 
                            cost_other: diaryProperties.getCostOther
                          );
                          // if(widget.diary_id != '')
                            dynamic result = await _conMy.editDiary(newDiary, widget.diary_id!);
                          // else
                          //   dynamic result = await _conMy.postDiary(newDiary);
                          // print(result.data);


                          diaryProperties.clinic_id = '';
                          diaryProperties.doctor_id = '';
                          diaryProperties.date = '';
                          surgeryProvider.selectedCurePos = [];
                          surgeryProvider.selectedCurePosStr = [];
                          diaryProperties.diary_imageIds = [];
                          diaryProperties.questions = [];
                          diaryProperties.rates = [];
                          diaryProperties.cost_op = 0;
                          diaryProperties.cost_anesthetic = 0;
                          diaryProperties.cost_drug = 0;
                          diaryProperties.cost_other = 0;

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } : null,
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
                            '修正を完了',
                            style: TextStyle(
                                fontSize: 14,
                                
                                fontWeight: FontWeight.w700,
                                color: Helper.mainColor),
                          ),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

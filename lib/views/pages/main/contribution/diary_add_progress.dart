import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/models/diary/diary/progress_detail_model.dart';
import 'package:laxia/models/progess_post_model.dart';
import 'package:laxia/models/question/media_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_list.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/widgets/select_numberDays.dart';
import 'package:laxia/views/widgets/state_slider_widget.dart';
import 'package:provider/provider.dart';

class AddDiaryProgressPage extends StatefulWidget {
  final bool? isMyDiary;
  final String diary_id;
  String? progress_id;
  AddDiaryProgressPage({Key? key, this.isMyDiary = false, required this.diary_id, this.progress_id = ''}) : super(key: key);
  @override
  _AddDiaryProgressPageState createState() => _AddDiaryProgressPageState();
}

class _AddDiaryProgressPageState extends State<AddDiaryProgressPage> {
  bool initDetail = true;
  bool isloading = true;
  bool isAddEnabled = true;
  int index = 0;
  HomeController _conHome = HomeController();
  late DiaryDetail_Model info;
  late DiaryDetail_Model mid;
  late String treat_date;
  int status1 = 0;
  int status2 = 0;
  int status3 = 0;
  TextEditingController _conPro = TextEditingController();
  bool isPro = true;

  late ProgressDetail_Model progressDetail;
  MyController _conMy = MyController();
  List images = [];
  List<int> imageIds = [];
  final _picker = ImagePicker();

  late List<int> qst_categories;
  Future<void> _openImagePicker() async {
    try{
      final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
      if(pickedImage == null) return;

      final Media_model res = await _conMy.imageUpload(pickedImage.path);
      print(pickedImage.path);
      print(res);
      setState(() {
        images.add(pickedImage.path);
        imageIds.add(res.id);
      });
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> getData() async {
    mid = await _conHome.getDiaryDetail(index: int.parse(widget.diary_id));
    print(mid.diary.treat_date!);
    setState(() {
      info = mid;
      treat_date = mid.diary.treat_date!;
    });
  }
  AddDiaryPage() {
    Navigator.of(context).pushNamed("/AddDiaryList");
  }

  void onDonePress() {
    // Do what you want
    print("End of slides");
  }

  @override
  void initState() {
    getData();
    if(widget.progress_id != '')
      getProgressDetail();
    super.initState();
  }

  Future<void> getProgressDetail() async {
    final res = await _conMy.getProgressDetail(widget.progress_id!);
    print(res.progress.medias);
    setState(() {
      progressDetail = res;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    if(initDetail && widget.isMyDiary! && widget.progress_id != '' && !isloading) {
      diaryProperties.numbers_date = progressDetail.progress.from_treat_day.toString();
      setState(() {
        imageIds = [];
        images = [];
        for(int i = 0; i< progressDetail.progress.medias.length; i++){
          imageIds.add(progressDetail.progress.medias[i].id);
          images.add(progressDetail.progress.medias[i].path);
        }

        _conPro.text = progressDetail.progress.content!;
        status1 = progressDetail.statuses[0].pivot.value;
        status2 = progressDetail.statuses[1].pivot.value;
        status3 = progressDetail.statuses[2].pivot.value;
      });
      setState(() {
        initDetail = false;
      });
    }
    if(diaryProperties.numbers_date != '' && _conPro.text != '') {
       setState(() {
        isAddEnabled = true;
      });
    }  else
      setState(() {
        isAddEnabled = false;
      });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('術後経過を入力',
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
            diaryProperties.numbers_date = '';
            Navigator.pop(context);
          },
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
      ),
      body: isloading
      ? Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          )
      : SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '施術日からの経過日数',
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
                            "経過日数",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                diaryProperties.numbers_date != '' ? diaryProperties.numbers_date + '日目' : "選択してください",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: diaryProperties.numbers_date != '' ? Helper.titleColor : Helper.txtColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                  ),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return SelectNumberDays(diary_id: widget.diary_id,);
                                  },
                                  isScrollControlled: true,);
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
                '経過写真',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            imagePicker(context),
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '施術箇所の具合',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            StateSliderWidget(
              state_str: "痛み",
              state_val: status1,
              onChanged: (double val) {
                setState(() {
                  status1 = val.toInt();
                });
              },
            ),
            StateSliderWidget(
              state_str: "腫れ",
              state_val: status2,
              onChanged: (double val) {
                setState(() {
                  status2 = val.toInt();
                });
              },
            ),
            StateSliderWidget(
              state_str: "傷あと",
              state_val: status3,
              onChanged: (double val) {
                setState(() {
                  status3 = val.toInt();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10),
                title: Text(
                  '経過日記',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                controller: _conPro,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (text) {
                  setState(() {
                    isPro = true;
                  });
                },
                decoration: InputDecoration(
                  hintText: '施術5日目の経過です。腫れもだいふひいてきました。',
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
            !widget.isMyDiary! ?Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 85,
                padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: isAddEnabled ? () async{
                    ProgressPostModel newProgress = new ProgressPostModel(
                      from_treat_day: diaryProperties.numbers_date, 
                      content: _conPro.text, 
                      status1: status1, 
                      status2: status2, 
                      status3: status3, 
                      imageIds: imageIds
                    );
                    final result = await _conMy.postProgress(newProgress, widget.diary_id);
                    print(result.data);

                    diaryProperties.numbers_date = '';
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DiaryPage()));
                  } : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    primary: Helper.mainColor,
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '施術経過を投稿する',
                      style: TextStyle(
                          fontSize: 14,
                          
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            )
            : Center(
                    child: Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: isAddEnabled ? () async{
                        ProgressPostModel newProgress = new ProgressPostModel(
                          from_treat_day: diaryProperties.numbers_date, 
                          content: _conPro.text, 
                          status1: status1, 
                          status2: status2, 
                          status3: status3, 
                          imageIds: imageIds
                        );
                        print(widget.diary_id);
                        print(widget.progress_id);
                        final result = await _conMy.editProgress(newProgress, widget.progress_id!);
                        print(result.data);

                        diaryProperties.numbers_date = '';
                        Navigator.pop(context);
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
                          '次へ進む',
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
    );
  }

  Widget imagePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 16, bottom: 0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
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
                              )),
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
                      ImageList: images,
                      onRemove: (int) {
                        setState(() {
                          images.removeAt(int);
                          imageIds.removeAt(int);
                        });
                      },
                      bRemove: true,
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

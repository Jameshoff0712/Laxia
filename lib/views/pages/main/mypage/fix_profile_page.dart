import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/controllers/static_controller.dart';
import 'package:laxia/models/profile_model.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/mypage/input_text_widget.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:laxia/views/pages/main/mypage/selectbox_widget.dart';
import 'package:laxia/views/widgets/select_gender.dart';
// import 'package:laxia/views/widgets/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/static/areas_model.dart';

class FixProfilePage extends StatefulWidget {
  @override
  State<FixProfilePage> createState() => _FixProfilePageState();
}

class _FixProfilePageState extends State<FixProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _enteredText = '';
  // List<String> _cities = [];
  List<Area_Model> areas = [];
  late List<int> surgery_ids;
  File? _image;
  final _picker = ImagePicker();
  MyController _con = new MyController();
  final _conStatic = StaticController();
  TextEditingController _conNickname = TextEditingController();
  TextEditingController _conId = TextEditingController();
  TextEditingController _conDate = TextEditingController();
  TextEditingController _conIntro = TextEditingController();
  String valPrefecture = '';
  TextEditingController _conGender = TextEditingController();
  TextEditingController _conSurgery = TextEditingController();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> post() async {
    ProfileModel profile = new ProfileModel(
        birthday: _conDate.text,
        gender: _conGender.text,
        unique_id: _conId.text,
        nick_name: _conNickname.text,
        intro: _conIntro.text,
        photo: _image!.path,
        area_id: int.parse(valPrefecture),
        patient_categories: surgery_ids);
    dynamic result = await _con.editProfile(profile);
    print(result.data);
  }

  Future<void> readAreas() async {
    try {
      areas = await _conStatic.getAreas();
      setState(() {
        // isloading = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }

  @override
  void initState() {
    _conSurgery.text = _enteredText;
    super.initState();
    readAreas();
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    if (_enteredText != surgeryProvider.selectedCurePosStr.join(' ')) {
      setState(() {
        _enteredText = surgeryProvider.selectedCurePosStr.join(' ');
        _conSurgery.text = _enteredText;
      });
    }
    // TODO: implement build
    return areas.isNotEmpty
        ? Container(
            padding: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height - 54,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Helper.whiteColor,
                leading: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      _conSurgery.text = '';
                      surgeryProvider.selectedCurePosStr.clear();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Helper.titleColor,
                    )),
                centerTitle: true,
                title: Center(
                  child: Text(
                    'プロフィールを編集',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Helper.titleColor,
                    ),
                  ),
                ),
                actions: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          surgery_ids = surgeryProvider.getSelectedCurePos;
                        });
                        post();
                        // Navigator.of(context).pushNamed("/Mypage");
                      },
                      child: Text(
                        "保存",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Helper.mainColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                    child: _image == null
                                        ? Image.asset(
                                            'assets/images/user/user1.jpg',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover)
                                        : Image.file(_image!,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover)),
                              ),
                              GestureDetector(
                                onTap: _openImagePicker,
                                child: Container(
                                    height: 20,
                                    width: 24,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Helper.whiteColor,
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: _openImagePicker,
                          child: Text(
                            "プロフィール写真を変更",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              color: Helper.mainColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          child: Column(
                            children: [
                              InputTextWidget(
                                  controller: _conNickname,
                                  labelName: "ニックネーム",
                                  placeHolder: "あやか",
                                  maxLegnth: "40"),
                              InputTextWidget(
                                  controller: _conId,
                                  labelName: "ユーザーID",
                                  placeHolder: "Ayaka",
                                  maxLegnth: "40"),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "生年月日",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 18, 18, 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 18, 18, 18)),
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2018, 3, 5),
                                          maxTime: DateTime(2200, 6, 7),
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        _conDate.text = date.year.toString() +
                                            "/" +
                                            date.month.toString() +
                                            "/" +
                                            date.day.toString();
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.jp);
                                    },
                                    controller: _conDate,
                                    validator: (v) {
                                      if (v!.isEmpty) return '日付を入力してください';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "2020/12/12",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Helper.txtColor),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Helper.authHintColor,
                                              width: 1.0)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Helper.authHintColor,
                                              width: 1.0)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '生年月日は非公開です。年代のみ公開されます。',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          color: Color.fromARGB(
                                              255, 156, 161, 161)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '性別',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 18, 18, 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _conGender,
                                readOnly: true,
                                onTap: () {
                                  // surgeryProvider.selectedCurePosStr.clear();
                                  // surgeryProvider.setButtonText("次へ");
                                  // Navigator.of(context)
                                  //     .pushNamed("/SelectSurgery");
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0)),
                                    ),
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (context) {
                                      return SelectGender(
                                          controller: _conGender);
                                    },
                                    isScrollControlled: true,
                                  );
                                },
                                validator: (v) {
                                  if (v!.isEmpty) return '入力してください';
                                  // final regex = RegExp('^[1-9]+[0-9]*');
                                  // if (!regex.hasMatch(v)) return 'Enter a valid point value';
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // filled: true,
                                  // fillColor: Helper.whiteColor.withOpacity(0.2),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  // hintText: '今気になってる施術や部位を選択',
                                  counterText: "",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Helper.txtColor),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.black,
                                          color: Helper.authHintColor,
                                          width: 1.0)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.black,
                                          color: Helper.authHintColor,
                                          width: 1.0)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.black,
                                          color: Helper.authHintColor,
                                          width: 1.0)),
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 18, 18, 18)),
                              ),
                              InputTextWidget(
                                controller: _conIntro,
                                labelName: "自己紹介",
                                placeHolder: "",
                                maxLegnth: "140",
                                maxlines: 2,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              SelectBoxWidget(
                                onChange: (val) {
                                  setState(() {
                                    valPrefecture = val;
                                  });
                                },
                                name: "施術希望エリア",
                                items: areas,
                                chosenValue: "",
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '気になっている施術・部位',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 18, 18, 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _conSurgery,
                                onTap: () {
                                  surgeryProvider.selectedCurePosStr.clear();
                                  surgeryProvider.setButtonText("次へ");
                                  Navigator.of(context)
                                      .pushNamed("/SelectSurgery");
                                  // setState(() {
                                  //   isUsed = true;
                                  // });
                                },
                                validator: (v) {
                                  if (v!.isEmpty) return '入力してください';
                                  // final regex = RegExp('^[1-9]+[0-9]*');
                                  // if (!regex.hasMatch(v)) return 'Enter a valid point value';
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // filled: true,
                                  // fillColor: Helper.whiteColor.withOpacity(0.2),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  hintText: '今気になってる施術や部位を選択',
                                  counterText: "",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Helper.txtColor),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.black,
                                          color: Helper.authHintColor,
                                          width: 1.0)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.black,
                                          color: Helper.authHintColor,
                                          width: 1.0)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          // color: Colors.black,
                                          color: Helper.authHintColor,
                                          width: 1.0)),
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 18, 18, 18)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/mypage/input_text_widget.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:laxia/views/pages/main/mypage/selectbox_widget.dart';
// import 'package:laxia/views/widgets/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class FixProfilePage extends StatefulWidget {
  @override
  State<FixProfilePage> createState() => _FixProfilePageState();
}

class _FixProfilePageState extends State<FixProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _enteredText = '';
  List<String> _cities = [];
  File? _image;
  final _picker = ImagePicker();
  TextEditingController _conDate = TextEditingController();
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

  Future<void> readCities() async {
    final String response =
        await rootBundle.loadString('assets/cfg/japanese-city-data.json');
    final data = await json.decode(response);
    setState(() {
      for (int i = 0; i < data.length; i++) {
        _cities.add(data[i]["label"]);
      }
    });
  }

  @override
  void initState() {
    _conSurgery.text=_enteredText;
    super.initState();
    readCities();
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    if(_enteredText!= surgeryProvider.selectedCurePosStr.join(' ')){
      setState(() {
        _enteredText=surgeryProvider.selectedCurePosStr.join(' ');
         _conSurgery.text=_enteredText;

      });
    }
    // TODO: implement build
    return _cities.isNotEmpty
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
                        Navigator.of(context).pushNamed("/Mypage");
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
                                  labelName: "ニックネーム",
                                  placeHolder: "あやか",
                                  maxLegnth: "40"),
                              InputTextWidget(
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
                              SelectBoxWidget(
                                name: "性別",
                                items: ["女性", "男性"],
                                chosenValue: "女性",
                              ),
                              InputTextWidget(
                                labelName: "自己紹介",
                                placeHolder: "",
                                maxLegnth: "140",
                                maxlines: 2,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              SelectBoxWidget(
                                name: "施術希望エリア",
                                items: _cities,
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

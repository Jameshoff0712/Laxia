import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/mypage/input_text_widget.dart';
import 'package:laxia/views/pages/main/mypage/selectbox_widget.dart';
// import 'package:laxia/views/widgets/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class FixProfilePage extends StatefulWidget {
  @override
  State<FixProfilePage> createState() => _FixProfilePageState();
}

class _FixProfilePageState extends State<FixProfilePage> {
  String _enteredText = '';
  List<String> _cities = [];
  File? _image;
  final _picker = ImagePicker();

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
    super.initState();
    readCities();
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    // TODO: implement build
    return _cities.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Helper.whiteColor,
              leading: IconButton(
                  onPressed: () {
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
                    height: 1.5,
                    color: Helper.titleColor,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () =>
                      print("[Account Screen] Notification button clicked!"),
                  child: Center(
                    child: Container(
                      child: Text(
                        "保存",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1.5,
                          color: Helper.mainColor,
                        ),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                                    : Image.network(
                                        _image!.path,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover)),
                          ),
                          InkWell(
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
                    InkWell(
                      onTap: _openImagePicker,
                      child: Text(
                        "プロフィール写真を変更",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          height: 1.5,
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
                          SizedBox(
                            height: 10,
                          ),
                          InputTextWidget(
                              labelName: "ユーザーID",
                              placeHolder: "Ayaka",
                              maxLegnth: "40"),
                          SizedBox(
                            height: 10,
                          ),
                          InputTextWidget(
                              labelName: "生年月日",
                              placeHolder: "生年月日は非公開です。年代のみ公開されます。",
                              maxLegnth: ""),
                          SizedBox(
                            height: 10.0,
                          ),
                          SelectBoxWidget(
                            name: "性別",
                            items: ["女性", "男性"],
                            chosenValue: "女性",
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          InputTextWidget(
                              labelName: "自己紹介",
                              placeHolder: "プロフィールに自己紹介を追加する",
                              maxLegnth: "140"),
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
                                height: 1.5,
                                color: Color.fromARGB(255, 18, 18, 18),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  18.0, 14.0, 18.0, 14.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        surgeryProvider.selectedCurePos.isEmpty
                                            ? "選択してください"
                                            : surgeryProvider
                                                .getSelectedCurePosStr,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        surgeryProvider.setButtonText("次へ");
                                        Navigator.of(context)
                                            .pushNamed("/SelectSurgery");
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold();
  }
}

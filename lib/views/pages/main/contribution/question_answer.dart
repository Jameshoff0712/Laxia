import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class QuestionAnswer extends StatefulWidget {
  const QuestionAnswer({Key? key}) : super(key: key);

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer> {
  final _titleController = TextEditingController();
  bool isTitleNotEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height - 54,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Helper.whiteColor,
          shadowColor: Helper.whiteColor,
          title: Text(
            '質問と回答',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Helper.titleColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Helper.titleColor,
              size: 25,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            color: Helper.whiteColor,
            padding: EdgeInsets.fromLTRB(16, 13, 16, 5),
            child: Column(children: [
              Stack(children: [
                TextFormField(
                  cursorColor: Helper.mainColor,
                  // cursorHeight: 14,
                  
                  controller: _titleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  maxLength: 60,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        isTitleNotEmpty = true;
                        // isAddEnabled = true;
                      });
                    } else {
                      setState(() {
                        isTitleNotEmpty = false;
                        // isAddEnabled = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '質問（必須60文字）',
                    hintStyle: TextStyle(
                      color: Helper.txtColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 159, 171))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 140, 159, 171))),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(1, 6, 0, 3),
                    counterText: "",
                  ),
                ),

                isTitleNotEmpty
                        ? Positioned(
                            top: 10,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _titleController.text = '';
                                setState(() {
                                  isTitleNotEmpty = false;
                                });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 102, 110, 110),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(Icons.close,
                                    color: Colors.white, size: 15),
                              ),
                            ),
                          )
                        : Container(),
              ]),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: Helper.mainColor,
                  maxLength: 1000,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        // isAddEnabled = true;
                      });
                    } else {
                      setState(() {
                        // isAddEnabled = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '回答（必須1000文字以内）',
                    hintStyle: TextStyle(
                      color: Helper.txtColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                    counterText: "",
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 42,
                  margin: EdgeInsets.only(left: 26, right: 26),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      primary: Helper.mainColor,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                      splashFactory: NoSplash.splashFactory,
                      shadowColor: Colors.transparent,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '保存する',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

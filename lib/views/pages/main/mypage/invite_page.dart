import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/mypage/input_code_page.dart';
import 'package:laxia/views/pages/main/mypage/invite_share_page.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  bool isCopied = false;
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
            'お友達を招待',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5,
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
              )),
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'あなたにも友達にも\n3000円分のポイントをプレゼント',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.4,
                    color: Helper.mainColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'ラシアをまだ利用されていないお友達に紹介すると、紹介したあなたとお友達にも3000円分のポイントをプレゼントさせていただきます。',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: Helper.blackColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'あなたの紹介コード',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.5,
                  color: Helper.maintxtColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                    color: Helper.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 0), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                    ]),
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Color.fromARGB(255, 245, 245, 245),
                            filled: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCopied = true;
                                });
                                Future.delayed(Duration(seconds: 2)).then((_) {
                                  setState(() {
                                    isCopied = false;
                                  });
                                });
                              },
                              child:
                                  Icon(Icons.copy, color: Helper.maintxtColor),
                            ),
                          ),
                          onChanged: (text) {},
                        ),
                        isCopied
                            ? Align(
                                alignment: Alignment.center,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 32),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(128, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      "コピーしました",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Helper.whiteColor,
                                      ),
                                    )),
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return InviteSharePage();
                          },
                          isScrollControlled: true,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 48),
                        decoration: BoxDecoration(
                          color: Helper.mainColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.ios_share_sharp,
                                color: Helper.whiteColor),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              '招待コードを友達に送る',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.5,
                                color: Helper.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                  context: context,
                  builder: (context) {
                    return InputCodePage();
                  },
                  isScrollControlled: true,
                );
              },
              child: Text(
                'すでに紹介コードをお持ち方はこちら',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5,
                  color: Helper.mainColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

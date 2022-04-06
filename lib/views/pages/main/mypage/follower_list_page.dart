import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/mypage/follower_card_widget.dart';

class FollowerListPage extends StatefulWidget {
  const FollowerListPage({Key? key}) : super(key: key);

  @override
  State<FollowerListPage> createState() => _FollowerListPageState();
}

class _FollowerListPageState extends State<FollowerListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Helper.whiteColor,
          shadowColor: Helper.whiteColor,
          title: Text(
            'フォロワー',
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 40,
              )),
          elevation: 0,
        ),
        body: !true
            ? Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: FollowerCardWidget(),
                          );
                        },
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                      );
                    }),
                  )
                ],
              )
            : Center(
                child: Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset('images/LAXIA.png'),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'まだあなたをフォローしている\nユーザーがいません',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Helper.txtColor,
                      ),
                    )
                  ],
                )),
              ));
  }
}

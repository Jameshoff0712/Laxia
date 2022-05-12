import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/views/pages/main/mypage/follower_card_widget.dart';

class FollowerListPage extends StatefulWidget {
  const FollowerListPage({Key? key}) : super(key: key);

  @override
  State<FollowerListPage> createState() => _FollowerListPageState();
}

class _FollowerListPageState extends State<FollowerListPage> {
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  List mid = [];
  late Follow follower_data;
  final MyController _con = MyController();
  Future<void> getFollowers({required String page}) async {
    try {
      if (!isend) {
        if (!isloading) {
          setState(() {
            isexpanding = false;
          });
        }
        final mid = await _con.getFollowers(page: page);
        setState(() {
          if (isloading) {
            follower_data = mid;
            isloading = false;
          } else {
            follower_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      isexpanding = true;
      isend = true;
      setState(() {
        print(e.toString());
      });
    }
  }

  @override
  void initState() {
    getFollowers(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Helper.whiteColor,
          shadowColor: Helper.whiteColor,
          title: Text(
            'フォロワー',
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
                Icons.keyboard_arrow_left,
                color: Helper.titleColor,
                size: 30,
              )),
          elevation: 0,
        ),
        body: isloading
            ? Container(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: Center(
                    child: new CircularProgressIndicator(),
                  ),
                ),
              )
            : Container(
                child: follower_data.data.length != 0
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: LayoutBuilder(builder:
                                (context, BoxConstraints viewportConstraints) {
                              return NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                    if (isexpanding) {
                                      getFollowers(page: (page + 1).toString());
                                      setState(() {
                                        page += 1;
                                      });
                                    }
                                  }
                                  return true;
                                },
                                child: Column(children: [
                                  ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        child: FollowerCardWidget(
                                            photo: follower_data
                                                .data[index].photo!,
                                            name:
                                                follower_data.data[index].name!,
                                            nickname: follower_data
                                                .data[index].nickname!),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: AlwaysScrollableScrollPhysics(),
                                  ),
                                  isexpanding
                                      ? Container()
                                      : Container(
                                          height: 100,
                                          color: Colors.transparent,
                                          child: Center(
                                            child:
                                                new CircularProgressIndicator(),
                                          ),
                                        )
                                ]),
                              );
                            }),
                          )
                        ],
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Image.asset('assets/images/LAXIA.png'),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              'まだあなたをフォローしている\nユーザーがいません',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                                color: Helper.txtColor,
                              ),
                            )
                          ],
                        ),
                      )));
  }
}

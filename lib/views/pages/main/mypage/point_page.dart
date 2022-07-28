import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/models/point/point_sub_model.dart';
import 'package:laxia/models/point_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  bool isLoading = true;
  List<Point_Sub_Model> mid = [];
  late Point pointInfo;
  final MyController _con = MyController();
  late UserProvider userProperties;

  final _conAuth = AuthController();
    late Me myInfo;

  List<PointForDay> allPointsInfo = [];
  String tmpDate = "";
  String dateForDay = "";
  Future<void> getPointInfo() async {
    try {
      final me = await _conAuth.getMe();
      final res = await _con.getPointInfo();
      setState(() {
        mid.addAll(res.data!);
      });

      PointForDay pointForDay = new PointForDay();
      for (int i = mid.length - 1; i >= 0; i--) {
        if (tmpDate != mid[i].create_at!.substring(0, 10)) {
          setState(() {
            if (pointForDay.items != null) {
              allPointsInfo.add(pointForDay);
              // print(pointForDay.items![0].title);
            }
          });
          tmpDate = mid[i].create_at!.substring(0, 10);
          final splitted = tmpDate.split("-");
          dateForDay = "";
          dateForDay += int.parse(splitted[0]).toString() +
              "年" +
              int.parse(splitted[1]).toString() +
              "月" +
              int.parse(splitted[2]).toString() +
              "日";
          pointForDay = new PointForDay();
          pointForDay.date = dateForDay;
          pointForDay.items = [];
        }
        PointItem pointItem = new PointItem();
        pointItem.title = mid[i].title;
        pointItem.use_point = mid[i].use_point;
        setState(() {
          pointForDay.items?.add(pointItem);
        });
      }
      setState(() {
        myInfo = me;
        allPointsInfo.add(pointForDay);
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getPointInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProperties = Provider.of<UserProvider>(context, listen: true);
    return !isLoading ?
    Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'ポイント',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
              size: 30,
            )),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '保有ポイント',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    
                    color: Helper.titleColor,
                  ),
                ),
                Text(
                  '${myInfo.point} P',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    
                    color: Helper.titleColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'ポイントの使い方についてはこちら',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      
                      color: Helper.mainColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 18,
                    color: Helper.mainColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            '履歴',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              
              color: Helper.maintxtColor,
            ),
          ),
          !isLoading
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        children: List.generate(
                      allPointsInfo.length,
                      (index) => _buildPointHistoryInfo(index),
                    )),
                  ),
                ))
              : Container(
                  child: Container(
                  height: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Center(
                    child: new CircularProgressIndicator(),
                  ),
                )),
        ],
      ),
    )
    : Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ));
  }

  Column _buildPointHistoryInfo(int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            allPointsInfo[index].date!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              
              color: Helper.titleColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: allPointsInfo[index].items!.length,
          itemBuilder: (BuildContext context, int subIndex) {
            return _buildPointHistoryRow(
                allPointsInfo[index].items![subIndex].title!,
                allPointsInfo[index].items![subIndex].use_point!);
          },
        ),
      ],
    );
  }

  Container _buildPointHistoryRow(String type, int price) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              
              color: Helper.titleColor,
            ),
          ),
          Text(
            '$price P',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              
              color: price > 0 ? Helper.mainColor : Helper.titleColor,
            ),
          )
        ],
      ),
    );
  }
}

class PointForDay {
  String? date;
  List<PointItem>? items;
  PointForDay();
}

class PointItem {
  String? title;
  int? use_point;
  PointItem();
}

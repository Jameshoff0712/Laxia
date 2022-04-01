import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/point_model.dart';

class PointPage extends StatefulWidget {
  const PointPage({Key? key}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'ポイント',
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
                    height: 1.5,
                    color: Helper.titleColor,
                  ),
                ),
                Text(
                  '2500 P',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 1.5,
                    color: Helper.titleColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
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
                      height: 1.5,
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
              height: 1.5,
              color: Helper.maintxtColor,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(
                  point_info.length, 
                  (index) => _buildPointHistoryInfo(index),
                )
              ),
            ),
          )),
        ],
      ),
    );
  }

  Column _buildPointHistoryInfo(int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            point_info[index]["date"],
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.5,
              color: Helper.titleColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: point_info[index]["items"].length,
          itemBuilder: (BuildContext context, int subIndex) {
            return _buildPointHistoryRow(point_info[index]["items"][subIndex]["type"], point_info[index]["items"][subIndex]["price"]);
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
              height: 1.5,
              color: Helper.titleColor,
            ),
          ),
          Text(
            '$price P',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              height: 1.5,
              color: price > 0 ? Helper.mainColor : Helper.titleColor,
            ),
          )
        ],
      ),
    );
  }
}

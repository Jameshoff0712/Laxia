import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/chatStatus.dart';
import 'package:laxia/views/widgets/tabbar.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  final List<String> tabMenus = [
    'すべて',
    '調整中',
    '予約済',
    '来院済',
    '施術履歴',
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return chat(avatar: 'images/brazil.png', chatContent: 'ryu', sendTime: '10:21',);
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         width: 32,
    //         height: 32,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(16),
    //         ),
    //         child: Image.asset('images/brazil.png'),
    //       ),
    //       SizedBox(width: 8,),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Container(
    //             padding: EdgeInsets.all(10),
    //             width: MediaQuery.of(context).size.width - 72,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
    //               color: Colors.red,        
    //             ),
    //             child: Text(
    //               'ご予約ありがとうございます。ただいま、調整中でございます。追ってご連絡差し上げます。',
    //               style: TextStyle(
    //                 fontFamily: 'Hiragino Kaku Gothic Pro',
    //                 fontWeight: FontWeight.w400,
    //                 fontSize: 14,
    //                 color: Color.fromARGB(255, 51, 51, 51),
    //                 decoration: TextDecoration.none,
    //                 height: 1.8,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 4,),
    //           Align(
    //             alignment: Alignment.topRight,
    //             child: Text(
    //               '10:21',
    //               style: TextStyle(
    //                 fontFamily: 'Hiragino Kaku Gothic Pro',
    //                 fontWeight: FontWeight.w400,
    //                 fontSize: 12,
    //                 color: Color.fromARGB(255, 156, 161, 161),
    //                 decoration: TextDecoration.none,
    //                 height: 1.5,
    //               ),
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   )
    // );


    // return Column(
    //   children: [
    //     chatStatus(statusCode: 1, clinicName: '湘南美容クリニック 銀座院'),
    //     chatStatus(statusCode: 2, clinicName: '湘南美容クリニック 銀座院', bookDate: '予約日時：2020/07/25 11：００〜',),
    //     chatStatus(statusCode: 3, clinicName: '湘南美容クリニック 銀座院'),
    //     chatStatus(statusCode: 4, clinicName: '湘南美容クリニック 銀座院'),
    //     chatStatus(statusCode: 1, clinicName: '湘南美容クリニック 銀座院', notificCount: 4,),
    //   ],
    // );

    
  
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 44,
            ),
            Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, right: 32, bottom: 12, left: 32),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '予約',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Hiragino Kaku Gothic Pro',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromARGB(255, 51, 51, 51),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  child: IconButton(
                    icon: Icon(Icons.chevron_left),
                    color: Color.fromARGB(255, 51, 51, 51),
                    // iconSize: 16,
                    onPressed: () {},
                  ),
                )
              ],
            ),
            TabBarWidget(
              tabMenus: tabMenus,
              tabController: _tabController,
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Expanded(
                    child: Container(color: Color.fromARGB(255, 240, 242, 245), child: _buildEmptyClinic()),
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 240, 242, 245),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          chatStatus(statusCode: 1, clinicName: '湘南美容クリニック 銀座院'),
                          chatStatus(statusCode: 2, clinicName: '湘南美容クリニック 銀座院', bookDate: '予約日時：2020/07/25 11：００〜',),
                          chatStatus(statusCode: 3, clinicName: '湘南美容クリニック 銀座院'),
                          chatStatus(statusCode: 4, clinicName: '湘南美容クリニック 銀座院'),
                          chatStatus(statusCode: 1, clinicName: '湘南美容クリニック 銀座院', notificCount: 4,),
                        ],
                      ),
                    ),
                  ),
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_transit)),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyClinic() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '予約済みのクリニックはまだありません',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color.fromARGB(255, 102, 110, 110),
          ),
        ),
        Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            SizedBox(width: double.infinity, height: 64),
            TextButton(
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.only(left: 62, right: 62),
                height: 44,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 110, 198, 210),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 15),
                  child: Text(
                    'クリニックを探す',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Hiragino Kaku Gothic Pro',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Helper.whiteColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

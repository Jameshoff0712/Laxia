import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/chatStatus.dart';
import 'package:laxia/views/widgets/tabbar.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

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
  bool isEmpty = true;
  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                child: Container(
                  color: Color.fromARGB(255, 240, 242, 245),
                  child: isEmpty
                      ? _buildEmptyClinic()
                      : Expanded(
                          child: Container(
                            color: Color.fromARGB(255, 240, 242, 245),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                chatStatus(
                                    statusCode: 1, clinicName: '湘南美容クリニック 銀座院'),
                                chatStatus(
                                  statusCode: 2,
                                  clinicName: '湘南美容クリニック 銀座院',
                                  bookDate: '予約日時：2020/07/25 11：００〜',
                                ),
                                chatStatus(
                                    statusCode: 3, clinicName: '湘南美容クリニック 銀座院'),
                                chatStatus(
                                    statusCode: 4, clinicName: '湘南美容クリニック 銀座院'),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 240, 242, 245),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      chatStatus(statusCode: 1, clinicName: '湘南美容クリニック 銀座院'),
                      chatStatus(
                        statusCode: 1,
                        clinicName: '湘南美容クリニック 銀座院',
                        notificCount: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 240, 242, 245),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      chatStatus(
                        statusCode: 2,
                        clinicName: '湘南美容クリニック 銀座院',
                        bookDate: '予約日時：2020/07/25 11：００〜',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 240, 242, 245),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      chatStatus(statusCode: 3, clinicName: '湘南美容クリニック 銀座院'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 240, 242, 245),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      chatStatus(statusCode: 4, clinicName: '湘南美容クリニック 銀座院'),
                    ],
                  ),
                ),
              ),
            ],
            controller: _tabController,
          ),
        ),
      ],
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
                  color: Color.fromARGB(255, 0, 184, 169),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 15),
                  child: Text(
                    'クリニックを探す',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      
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

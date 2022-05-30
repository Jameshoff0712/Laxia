import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/reserve_controller.dart';
import 'package:laxia/controllers/status_controller.dart';
import 'package:laxia/models/status_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/chatStatus.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:provider/provider.dart';

class Appointment extends StatefulWidget {
  // final PageController pageController;
  const Appointment({
    Key? key,
    // required this.pageController,
  }) : super(key: key);

  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  final _con = ReserveController();
  final List<String> tabMenus = [
    'すべて',
    '調整中',
    '予約済',
    '来院済',
    '施術履歴',
    // '1234567'
  ];
  late TabController _tabController;
  bool isEmpty = true;
  StatusInfo? statusInfo;
  Future<void> getStatusInfo() async {
    final info = await _con.getAllStatus() as StatusInfo;
    setState(() {
      statusInfo = info;
    });

    // print(statusInfo);
  }

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    getStatusInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '予約',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              userProperties.setCurrentPageIndex(0);
              Navigator.of(context).pushNamed('/Pages');
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Helper.titleColor,
              size: 30,
            )),
        elevation: 0,
      ),
      body: Column(children: [
        TabBarWidget(
          tabMenus: tabMenus,
          tabController: _tabController,
          padding: 8,
          isScrollable: false,
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 240, 242, 245),
                      child: isEmpty
                          ? _buildEmptyClinic()
                          : ListView(
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
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 240, 242, 245),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          chatStatus(
                              statusCode: 1, clinicName: '湘南美容クリニック 銀座院'),
                          chatStatus(
                            statusCode: 1,
                            clinicName: '湘南美容クリニック 銀座院',
                            notificCount: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
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
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 240, 242, 245),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          chatStatus(
                              statusCode: 3, clinicName: '湘南美容クリニック 銀座院'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 240, 242, 245),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          chatStatus(
                              statusCode: 4, clinicName: '湘南美容クリニック 銀座院'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
            controller: _tabController,
          ),
        ),
      ]),
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
                width: 250,
                height: 44,
                // padding: EdgeInsets.only(left: 62, right: 62),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 184, 169),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
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

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
  bool isloading = true;
  late List<StatusInfo> statusInfo;
  Future<void> getStatusInfo() async {
    final info = await _con.getAllStatus();
    setState(() {
      statusInfo = info;
      isloading = false;
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
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Scaffold(
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
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
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
                isScrollable: false, onpress: () {  },
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
                            child: statusInfo.isEmpty
                                ? _buildEmptyClinic()
                                : ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                        itemCount: statusInfo.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return chatStatus(
                                        mailbox:  statusInfo[index].mailbox,
                                        statusCode: statusInfo[index].status,
                                        clinicName:
                                            statusInfo[index].clinic_name,
                                        bookDate: statusInfo[index].visit_time +
                                            "~" +
                                            statusInfo[index].visit_date,
                                      );
                                    }),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Color.fromARGB(255, 240, 242, 245),
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                 itemCount: statusInfo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return statusInfo[index].status!=5?
                                    Container()
                                  :chatStatus(
                                    mailbox:  statusInfo[index].mailbox,
                                    statusCode: statusInfo[index].status,
                                    clinicName: statusInfo[index].clinic_name,
                                    bookDate: statusInfo[index].visit_time +
                                        "~" +
                                        statusInfo[index].visit_date,
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Color.fromARGB(255, 240, 242, 245),
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: statusInfo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return statusInfo[index].status!=15?
                                    Container()
                                  :chatStatus(
                                    statusCode: statusInfo[index].status,
                                    clinicName: statusInfo[index].clinic_name,
                                    bookDate: statusInfo[index].visit_time +
                                        "~" +
                                        statusInfo[index].visit_date, 
                                    mailbox:  statusInfo[index].mailbox,
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Color.fromARGB(255, 240, 242, 245),
                            // child: ListView(
                            //   physics: const AlwaysScrollableScrollPhysics(),
                            //   children: [
                            //     chatStatus(
                            //         statusCode: 3, clinicName: '湘南美容クリニック 銀座院'),
                            //   ],
                            // ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Color.fromARGB(255, 240, 242, 245),
                            // child: ListView(
                            //   physics: const AlwaysScrollableScrollPhysics(),
                            //   children: [
                            //     chatStatus(
                            //         statusCode: 4, clinicName: '湘南美容クリニック 銀座院'),
                            //   ],
                            // ),
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
              style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
              ),
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

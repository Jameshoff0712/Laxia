import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/reserve_controller.dart';
import 'package:laxia/controllers/status_controller.dart';
import 'package:laxia/models/status_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/chatStatus.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:provider/provider.dart';

class Appointment extends StatefulWidget {
  final int id;
  // final PageController pageController;
  const Appointment({
    Key? key, required this.id,
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
  final pusher_key = dotenv.env["PUSHER_APP_KEY"];
  final pusher_cluseter = dotenv.env["PUSHER_APP_CLUSTER"];
  final pusher_authurl=dotenv.env['PUSHER_AUTHURL'];
  late Echo echo;
  late PusherOptions options;
  late FlutterPusher pusher;
  void increaseCount(int id){
    print(statusInfo.length);
    for(int i=0;statusInfo.length>i;i++){
      print(statusInfo[i].mailbox);
      if(statusInfo[i].mailbox==id){
        
        setState(() {
          counts[i]++;
        });
        return;
      }
    }
  }
  List<int> counts=[];
  Future<void> initEcho() async {
    // print(pusher_authurl);
    // final token=await preferenceUtil.getToken();
    options = PusherOptions(
      host:'ws-ap3.pusher.com',
      port: 443,
      encrypted: true,
      cluster: pusher_cluseter!,
      //  auth: PusherAuth(
      //       pusher_authurl,
      //       headers: {
      //         'Authorization': token!
      //       },
      //     ),
    );
    pusher = FlutterPusher(pusher_key, options, enableLogging: false,  onConnectionStateChange: (ConnectionStateChange x) async {
        print(x.currentState);
         if (pusher != null && (x.currentState == 'CONNECTED'|| x.currentState == 'connected')) {
          final String socketId = pusher.getSocketId();
          print('pusher socket id: $socketId');
           echo =new Echo({
              'broadcaster':'pusher',
              'client':pusher,
              'key': pusher_key,
              'cluster':pusher_cluseter
              // 'host':"sockjs-ap3.pusher.com/pusher",
              // 'auth': {
              //       'headers': {
              //           'Authorization': '$token',
              //       }
              //   }
            });
            echo.channel('broadcast.'+widget.id.toString()).listen('.private-chat-event', (res) {
              increaseCount(res['message']['mailbox_id']);
              print(res);
            });
            print('broadcast.'+widget.id.toString());
         }
    },onError: (ConnectionError y)=>{
        print(y.exception)
    });
  }
  Future<void> getStatusInfo() async {
    final info = await _con.getAllStatus();
    setState(() {
       for(int i=0;i<info.length;i++){
        counts.add(0);
        }
      statusInfo = info;
      isloading = false;
    });

    // print(statusInfo);
  }

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    getStatusInfo();
    initEcho();
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
                                        notificCount:counts[index] ,
                                        mailbox:  statusInfo[index].mailbox,
                                        is_now:  statusInfo[index].is_now,
                                        statusCode: statusInfo[index].status,
                                        clinicName:
                                            statusInfo[index].clinic_name,
                                        bookDate:'予約日時：'+statusInfo[index].visit_date+':'+
                                        statusInfo[index].visit_time+"~", 
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
                                    notificCount:counts[index] ,
                                    mailbox:  statusInfo[index].mailbox,
                                    statusCode: statusInfo[index].status,
                                    clinicName: statusInfo[index].clinic_name,
                                    bookDate: '予約日時：'+statusInfo[index].visit_date+':'+
                                        statusInfo[index].visit_time+"~", 
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
                                  return statusInfo[index].status!=15&&statusInfo[index].is_now?
                                    Container()
                                  :chatStatus(
                                    notificCount:counts[index] ,
                                    statusCode: statusInfo[index].status,
                                    clinicName: statusInfo[index].clinic_name,
                                    bookDate:'予約日時：'+statusInfo[index].visit_date+':'+
                                        statusInfo[index].visit_time+"~", 
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
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: statusInfo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return statusInfo[index].status!=15&&!statusInfo[index].is_now?
                                    Container()
                                  :chatStatus(
                                    is_now: true,
                                    notificCount:counts[index] ,
                                    statusCode: statusInfo[index].status,
                                    clinicName: statusInfo[index].clinic_name,
                                    bookDate:'予約日時：'+statusInfo[index].visit_date+':'+
                                        statusInfo[index].visit_time+"~", 
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
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: statusInfo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return statusInfo[index].status!=25?
                                    Container()
                                  :chatStatus(
                                    notificCount:counts[index] ,
                                    statusCode: statusInfo[index].status,
                                    clinicName: statusInfo[index].clinic_name,
                                    bookDate:'予約日時：'+statusInfo[index].visit_date+':'+
                                        statusInfo[index].visit_time+"~", 
                                    mailbox:  statusInfo[index].mailbox,
                                  );
                                }),
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

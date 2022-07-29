import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
// import 'package:laxia/models/m_message.dart';
// import 'package:laxia/models/m_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laxia/models/static/message_model.dart';
import 'package:laxia/utils/preference_util.dart';
import 'package:laxia/views/widgets/chatSlot.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laxia/services/http/api.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:laxia/controllers/static_controller.dart';

class ChatScreen extends StatefulWidget{
  final int mailbox_id;
  ChatScreen({required this.mailbox_id});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final PreferenceUtil preferenceUtil = PreferenceUtil();
  // String? token = await PreferenceUtil().getToken();
  final pusher_key = dotenv.env["PUSHER_APP_KEY"];
  final pusher_cluseter = dotenv.env["PUSHER_APP_CLUSTER"];
  final pusher_authurl=dotenv.env['PUSHER_AUTHURL'];
  final textController = TextEditingController();
  String contentChat = '';
  late Echo echo;
  late PusherOptions options;
  late FlutterPusher pusher; 
  final _con = StaticController();
  bool isloading = true;
  late List<Message_Model> messages;
  late Message_Model new_message;
  ScrollController scrollcontroller=new ScrollController();
  Future<void> getmessages() async {
    try {
      final mid = await _con.getMessages(widget.mailbox_id.toString());
      print(mid);
      setState(() {
        messages = mid;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> postMessage({required String value,int isfile=0}) async {
    try {
      try{
        new_message=await _con.postMessage(value,isfile,widget.mailbox_id.toString());
        textController.text='';
        setState(() {
          messages.add(new_message);
        });
        scrollcontroller.jumpTo(scrollcontroller.position.maxScrollExtent);
      }
      catch(e){
        
      }
      
    } catch (e) {
      print(e.toString());
    }
  }
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
         if (pusher != null && x.currentState == 'CONNECTED') {
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
            echo.channel('Chat.'+widget.mailbox_id.toString()).listen('.private-chat-event', (res) {
               res['message']['is_mine']=false;
               
               setState(() {
                new_message=Message_Model.fromJson(res['message']);
                if(new_message.sender!.photo!=null)
                  messages.add(new_message);
               });
               scrollcontroller.jumpTo(scrollcontroller.position.maxScrollExtent);
            });
            print('Chat.'+widget.mailbox_id.toString());
         }
    },onError: (ConnectionError y)=>{
        print(y.exception)
    });
    
    // pusher.subscribe('private-Chat.109').bind('.private-chat-event', (){
    //   print('e');
    // });
    // print('Chat.'+widget.mailbox_id.toString());
  }
  @override
  void initState() {
    getmessages();
    initEcho();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    :Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '湘南美容クリニック　銀座院',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
            icon: Icon(
              Icons.close,
              color: Helper.titleColor,
              size: 25,
            )),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Color.fromARGB(255, 240, 242, 245),
                child: ListView.builder(
                    controller: scrollcontroller,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatSlot(message: messages[index]);
                    }),
              )),
         
        ],
      ),
      bottomNavigationBar: _buildSendMessageBox() ,
    );
  }

  Widget _buildSendMessageBox() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
        color: Helper.whiteColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                onChanged: (value) {
                  setState(() {
                    contentChat = value;
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color.fromARGB(255, 245, 245, 245),
                  filled: true,
                  hintText: 'メッセージを入力',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 156, 161, 161),
                    fontSize: 12,
                    
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 12,
                  
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
              ),
            ),
            SizedBox(width: 0),
            IconButton(
              icon: Icon(
                Icons.send,
                color: contentChat.isEmpty
                    ? Color.fromARGB(255, 222, 222, 222)
                    : Color.fromARGB(255, 0, 184, 169),
                size: 22,
              ),
              alignment: Alignment.bottomCenter,
              onPressed: () {
                postMessage(value: contentChat);
              },
            )
          ],
        ),
      ),
    );
  }
}

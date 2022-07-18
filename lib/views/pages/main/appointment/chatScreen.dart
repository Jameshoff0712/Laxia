import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
// import 'package:laxia/models/m_message.dart';
// import 'package:laxia/models/m_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laxia/utils/preference_util.dart';
import 'package:laxia/views/widgets/chatSlot.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laxia/services/http/api.dart';
import 'package:laravel_echo/laravel_echo.dart';

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
  final textController = TextEditingController();
  String contentChat = '';
  late Echo echo;
  PusherOptions options = PusherOptions(
    host: 'localhost',
    port: 8000,
    encrypted: true,
  );
  late FlutterPusher pusher;
  Future<void> initEcho() async {
    final token=await preferenceUtil.getToken();
    options= PusherOptions(
    host: 'https://4b3a-45-126-3-252.ap.ngrok.io ',
    port: 8000,
    auth: PusherAuth(
            'https://4b3a-45-126-3-252.ap.ngrok.io/broadcasting/auth',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer '+token!
            },
          ),
    encrypted: true,
  );
    pusher = FlutterPusher('app', options, enableLogging: false);
    echo =new Echo({
      'broadcaster':'pusher',
      'client':pusher,
      'key': pusher_key,
      'cluster': pusher_cluseter,
      'auth':{
        'headers':{
          'Authorization': 'Bearer '+token
        }
      }
    });
    echo.private('Chat.'+widget.mailbox_id.toString()).listen('private-chat-event', (e) {
      print(e);
    });
    print('Chat.'+widget.mailbox_id.toString());
  }
  @override
  void initState() {
    initEcho();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return Scaffold(
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
          // Expanded(
          //     child: Container(
          //       color: Color.fromARGB(255, 240, 242, 245),
          //       child: ListView.builder(
          //           reverse: true,
          //           itemCount: messages.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             final Message message = messages[index];
          //             final bool isMe = message.sender!.id == currentUser.id;
          //             prevUserId = message.sender!.id;
          //             return ChatSlot(message: message, isMe: isMe);
          //           }),
          //     )),
         
        ],
      ),
      bottomNavigationBar:Container(
        child: Column(children: [
           _buildSendMessageBox(),
        ]),
      ) ,
    );
  }

  Widget _buildSendMessageBox() {
    return Column(
      children: [
        Container(
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
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          height: 33,
          color: Helper.whiteColor,
        ),
      ],
    );
  }
}

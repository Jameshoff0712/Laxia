import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_message.dart';
import 'package:laxia/models/m_user.dart';

class ChatScreen extends StatefulWidget {
  final User? user;
  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return Scaffold(
      backgroundColor: Helper.lightGrey,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            color: Colors.white,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 22,
                    color: Color.fromARGB(255, 51, 51, 51),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  '湘南美容クリニック　銀座院',
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )
                ),
                SizedBox(width: 40,)
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.sender!.id == currentUser.id;
                    final bool isSameUser = prevUserId == message.sender!.id;
                    prevUserId = message.sender!.id;
                    return _buildChatSlot(message, isMe, isSameUser);
                  })),
          SizedBox(
            height: 24,
          ),
          _buildSendMessageBox(),
        ],
      ),
    );
  }

  Widget _buildChatSlot(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Container(
        margin: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.topRight,
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 110, 198, 210),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Text(
                              message.text!,
                              style: TextStyle(
                                  fontFamily: 'Hiragino Kaku Gothic Pro',
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1.8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        message.time!,
                        style: TextStyle(
                            fontFamily: 'Hiragino Kaku Gothic Pro',
                            color: Color.fromARGB(255, 156, 161, 161),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.5),
                      )
                    ],
                  ),
                ),
              ),
            ]),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: SizedBox(
                height: 32,
                width: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: message.sender!.imageUrl!,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Container(
                                child: Text(
                                  message.text!,
                                  style: TextStyle(
                                      fontFamily: 'Hiragino Kaku Gothic Pro',
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            message.time!,
                            style: TextStyle(
                                fontFamily: 'Hiragino Kaku Gothic Pro',
                                color: Color.fromARGB(255, 156, 161, 161),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      );
    }
  }

  Widget _buildSendMessageBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
      // height: 50,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 156, 161, 161),
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 156, 161, 161),
                    )),
                hintText: 'Name of pill',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 156, 161, 161),
                  fontFamily: 'Hiragino Kaku Gothic Pro',
                  fontSize: 12,
                  // height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontFamily: 'Hiragino Kaku Gothic Pro',
                fontSize: 12,
                // height: 1.5,
                fontWeight: FontWeight.w400,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          SizedBox(width: 15),
          Icon(
            Icons.send,
            color: Color.fromARGB(255, 222, 222, 222),
            size: 20,
          )
        ],
      ),
    );
  }
}

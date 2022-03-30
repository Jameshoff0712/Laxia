import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_message.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/views/widgets/chatSlot.dart';

class ChatScreen extends StatefulWidget {
  final User? user;
  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  String contentChat = '';
  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return Scaffold(
      backgroundColor: Helper.lightGrey,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Helper.whiteColor,
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
                Text('湘南美容クリニック　銀座院',
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  width: 40,
                )
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
                    prevUserId = message.sender!.id;
                    return ChatSlot(message: message, isMe: isMe);
                  })),
          SizedBox(
            height: 24,
          ),
          _buildSendMessageBox(),
        ],
      ),
    );
  }

  Widget _buildSendMessageBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
      // height: 50,
      color: Helper.whiteColor,
      child: Row(
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
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromARGB(255, 245, 245, 245),
                filled: true,
                hintText: 'Name of pill',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 156, 161, 161),
                  
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
            ),
          ),
          SizedBox(width: 15),
          IconButton(
            icon: Icon(
              Icons.send,
              color: contentChat.isEmpty
                  ? Color.fromARGB(255, 222, 222, 222)
                  : Color.fromARGB(255, 0, 184, 169),
              size: 20,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

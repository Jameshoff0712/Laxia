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
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '湘南美容クリニック　銀座院',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
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
              SizedBox(width: 0),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: contentChat.isEmpty
                      ? Color.fromARGB(255, 222, 222, 222)
                      : Color.fromARGB(255, 0, 184, 169),
                  size: 20,
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

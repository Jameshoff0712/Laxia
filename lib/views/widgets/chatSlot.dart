import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_message.dart';

class ChatSlot extends StatefulWidget {
  final Message message;
  final bool isMe;
  const ChatSlot({ Key? key, required this.message, required this.isMe }) : super(key: key);

  @override
  State<ChatSlot> createState() => _ChatSlotState();
}

class _ChatSlotState extends State<ChatSlot> {
  @override
  Widget build(BuildContext context) {
    
    if (widget.isMe) {
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
                              widget.message.text!,
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
                        widget.message.time!,
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
                    imageUrl: widget.message.sender!.imageUrl!,
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
                        color: Helper.whiteColor,
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
                                  widget.message.text!,
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
                            widget.message.time!,
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
}
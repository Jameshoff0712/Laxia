import 'package:flutter/material.dart';
import 'package:laxia/models/m_message.dart';
import 'package:laxia/views/pages/main/appointment/chatScreen.dart';
import 'package:laxia/common/helper.dart';

class chatStatus extends StatefulWidget {
  final int statusCode;
  final int mailbox;
  final String clinicName;
  final String? bookDate;
  final int? notificCount;
  final bool? is_now;

  const chatStatus(
      {Key? key,
      required this.mailbox,
      required this.statusCode,
      required this.clinicName,
      this.bookDate,
      this.notificCount, this.is_now=false})
      : super(key: key);

  @override
  State<chatStatus> createState() => _chatStatusState();
}

class _chatStatusState extends State<chatStatus> {
  late String statusText;
  late Color statusColor;
  void initState() {
    setState(() {
      switch (widget.statusCode) {
        case 5:
          {
            statusText = '調整中';
            statusColor = Color.fromARGB(255, 102, 110, 110);
          }
          break;
        case 15:
          {
            statusText = '予約済';
            statusColor = Color.fromARGB(255, 0, 184, 169);
            if(widget.is_now!){
              statusText = '来院済';
              statusColor = Color.fromARGB(255,245, 184, 91);
            }
          }
          break;
        case 3:
          {
            statusText = '来院済';
            statusColor = Color.fromARGB(255, 245, 184, 91);
          }
          break;
        case 25:
          {
            statusText = '施術完';
            statusColor = Color.fromARGB(255, 241, 85, 85);
          }
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  toChatScreen,
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 15, right: 10),
        margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: statusColor,
              ),
              child: Center(
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    widget.clinicName,
                    style: TextStyle(
                      fontSize: 16,
                      
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 51, 51, 51),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                if (widget.notificCount == null||widget.notificCount==0)
                  Container()
                else
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Color.fromARGB(255, 249, 161, 56),
                        ),
                        child: Center(
                          child: Text(
                            widget.notificCount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            widget.bookDate == null
                ? Container()
                : Container(
                    child: Text(
                       widget.statusCode!=15?"": widget.bookDate!,
                      style: TextStyle(
                        fontSize: 12,
                        
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 156, 161, 161),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void toChatScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(mailbox_id: widget.mailbox)));
  }
}

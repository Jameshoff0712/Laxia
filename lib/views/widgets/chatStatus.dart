import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class chatStatus extends StatefulWidget {
  final int statusCode;
  final String clinicName;
  final String? bookDate;
  final int? notificCount;

  const chatStatus({ Key? key, required this.statusCode, required this.clinicName, this.bookDate, this.notificCount }) : super(key: key);

  @override
  State<chatStatus> createState() => _chatStatusState();
}

class _chatStatusState extends State<chatStatus> {
  late String statusText;
  late Color statusColor;
  void initState() {
    setState(() {
      switch(widget.statusCode){
        case 1: {
          statusText = '調整中';
          statusColor = Color.fromARGB(255, 102, 110, 110);
        }
        break;
        case 2: {
          statusText = '予約済';
          statusColor = Color.fromARGB(255, 110, 198, 210);
        }
        break;
        case 3: {
          statusText = '来院済';
          statusColor = Color.fromARGB(255, 245, 184, 91);
        }
        break;
        case 4: {
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Helper.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: statusColor,
                ),
                child: Center(
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontFamily: 'Hiragino Kaku Gothic Pro',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Helper.whiteColor,
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
                    height: 24,
                    child: Text(
                      '湘南美容クリニック 銀座院',
                      style: TextStyle(
                        fontFamily: 'Hiragino Kaku Gothic Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 51, 51, 51),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  if (widget.notificCount == null) Container() else Expanded(
                    child: 
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: Color.fromARGB(255, 240, 154, 55),
                          ),
                          child: Center(
                            child: Text(
                              widget.notificCount.toString(),
                              style: TextStyle(
                                fontFamily: 'Hiragino Kaku Gothic Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Helper.whiteColor,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                  )
                ],
              ),
              widget.bookDate == null ? Container() : Container(
                height: 18,
                child: Text(
                  '予約日時：2020/07/25 11：００〜',
                  style: TextStyle(
                    fontFamily: 'Hiragino Kaku Gothic Pro',
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
      ],
    );
  }
}
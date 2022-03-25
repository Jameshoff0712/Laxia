import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  final String avatar;
  final String chatContent;
  final String sendTime;

  const chat({ Key? key, required this.avatar, required this.chatContent, required this.sendTime }) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(widget.avatar),
          ),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 172,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  color: Colors.red,        
                ),
                child: Text(
                  widget.chatContent,
                  style: TextStyle(
                    fontFamily: 'Hiragino Kaku Gothic Pro',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color.fromARGB(255, 51, 51, 51),
                    decoration: TextDecoration.none,
                    height: 1.8,
                  ),
                ),
              ),
              SizedBox(height: 4,),
              Text(
                widget.sendTime,
                style: TextStyle(
                  fontFamily: 'Hiragino Kaku Gothic Pro',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromARGB(255, 156, 161, 161),
                  decoration: TextDecoration.none,
                  height: 1.5,
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
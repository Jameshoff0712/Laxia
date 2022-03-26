import 'package:flutter/material.dart';
import 'package:laxia/views/widgets/narrowdown.dart';

class NarrowDiary extends StatefulWidget {
  const NarrowDiary({ Key? key }) : super(key: key);

  @override
  State<NarrowDiary> createState() => _NarrowDiaryState();
}

class _NarrowDiaryState extends State<NarrowDiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NarrowDownn(isStar: true,),
    );
  }
}
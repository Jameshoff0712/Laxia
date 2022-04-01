import 'package:flutter/material.dart';
import 'package:laxia/views/widgets/narrowdown.dart';

class NarrowCase extends StatefulWidget {
  const NarrowCase({ Key? key }) : super(key: key);

  @override
  State<NarrowCase> createState() => _NarrowCaseState();
}

class _NarrowCaseState extends State<NarrowCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NarrowDownn(isStar: false,),
    );
  }
}
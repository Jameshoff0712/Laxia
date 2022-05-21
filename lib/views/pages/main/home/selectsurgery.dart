import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/static_controller.dart';
import 'package:laxia/models/static/master_model.dart';
import 'dart:convert';
import 'package:laxia/views/widgets/multiselect.dart';

class SelectSurgery extends StatefulWidget {
  const SelectSurgery({Key? key}) : super(key: key);

  @override
  State<SelectSurgery> createState() => _SelectSurgeryState();
}

class _SelectSurgeryState extends State<SelectSurgery> {
  final _con = StaticController();
  bool isloading = true;
  late List<Master_Model> treatments;
  Future<void> getData() async {
    try {
      treatments = await _con.getTreatCategories();
      setState(() {
        isloading = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Scaffold(
            backgroundColor: Helper.whiteColor,
            body: Column(
              children: [
                MultiSelectDart(
                  treatments: treatments,
                  width: 110,
                  buttontxt: '結果を表示',
                  title: '施術箇所・内容',
                ),
              ],
            ));
  }
}

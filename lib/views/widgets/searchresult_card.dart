import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/static/midsearch_model.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/contribution/case_detail.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/pages/main/home/part/part.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  final int index;
  final List<Sub> count;
  const SearchResult(
      {Key? key,
      required this.index,
      required this.count})
      : super(key: key);
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final List<String> tabMenus = [
    '施術箇所',
    'メニュー',
    'クリニック',
    'ドクター'
  ];
  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
    return widget.count.isEmpty?
    Container():
    Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Helper.whiteColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Text(
              tabMenus[widget.index],
              style: TextStyle(
                  fontFamily: Helper.headFontFamily,
                  
                  color: Helper.titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
          for (int i = 0; i < widget.count.length; i++)
            GestureDetector(
              onTap: (){
                switch(widget.index){
                  case 1: if(widget.count[i].part_id!=null){
                              surgeryprovider.setSelectedCurePos(widget.count[i].part_id!, 'curePosStr');
                            }
                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Part(
                                              part_id: widget.count[i].part_id!,
                                                index:
                                                    widget.count[i].id))); break;
                  case 2:  Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Menu_Detail(
                                                index:
                                                    widget.count[i].id))); break;
                  case 3: Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Clinic_Detail(
                                                index:
                                                    widget.count[i].id))); break;
                  case 4: Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Doctor_Detail(
                                                index:
                                                    widget.count[i].id))); break;
                  
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.count[i].name,
                      style: TextStyle(
                          color: Helper.selectTabColor,
                          fontSize: 12,
                          
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Helper.maintxtColor,
                    )
                  ],
                ),
              ),
            )
        ]),
      ),
    );
  }
}

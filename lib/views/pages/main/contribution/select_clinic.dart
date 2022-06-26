import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

class SelectClinic extends StatefulWidget {
  const SelectClinic({Key? key}) : super(key: key);

  @override
  State<SelectClinic> createState() => _SelectClinicState();
}

class _SelectClinicState extends State<SelectClinic> {
  bool isUsed = false;
  String searchdata = "";
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  bool expanded = false;
  late Clinic clinic_data;
  final _con = HomeController();
  TextEditingController filter = new TextEditingController();
  int index = 0;
  Future<void> getclinicData(
      {required String page,
      String? pref_id = "",
      String? city_id = "",
      String? q = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getclinicData(
            page: page, pref_id: pref_id!, city_id: city_id!, q: q!);
        setState(() {
          if (isloading) {
            clinic_data = mid;
            isloading = false;
          } else {
            clinic_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      isexpanding = true;
      isend = true;
      setState(() {
        print(e.toString());
      });
    }
  }

  void init() {
    setState(() {
      isloading = true;
      isexpanding = true;
      isend = false;
      page = 1;
      expanded = false;
      index = -1;
    });
  }

  @override
  void initState() {
    isUsed = false;
    getclinicData(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    if (searchdata != userProperties.searchtext) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getclinicData(page: page.toString(), q: userProperties.searchtext);
      });
    }
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      userProperties.setSearchtext("");
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    )),
                Text(
                  "クリニック名で検索",
                  style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                      size: 16),
                ),
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Helper.whiteColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchbarWidget(
              onchange: () {
                userProperties.setSearchtext(filter.text);
              },
              state: false,
              filter: filter,
              hinttext: "クリニックを検索",
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  if (isexpanding) {
                    getclinicData(page: (page + 1).toString(), q: searchdata);
                    setState(() {
                      page += 1;
                    });
                  }
                }
                return true;
              },
              child: LayoutBuilder(
                  builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    Expanded(
                      child: isloading
                          ? Container(
                              child: Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                color: Colors.transparent,
                                child: Center(
                                  child: new CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : ListView.builder(
                              // padding: const EdgeInsets.symmetric(vertical: 4),
                              itemCount: clinic_data.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    userProperties.setSelectedClinic(
                                        clinic_data.data[index].name!);
                                    userProperties.setSearchtext("");
                                    diaryProperties.setClinicID(userProperties.getSelectedClinic);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        bottom: BorderSide(color: Color.fromARGB(255, 200, 199, 204)),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 19, vertical: 16),
                                            child: Text(
                                              clinic_data.data[index].name!,
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 51, 51, 51),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    ),
                    isexpanding
                        ? Container()
                        : Container(
                            height: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: new CircularProgressIndicator(),
                            ),
                          )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

class SelectDoctor extends StatefulWidget {
  String? clinic_id;
  SelectDoctor({Key? key, this.clinic_id}) : super(key: key);

  @override
  State<SelectDoctor> createState() => _SelectDoctorState();
}

class _SelectDoctorState extends State<SelectDoctor> {
  bool isUsed = false;
  String searchdata = "";
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  bool expanded = false;
  late Doctor doctor_data;
  final _con = HomeController();
  TextEditingController filter = new TextEditingController();
  int index = 0;
  Future<void> getDoctorData(
      {required String page,
      String? pref_id = "",
      String? city_id = "",
      String? clinic_id = "",
      String? q = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getDoctorData(page: page, q: q!, filter: '', clinic_id: clinic_id);
        print(mid.data.length);
        setState(() {
          if (isloading) {
            doctor_data = mid;
            isloading = false;
          } else {
            doctor_data.data.addAll(mid.data);
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
    getDoctorData(page: page.toString(), clinic_id: widget.clinic_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    if (searchdata != userProperties.searchtext) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getDoctorData(page: page.toString(), q: userProperties.searchtext, clinic_id: diaryProperties.getClinicID);
      });
    }
    
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
                    ),
                    splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
                  ),
                Text(
                  "担当ドクターを選択",
                  style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                      size: 18),
                ),
                SizedBox(width: 20,)
                // Icon(
                //   Icons.arrow_back_ios,
                //   size: 20,
                //   color: Helper.whiteColor,
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: SearchbarWidget(
              onchange: () {
                userProperties.setSearchtext(filter.text.toString());
              },
              state: false,
              filter: filter,
              hinttext: "ドクターを検索",
            ),
          ),
          SizedBox(
            height: 12,
            child: Container(color: Helper.homeBgColor,),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  if (isexpanding && !isend) {
                    getDoctorData(page: (page + 1).toString(), q: searchdata);
                    setState(() {
                      page += 1;
                    });
                  }
                } else if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.minScrollExtent) {
                  //widget.scrollTop!();
                }
                return true;
              },
              child: LayoutBuilder(
                  builder: (context, BoxConstraints viewportConstraints) {
                return Column(children: [
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
                            itemCount: doctor_data.data.length,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  userProperties.setSelectedDoctor(
                                      doctor_data.data[index].hira_name);
                                  userProperties.setSearchtext("");
                                  diaryProperties.setDoctorID(doctor_data.data[index].id);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Helper.homeBgColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 4),
                                    child: Container(
                                      width: double.infinity,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          color: Helper.whiteColor),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 15, bottom: 15),
                                              child: SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          17.5),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: doctor_data
                                                        .data[index].photo,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/loading.gif',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/images/profile.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: SizedBox(
                                              width: 6,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              color: Helper.whiteColor,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        doctor_data.data[index]
                                                            .hira_name,
                                                        style: defaultTextStyle(
                                                            Helper.titleColor,
                                                            FontWeight.w700,
                                                            size: 12),
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        doctor_data.data[index]
                                                            .job_name!,
                                                        style: defaultTextStyle(
                                                            Helper.maintxtColor,
                                                            FontWeight.w400,
                                                            size: 10.0),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    doctor_data
                                                        .data[index].clinic_id
                                                        .toString(),
                                                    style: defaultTextStyle(
                                                        Helper.maintxtColor,
                                                        FontWeight.w400,
                                                        size: 10.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
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
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

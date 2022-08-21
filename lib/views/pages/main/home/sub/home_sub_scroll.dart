import 'package:flutter/material.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/home/home_model.dart';
import 'package:laxia/views/widgets/home_card.dart';

class Home_Sub_Scroll extends StatefulWidget {
  final String index;
  const Home_Sub_Scroll(
      {Key? key,
      required this.index })
      : super(key: key);

  @override
  State<Home_Sub_Scroll> createState() => _Home_Sub_ScrollState();
}

class _Home_Sub_ScrollState extends State<Home_Sub_Scroll> {
  bool flag = true, isLoading = true;
  late Home home_data;
  final _con = HomeController();
  Future<void> getData() async {
    try {
      setState(() {
        flag = true;
      });
      Home mid = await _con.getHomeDate(widget.index);
      setState(() {
          home_data = mid;
          flag = false;
      });
    } catch (e) {
      setState(() {
        print("error occured");
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
    
    return flag
        ? Container(
            child: Container(
            height: isLoading ? MediaQuery.of(context).size.width * 0.5 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Container(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  // getData(page: (page+1).toString());
                  // setState(() {
                  //   page+=1;
                  // });
                }
                return true;
              },
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 175 / 291,
                      crossAxisCount: 2,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 9),
                  itemCount: home_data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Home_Card(
                      onpress: () {},
                      title: home_data.data[index].first_content == null
                          ? ""
                          : home_data.data[index].first_content!,
                      type: home_data.data[index].type == null
                          ? ""
                          : home_data.data[index].type!,
                      clinic: home_data.data[index].clinic == null
                          ? ""
                          : home_data.data[index].clinic!,
                      recommend: home_data.data[index].comments_count == null
                          ? " "
                          : home_data.data[index].comments_count.toString(),
                      source: home_data.data[index].photo!,
                      name: home_data.data[index].nickname == null
                          ? ""
                          : home_data.data[index].nickname!,
                      doctorimage: home_data.data[index].photo!,
                      chat: home_data.data[index].views_count == null
                          ? " "
                          : home_data.data[index].views_count.toString(),
                    );
                  }),
            ),
          );
  }
}

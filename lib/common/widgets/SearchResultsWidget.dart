import 'package:flutter/material.dart';
import 'package:laxia/controllers/search_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class SearchResultWidget extends StatefulWidget {
  final String? heroTag;

  SearchResultWidget({Key? key, this.heroTag}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
  // ignore: unused_field
  SearchController? _con;

  _SearchResultWidgetState() : super(SearchController()) {
    _con = controller as SearchController?;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              trailing: IconButton(
                icon: Icon(Icons.close),
                color: Theme.of(context).hintColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                // Trans.of(context).search,
                "asdfasdf",
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                "Subtitle",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onSubmitted: (text) async {
                // await _con.refreshSearch(text);
                // _con.saveSearch(text);
              },
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                // hintText: Trans.of(context).search,
                hintText: "asdfasdfasdfasdf",
                hintStyle: Theme.of(context).textTheme.caption!.merge(TextStyle(fontSize: 14)),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                border:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

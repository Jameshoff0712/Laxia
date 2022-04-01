import 'package:mvc_pattern/mvc_pattern.dart';

class SearchController extends ControllerMVC {
  SearchController() {
    listenForDoctors();
  }

  void listenForDoctors({String? search}) async {
    if (search == null) {
      // search = await getRecentSearch();
    }
  }
}

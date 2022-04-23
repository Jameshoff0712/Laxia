import 'package:equatable/equatable.dart';

class Home extends Equatable {
  final int current_page;
  final List data;
  final String first_page_url;
  final int from;
  final int last_page;
  final String last_page_url;
  final String? next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  const Home({
      required this.current_page,
      required this.data,
      required this.first_page_url,
      required this.from,
      required this.last_page,
      required this.last_page_url,
      required this.next_page_url,
      required this.path,
      required this.per_page,
      required this.prev_page_url,
      required this.to,
      required this.total});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
        current_page: json["current_page"],
        data: json["data"],
        first_page_url: json["first_page_url"],
        from: json["from"],
        last_page: json["last_page"],
        last_page_url: json["last_page_url"],
        next_page_url: json["next_page_url"],
        path: json["path"],
        per_page: int.parse(json["per_page"].toString()) ,
        prev_page_url: json["prev_page_url"],
        to: json["to"],
        total: json["total"]);
  }
  @override
  List<Object?> get props => [
        current_page,
        data,
        first_page_url,
        from,
        last_page,
        last_page_url,
        next_page_url,
        path,
        per_page,
        prev_page_url,
        to,
        total
      ];
}

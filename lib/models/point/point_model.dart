import 'package:equatable/equatable.dart';
import 'package:laxia/models/point/point_sub_model.dart';

class Point extends Equatable {
  final List<Point_Sub_Model>? data;
  final Link? links;
  final Meta? meta;
  const Point({this.data, this.links, this.meta});
  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      data: List<Point_Sub_Model>.from(json["data"]
              .map((x) => Point_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      links: Link.fromJson(json["links"]),
      meta: Meta.fromJson(json["meta"]),
    );
  }
  @override
  List<Object?> get props => [data, links, meta];
}

class Link extends Equatable {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;
  const Link({this.first, this.last, this.prev, this.next});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"]);
  }
  @override
  List<Object?> get props => [first, last, prev, next];
}

class Meta extends Equatable {
  final int? current_page;
  final int? from;
  final int? last_page;
  final String? path;
  final int? per_page;
  final int? to;
  final int? total;
  const Meta(
      {this.current_page,
      this.from,
      this.last_page,
      this.path,
      this.per_page,
      this.to,
      this.total});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      current_page: json["current_page"],
      from: json["from"],
      last_page: json["last_page"],
      path: json["path"],
      per_page: json["per_page"],
      to: json["to"],
      total: json["total"],
    );
  }
  @override
  List<Object?> get props => [
        current_page,
        from,
        last_page,
        path,
        per_page,
        to,
        total,
      ];
}

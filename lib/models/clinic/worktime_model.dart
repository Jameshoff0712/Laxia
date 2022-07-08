import 'package:equatable/equatable.dart';

class Work_Time extends Equatable {
  final String weekday;
  final String? type;
  final String? start_time;
  final String? end_time;

  const Work_Time({required this.weekday,  this.type,  this.start_time,  this.end_time});

  factory Work_Time.fromJson(Map<String, dynamic> json) {
    return Work_Time(
        weekday: json["weekday"],
        type: json["type"].toString(),
        start_time: json["start_time"],
        end_time:json["end_time"]
        );
  }
  @override
  List<Object?> get props => [
        weekday,
        type,
        start_time,
        end_time
      ];
}

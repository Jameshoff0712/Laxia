
import 'package:equatable/equatable.dart';

class StatusInfo extends Equatable {
  final int status;
  final List data;
  const StatusInfo({
    required this.status,
    required this.data,
  });

  factory StatusInfo.fromJson(Map<String, dynamic> json) {
    return StatusInfo(
        status: json['status'],
        data: json['data'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

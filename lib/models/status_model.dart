import 'package:equatable/equatable.dart';

class StatusInfo extends Equatable {
  final String clinic_name;
  final String created_at;
  final int mailbox;
  final int status;
  final String updated_at;
  final String visit_date;
  final String visit_time;
  final bool is_now;
  const StatusInfo({
    required this.is_now,
    required this.clinic_name,
    required this.created_at,
    required this.mailbox,
    required this.updated_at,
    required this.visit_date,
    required this.visit_time,
    required this.status,
  });

  factory StatusInfo.fromJson(Map<String, dynamic> json) {
    print(json);
    return StatusInfo(
      clinic_name:json['clinic_name'],
      created_at:json['created_at'],
      mailbox:json['mailbox'],
      is_now:json['is_now'],
      updated_at:json['updated_at'],
      visit_date:json['visit_date']==null?"":json['visit_date'],
      visit_time:json['visit_time']==null?"":json['visit_time'],
      status:json['status'],
    );
  }

  @override
  List<Object?> get props => [
          clinic_name,
          created_at,
          mailbox,
          updated_at,
          visit_date,
          visit_time,
          status,        
      ];
}

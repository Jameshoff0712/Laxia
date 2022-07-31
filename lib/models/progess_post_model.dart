
import 'package:equatable/equatable.dart';
import 'package:laxia/models/counsel_question_model.dart';

class ProgressPostModel extends Equatable {
  final String from_treat_day;
  final String content;
  final int status1;
  final int status2;
  final int status3;
  final List<int> imageIds;


  ProgressPostModel(
      {required this.from_treat_day,
      required this.content,
      required this.status1,
      required this.status2,
      required this.status3,
      required this.imageIds,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        from_treat_day,
        content,
        status1,
        status2,
        status3,
        imageIds,
      ];
}

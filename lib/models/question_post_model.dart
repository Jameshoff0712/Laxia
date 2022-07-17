// import 'dart:html';

import 'package:equatable/equatable.dart';

class QuestionPostModel extends Equatable {
  final List<int> categories;
  final String title;
  final String content;
  List<int>? imageID_list;

  QuestionPostModel(
      {required this.categories,
      required this.title,
      required this.content,
      this.imageID_list,
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        categories,
        title,
        content,
        imageID_list,
      ];
}

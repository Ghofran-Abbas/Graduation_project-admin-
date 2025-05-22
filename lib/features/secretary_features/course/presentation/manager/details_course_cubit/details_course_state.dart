import 'package:equatable/equatable.dart';

import '../../../data/models/details_course_model.dart';

abstract class DetailsCourseState extends Equatable{
  const DetailsCourseState();

  @override
  List<Object?> get props => [];
}

class DetailsCourseInitial extends DetailsCourseState{}
class DetailsCourseLoading extends DetailsCourseState{}
class DetailsCourseFailure extends DetailsCourseState{
  final String errorMessage;

  const DetailsCourseFailure(this.errorMessage);
}
class DetailsCourseSuccess extends DetailsCourseState{
  final DetailsCourseModel course;

  const DetailsCourseSuccess(this.course);
}
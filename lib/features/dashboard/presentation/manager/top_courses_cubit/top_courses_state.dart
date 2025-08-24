import 'package:equatable/equatable.dart';
import '../../../data/models/top_courses_model.dart';

abstract class TopCoursesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopCoursesInitial extends TopCoursesState {}
class TopCoursesLoading extends TopCoursesState {}

class TopCoursesSuccess extends TopCoursesState {
  final List<TopCourseStat> items;
  final String message;
  TopCoursesSuccess({required this.items, required this.message});

  @override
  List<Object?> get props => [items, message];
}

class TopCoursesFailure extends TopCoursesState {
  final String error;
  TopCoursesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

import 'package:equatable/equatable.dart';
import '../../../data/models/students_stats_model.dart';

abstract class YearlyStudentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class YearlyStudentsInitial extends YearlyStudentsState {}
class YearlyStudentsLoading extends YearlyStudentsState {}
class YearlyStudentsFailure extends YearlyStudentsState {
  final String error;
  YearlyStudentsFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class YearlyStudentsSuccess extends YearlyStudentsState {
  final List<YearlyStudentStat> items; // already from API
  YearlyStudentsSuccess(this.items);
  @override
  List<Object?> get props => [items];
}

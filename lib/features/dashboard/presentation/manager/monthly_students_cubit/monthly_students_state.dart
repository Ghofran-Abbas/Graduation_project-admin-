import 'package:equatable/equatable.dart';
import '../../../data/models/students_stats_model.dart';

abstract class MonthlyStudentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MonthlyStudentsInitial extends MonthlyStudentsState {}
class MonthlyStudentsLoading extends MonthlyStudentsState {}
class MonthlyStudentsFailure extends MonthlyStudentsState {
  final String error;
  MonthlyStudentsFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class MonthlyStudentsSuccess extends MonthlyStudentsState {
  final int year;
  final List<MonthlyStudentStat> items; // 1..12, zero-filled
  final int total; // total for the year
  MonthlyStudentsSuccess({required this.year, required this.items, required this.total});

  @override
  List<Object?> get props => [year, items, total];
}

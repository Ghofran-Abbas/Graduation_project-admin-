// lib/features/points/presentation/manager/top_students_cubit/top_students_state.dart

import '../../../data/models/student_point_model.dart';

abstract class TopStudentsState {}

class TopStudentsInitial extends TopStudentsState {}
class TopStudentsLoading extends TopStudentsState {}
class TopStudentsSuccess extends TopStudentsState {
  final List<StudentPoint> students;
  TopStudentsSuccess(this.students);
}
class TopStudentsFailure extends TopStudentsState {
  final String error;
  TopStudentsFailure(this.error);
}

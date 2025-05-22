import 'package:equatable/equatable.dart';

import '../../../data/models/update_student_model.dart';

abstract class UpdateStudentState extends Equatable{
  const UpdateStudentState();

  @override
  List<Object> get props => [];
}

class UpdateStudentInitial extends UpdateStudentState{}
class UpdateStudentLoading extends UpdateStudentState{}
class UpdateStudentFailure extends UpdateStudentState{
  final String errorMessage;

  const UpdateStudentFailure(this.errorMessage);
}
class UpdateStudentSuccess extends UpdateStudentState{
  final UpdateStudentModel updateResult;

  const UpdateStudentSuccess(this.updateResult);
}
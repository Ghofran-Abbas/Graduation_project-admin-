import 'package:equatable/equatable.dart';

import '../../../data/models/delete_department_model.dart';

abstract class DeleteDepartmentState extends Equatable{
  const DeleteDepartmentState();

  @override
  List<Object?> get props => [];
}

class DeleteDepartmentInitial extends DeleteDepartmentState{}
class DeleteDepartmentLoading extends DeleteDepartmentState{}
class DeleteDepartmentFailure extends DeleteDepartmentState{
  final String errorMessage;

  const DeleteDepartmentFailure(this.errorMessage);
}
class DeleteDepartmentSuccess extends DeleteDepartmentState{
  final DeleteDepartmentModel deleteResult;

  const DeleteDepartmentSuccess(this.deleteResult);
}
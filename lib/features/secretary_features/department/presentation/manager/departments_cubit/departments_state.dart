import 'package:equatable/equatable.dart';

import '../../../data/models/departments_model.dart';

abstract class DepartmentsState extends Equatable{
  const DepartmentsState();

  @override
  List<Object?> get props => [];
}

class DepartmentsInitial extends DepartmentsState{}
class DepartmentsLoading extends DepartmentsState{}
class DepartmentsFailure extends DepartmentsState{
  final String errorMessage;

  const DepartmentsFailure(this.errorMessage);
}
class DepartmentsSuccess extends DepartmentsState{
  final DepartmentsModel showResult;

  const DepartmentsSuccess(this.showResult);
}
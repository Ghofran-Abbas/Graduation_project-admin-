import 'package:equatable/equatable.dart';

import '../../../data/models/update_employee_model.dart';

abstract class UpdateEmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateEmployeeInitial extends UpdateEmployeeState {}
class UpdateEmployeeLoading extends UpdateEmployeeState {}

class UpdateEmployeeSuccess extends UpdateEmployeeState {
  final UpdateEmployeeModel result;
  UpdateEmployeeSuccess(this.result);
  @override
  List<Object?> get props => [result];
}

class UpdateEmployeeFailure extends UpdateEmployeeState {
  final String error;
  UpdateEmployeeFailure(this.error);
  @override
  List<Object?> get props => [error];
}

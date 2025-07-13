// lib/features/employee/presentation/manager/create_employee_cubit/create_employee_state.dart

import 'package:equatable/equatable.dart';
import '../../../data/models/create_employee_model.dart';

abstract class CreateEmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateEmployeeInitial extends CreateEmployeeState {}
class CreateEmployeeLoading extends CreateEmployeeState {}

// Now carries the full CreateEmployeeModel result
class CreateEmployeeSuccess extends CreateEmployeeState {
  final CreateEmployeeModel result;
  CreateEmployeeSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class CreateEmployeeFailure extends CreateEmployeeState {
  final String error;
  CreateEmployeeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

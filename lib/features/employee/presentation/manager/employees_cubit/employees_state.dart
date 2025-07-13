// lib/features/employee/manager/employees_state.dart

import 'package:equatable/equatable.dart';

import '../../../data/models/employees_model.dart';

abstract class EmployeesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeesInitial extends EmployeesState {}

class EmployeesLoading extends EmployeesState {}

class EmployeesSuccess extends EmployeesState {
  /// All employees accumulated so far
  final List<Employee> employees;

  /// Whether there are more pages to load
  final bool hasMore;

  EmployeesSuccess(this.employees, {required this.hasMore});

  @override
  List<Object?> get props => [employees, hasMore];
}

class EmployeesFailure extends EmployeesState {
  final String error;

  EmployeesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

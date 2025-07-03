// lib/features/employee/presentation/manager/search_employee_cubit/search_employee_state.dart

import 'package:equatable/equatable.dart';

import '../../../data/models/search_employee_model.dart';

abstract class SearchEmployeeState extends Equatable {
  const SearchEmployeeState();
  @override
  List<Object?> get props => [];
}

class SearchEmployeeInitial extends SearchEmployeeState {}
class SearchEmployeeLoading extends SearchEmployeeState {}
class SearchEmployeeFailure extends SearchEmployeeState {
  final String errorMessage;
  const SearchEmployeeFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
class SearchEmployeeSuccess extends SearchEmployeeState {
  final SearchEmployeeModel employee;
  const SearchEmployeeSuccess(this.employee);
  @override
  List<Object?> get props => [employee];
}

// cubits/details_employee_state.dart
import 'package:equatable/equatable.dart';
import '../../../data/models/details_employee_model.dart';
import '../../../data/models/employees_model.dart';


abstract class DetailsEmployeeState extends Equatable {
  @override List<Object?> get props => [];
}
class DetailsEmployeeInitial extends DetailsEmployeeState {}
class DetailsEmployeeLoading extends DetailsEmployeeState {}
class DetailsEmployeeSuccess extends DetailsEmployeeState {
  final EmployeeDetail employee;
  DetailsEmployeeSuccess(this.employee);
  @override List<Object?> get props => [employee];
}
class DetailsEmployeeFailure extends DetailsEmployeeState {
  final String error;
  DetailsEmployeeFailure(this.error);
  @override List<Object?> get props => [error];
}
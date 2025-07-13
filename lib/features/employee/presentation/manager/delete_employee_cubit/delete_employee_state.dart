// cubits/delete_employee_state.dart
import 'package:equatable/equatable.dart';

abstract class DeleteEmployeeState extends Equatable {
  @override List<Object?> get props => [];
}
class DeleteEmployeeInitial extends DeleteEmployeeState {}
class DeleteEmployeeLoading extends DeleteEmployeeState {}
class DeleteEmployeeSuccess extends DeleteEmployeeState {}
class DeleteEmployeeFailure extends DeleteEmployeeState {
  final String error;
  DeleteEmployeeFailure(this.error);
  @override List<Object?> get props => [error];
}

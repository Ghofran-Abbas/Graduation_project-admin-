import 'package:equatable/equatable.dart';
import '../../../data/models/task_model.dart';

abstract class UpdateTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}
class UpdateTaskInitial extends UpdateTaskState {}
class UpdateTaskLoading extends UpdateTaskState {}
class UpdateTaskFailure extends UpdateTaskState {
  final String error;
  UpdateTaskFailure(this.error);
  @override
  List<Object?> get props => [error];
}
class UpdateTaskSuccess extends UpdateTaskState {
  final Task task;
  UpdateTaskSuccess(this.task);
  @override
  List<Object?> get props => [task];
}

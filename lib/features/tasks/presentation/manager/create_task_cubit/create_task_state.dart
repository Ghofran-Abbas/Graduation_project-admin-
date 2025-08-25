import 'package:equatable/equatable.dart';
import '../../../data/models/task_model.dart';

abstract class CreateTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}
class CreateTaskInitial extends CreateTaskState {}
class CreateTaskLoading extends CreateTaskState {}
class CreateTaskFailure extends CreateTaskState {
  final String error;
  CreateTaskFailure(this.error);
  @override
  List<Object?> get props => [error];
}
class CreateTaskSuccess extends CreateTaskState {
  final Task task;
  CreateTaskSuccess(this.task);
  @override
  List<Object?> get props => [task];
}

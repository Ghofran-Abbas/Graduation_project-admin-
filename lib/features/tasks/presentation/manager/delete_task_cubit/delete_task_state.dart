import 'package:equatable/equatable.dart';

abstract class DeleteTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}
class DeleteTaskInitial extends DeleteTaskState {}
class DeleteTaskLoading extends DeleteTaskState {}
class DeleteTaskFailure extends DeleteTaskState {
  final String error;
  DeleteTaskFailure(this.error);
  @override
  List<Object?> get props => [error];
}
class DeleteTaskSuccess extends DeleteTaskState {
  final int taskId;
  DeleteTaskSuccess(this.taskId);
  @override
  List<Object?> get props => [taskId];
}

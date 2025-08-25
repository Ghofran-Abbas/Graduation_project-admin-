import 'package:equatable/equatable.dart';
import '../../../data/models/task_model.dart';

abstract class TasksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {}
class TasksLoading extends TasksState {}
class TasksFailure extends TasksState {
  final String error;
  TasksFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class TasksSuccess extends TasksState {
  final List<Task> tasks;
  final bool hasMore;
  TasksSuccess(this.tasks, {required this.hasMore});
  @override
  List<Object?> get props => [tasks, hasMore];
}

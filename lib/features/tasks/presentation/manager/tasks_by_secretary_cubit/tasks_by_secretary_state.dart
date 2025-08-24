import 'package:equatable/equatable.dart';
import '../../../data/models/task_model.dart';

abstract class TasksBySecretaryState extends Equatable {
  @override
  List<Object?> get props => [];
}
class TasksBySecretaryInitial extends TasksBySecretaryState {}
class TasksBySecretaryLoading extends TasksBySecretaryState {}
class TasksBySecretaryFailure extends TasksBySecretaryState {
  final String error;
  TasksBySecretaryFailure(this.error);
  @override
  List<Object?> get props => [error];
}
class TasksBySecretarySuccess extends TasksBySecretaryState {
  final int secretaryId;
  final List<Task> tasks;
  final bool hasMore;
  TasksBySecretarySuccess(this.secretaryId, this.tasks, {required this.hasMore});
  @override
  List<Object?> get props => [secretaryId, tasks, hasMore];
}

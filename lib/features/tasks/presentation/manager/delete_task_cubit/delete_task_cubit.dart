import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/task_repo.dart';
import 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  final TaskRepo _repo;
  DeleteTaskCubit(this._repo) : super(DeleteTaskInitial());

  Future<void> delete(int taskId) async {
    emit(DeleteTaskLoading());
    try {
      await _repo.deleteTask(taskId);
      emit(DeleteTaskSuccess(taskId));
    } catch (e) {
      emit(DeleteTaskFailure(e.toString()));
    }
  }
}

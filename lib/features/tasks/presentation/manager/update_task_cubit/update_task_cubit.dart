import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repos/task_repo.dart';
import 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  final TaskRepo _repo;
  UpdateTaskCubit(this._repo) : super(UpdateTaskInitial());

  Future<void> update({
    required int taskId,
    String? title,
    String? description,
    String? status,
  }) async {
    emit(UpdateTaskLoading());
    try {
      final task = await _repo.updateTask(
        taskId: taskId,
        title: title,
        description: description,
        status: status,
      );
      emit(UpdateTaskSuccess(task));
    } catch (e) {
      emit(UpdateTaskFailure(e.toString()));
    }
  }
}

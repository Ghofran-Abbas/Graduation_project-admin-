import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repos/task_repo.dart';
import 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final TaskRepo _repo;
  CreateTaskCubit(this._repo) : super(CreateTaskInitial());

  Future<void> create({
    required String title,
    required String description,
    required int secretaryId,
  }) async {
    emit(CreateTaskLoading());
    try {
      final task = await _repo.createTask(
        title: title,
        description: description,
        secretaryId: secretaryId,
      );
      emit(CreateTaskSuccess(task));
    } catch (e) {
      emit(CreateTaskFailure(e.toString()));
    }
  }
}

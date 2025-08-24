import '../models/task_model.dart';

abstract class TaskRepo {
  Future<TasksPage> fetchAllForAdmin({int page = 1});
  Future<TasksPage> fetchBySecretary({required int secretaryId, int page = 1});

  Future<Task> createTask({
    required String title,
    required String description,
    required int secretaryId,
  });

  Future<Task> updateTask({
    required int taskId,
    String? title,
    String? description,
    String? status,
  });

  Future<void> deleteTask(int taskId);
}

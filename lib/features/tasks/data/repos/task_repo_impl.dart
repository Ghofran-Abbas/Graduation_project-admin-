import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/task_model.dart';
import 'task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final DioApiService _api;
  TaskRepoImpl(this._api);

  @override
  Future<TasksPage> fetchAllForAdmin({int page = 1}) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final resp = await _api.get(
      endPoint: '/secretary/task/showTasksForAdmin?page=$page',
      token: token,
    );
    return TasksPage.fromAdminJson(resp as Map<String, dynamic>);
  }

  @override
  Future<TasksPage> fetchBySecretary({required int secretaryId, int page = 1}) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final resp = await _api.get(
      endPoint: '/secretary/task/showTasksByIdSecretary/$secretaryId?page=$page',
      token: token,
    );
    return TasksPage.fromSecretaryJson(resp as Map<String, dynamic>);
  }

  @override
  Future<Task> createTask({
    required String title,
    required String description,
    required int secretaryId,
  }) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final data = {
      'title': title,
      'description': description,
      'secretary_id': secretaryId,
    };
    final resp = await _api.post(
      endPoint: '/secretary/task/createTask',
      data: data,
      token: token,
    );
    final taskJson = (resp['Task'] ?? resp['task']) as Map<String, dynamic>;
    return Task.fromJson(taskJson);
  }

  @override
  Future<Task> updateTask({
    required int taskId,
    String? title,
    String? description,
    String? status,
  }) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final body = <String, dynamic>{};
    if (title != null && title.trim().isNotEmpty) body['title'] = title;
    if (description != null && description.trim().isNotEmpty) body['description'] = description;
    if (status != null && status.trim().isNotEmpty) body['status'] = status;

    final resp = await _api.post(
      endPoint: '/secretary/task/updateTask/$taskId',
      data: body.isEmpty ? null : body,
      token: token,
    );
    final taskJson = (resp['task'] ?? resp['Task']) as Map<String, dynamic>;
    return Task.fromJson(taskJson);
  }

  @override
  Future<void> deleteTask(int taskId) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    await _api.post(
      endPoint: '/secretary/task/deleteTask/$taskId',
      data: null,
      token: token,
    );
  }
}

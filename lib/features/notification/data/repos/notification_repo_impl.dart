// lib/features/notifications/data/repos/notifications_repository_impl.dart

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/notification_model.dart';
import 'notification_repo.dart';


class NotificationsRepositoryImpl implements NotificationsRepository {
  final DioApiService _api;

  NotificationsRepositoryImpl(this._api);

  @override
  Future<List<NotificationModel>> fetchNotifications() async {
    // Read token from shared prefs helper (adapt to your helper)
    final token = await SharedPreferencesHelper.getJwtToken();

    // If token is required and missing, throw
    if (token == null) {
      throw Exception('No JWT token found');
    }

    // Call GET endpoint (adjust endpoint path to your backend)
    final response = await _api.get(endPoint: '/notifications/indexNotificationsAdmin', token: token);

    // response expected as Map<String, dynamic>
    final Map<String, dynamic> root = response as Map<String, dynamic>;

    // backend returns array under "notifications"
    final List<dynamic> arr = root['notifications'] as List<dynamic>? ?? [];

    return arr.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}

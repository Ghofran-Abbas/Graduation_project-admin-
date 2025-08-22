// lib/features/notifications/data/repos/notifications_repository.dart

import '../models/notification_model.dart';

abstract class NotificationsRepository {
  /// Fetches notifications for current admin/user
  Future<List<NotificationModel>> fetchNotifications();
}

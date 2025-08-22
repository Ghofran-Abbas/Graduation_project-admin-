// lib/features/notifications/data/models/notification_model.dart

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      isRead: (json['is_read'] is int) ? (json['is_read'] == 1) : (json['is_read'] == true),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

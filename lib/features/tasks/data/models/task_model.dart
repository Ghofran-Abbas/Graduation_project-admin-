import 'package:equatable/equatable.dart';

class SecretarySummary extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final String birthday;
  final String gender;
  final int points;

  const SecretarySummary({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    required this.birthday,
    required this.gender,
    required this.points,
  });

  factory SecretarySummary.fromJson(Map<String, dynamic> json) {
    return SecretarySummary(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photo: json['photo'] as String?,
      birthday: json['birthday'] as String,
      gender: json['gender'] as String,
      points: (json['points'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, photo, birthday, gender, points];
}

class Task extends Equatable {
  final int id;
  final String title;
  final String description;
  final String status; // e.g. "pending"
  final int secretaryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SecretarySummary? secretary; // present in admin list & create response

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.secretaryId,
    required this.createdAt,
    required this.updatedAt,
    this.secretary,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      secretaryId: (json['secretary_id'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      secretary: json['secretaries'] != null
          ? SecretarySummary.fromJson(json['secretaries'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, status, secretaryId, createdAt, updatedAt, secretary];
}

class TasksPage {
  final List<Task> data;
  final int currentPage;
  final int lastPage;

  TasksPage({required this.data, required this.currentPage, required this.lastPage});

  factory TasksPage.fromAdminJson(Map<String, dynamic> json) {
    final meta = json['Tasks'] as Map<String, dynamic>;
    final items = (meta['data'] as List).map((e) => Task.fromJson(e)).toList();
    return TasksPage(
      data: items,
      currentPage: (meta['current_page'] as num).toInt(),
      lastPage: (meta['last_page'] as num).toInt(),
    );
  }

  factory TasksPage.fromSecretaryJson(Map<String, dynamic> json) {
    final meta = json['Tasks'] as Map<String, dynamic>;
    final items = (meta['data'] as List).map((e) => Task.fromJson(e)).toList();
    return TasksPage(
      data: items,
      currentPage: (meta['current_page'] as num).toInt(),
      lastPage: (meta['last_page'] as num).toInt(),
    );
  }
}

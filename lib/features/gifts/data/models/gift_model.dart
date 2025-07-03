import 'package:intl/intl.dart';
import '../../../secretary_features/student/data/models/details_student_model.dart';

/// Represents a paginated response of gifts.
// lib/features/gifts/data/models/gift_model.dart

import 'package:intl/intl.dart';
import '../../../secretary_features/student/data/models/details_student_model.dart';

// lib/features/gifts/data/models/gift_model.dart

class Gift {
  final int id;
  final String description;
  final DateTime date;
  final String? photo;
  final int? studentId;
  final int? secretaryId;
  final Student? student;
  final Secretary? secretary;

  Gift({
    required this.id,
    required this.description,
    required this.date,
    this.photo,
    this.studentId,
    this.secretaryId,
    this.student,
    this.secretary,
  });

  /// Helper to parse either an int or a numeric string
  static int _parseInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: _parseInt(json['id']),
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      photo: json['photo'] as String?,
      studentId: json['student_id'] == null
          ? null
          : _parseInt(json['student_id']),
      secretaryId: json['secretary_id'] == null
          ? null
          : _parseInt(json['secretary_id']),
      student: json['student'] != null
          ? Student.fromJson(json['student'] as Map<String, dynamic>)
          : null,
      secretary: json['secretary'] != null
          ? Secretary.fromJson(json['secretary'] as Map<String, dynamic>)
          : null,
    );
  }
}

class GiftsPage {
  final String message;
  final List<Gift> gifts;
  final int currentPage;
  final int lastPage;

  GiftsPage({
    required this.message,
    required this.gifts,
    required this.currentPage,
    required this.lastPage,
  });

  factory GiftsPage.fromJson(Map<String, dynamic> json) {
    final pager = json['pagination'] as Map<String, dynamic>;
    return GiftsPage(
      message: json['message'] as String,
      gifts: (json['gifts'] as List)
          .map((e) => Gift.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: Gift._parseInt(pager['current_page']),
      lastPage:    Gift._parseInt(pager['last_page']),
    );
  }
}

/// Secretary details for gifts created or managed by a secretary.
class Secretary {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final String birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;

  Secretary({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    required this.birthday,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Secretary.fromJson(Map<String, dynamic> json) => Secretary(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    photo: json['photo'] as String?,
    birthday: json['birthday'] as String,
    gender: json['gender'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
    if (photo != null) m['photo'] = photo;
    return m;
  }
}

// lib/features/employee/data/models/details_employee_model.dart

import 'package:intl/intl.dart';

class DetailsEmployeeModel {
  final String message;
  final EmployeeDetail employee;

  DetailsEmployeeModel({
    required this.message,
    required this.employee,
  });

  factory DetailsEmployeeModel.fromJson(Map<String, dynamic> json) {
    return DetailsEmployeeModel(
      message: json['message'] as String,
      employee: EmployeeDetail.fromJson(
        json['Employee'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'Employee': employee.toJson(),
  };
}

class EmployeeDetail {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final DateTime birthday;
  final String gender;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeDetail({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photo,
    required this.birthday,
    required this.gender,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) {
    final rawBirthday = json['birthday'] as String;
    // support both "dd-MM-yyyy" and "yyyy/M/d"
    final birthday = rawBirthday.contains('-')
        ? DateFormat('dd-MM-yyyy').parse(rawBirthday)
        : DateFormat('yyyy/M/d').parse(rawBirthday);

    return EmployeeDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photo: json['photo'] as String?,
      birthday: birthday,
      gender: json['gender'] as String,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'photo': photo,
    // serialize using the same delimiter you received
    'birthday': DateFormat('dd-MM-yyyy').format(birthday),
    'gender': gender,
    'role': role,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

// lib/features/employee/data/models/employee_model.dart

import 'package:equatable/equatable.dart';

/// Represents a single employee record.
class Employee extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthday;
  final String gender;
  final String role;
  final String? photo;
  final int points;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.role,
    this.photo,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
      gender: json['gender'] as String,
      role: json['role'] as String,
      photo: json['photo'] as String?,
      points: (json['points'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    birthday,
    gender,
    role,
    photo,
    points,
    createdAt,
    updatedAt,
  ];
}

/// Wrapper for paginated employee data returned by the API.
class EmployeesPage {
  /// The list of employees on the current page.
  final List<Employee> data;

  /// The current page number (1-based).
  final int currentPage;

  /// The total number of pages available.
  final int lastPage;

  EmployeesPage({
    required this.data,
    required this.currentPage,
    required this.lastPage,
  });

  factory EmployeesPage.fromJson(Map<String, dynamic> json) {
    final meta = json['Employees'] as Map<String, dynamic>;
    return EmployeesPage(
      data: (meta['data'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: meta['current_page'] as int,
      lastPage: meta['last_page'] as int,
    );
  }
}

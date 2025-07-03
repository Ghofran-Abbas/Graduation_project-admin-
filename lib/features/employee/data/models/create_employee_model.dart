// lib/features/employee/data/models/create_employee_model.dart

class CreateEmployeeModel {
  final String message;
  final CreatedEmployee group;

  CreateEmployeeModel({
    required this.message,
    required this.group,
  });

  factory CreateEmployeeModel.fromJson(Map<String, dynamic> json) {
    return CreateEmployeeModel(
      message: json['message'] as String,
      group: CreatedEmployee.fromJson(json['group'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'group': group.toJson(),
  };
}

class CreatedEmployee {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String birthday;
  final String gender;
  final String role;
  final String? photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  CreatedEmployee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.role,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedEmployee.fromJson(Map<String, dynamic> json) {
    return CreatedEmployee(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthday: json['birthday'] as String,
      gender: json['gender'] as String,
      role: json['role'] as String,
      photo: json['photo'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'birthday': birthday,
    'gender': gender,
    'role': role,
    'photo': photo,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class UpdateEmployeeModel {
  final String message;
  final EmployeeInfo employeeInfo;

  UpdateEmployeeModel({
    required this.message,
    required this.employeeInfo,
  });

  factory UpdateEmployeeModel.fromJson(Map<String, dynamic> json) {
    return UpdateEmployeeModel(
      message: json['message'] as String,
      employeeInfo:
      EmployeeInfo.fromJson(json['employeeInfo'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'employeeInfo': employeeInfo.toJson(),
  };
}

class EmployeeInfo {
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

  EmployeeInfo({
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

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
    return EmployeeInfo(
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'birthday': birthday,
    'gender': gender,
    'role': role,
    'photo': photo,
    'points': points,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

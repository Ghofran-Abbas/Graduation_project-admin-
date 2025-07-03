
class RegisterSecretaryModel {
  final String message;
  final SecretaryInfo secretaryInfo;

  RegisterSecretaryModel({
    required this.message,
    required this.secretaryInfo,
  });

  factory RegisterSecretaryModel.fromJson(Map<String, dynamic> json) {
    return RegisterSecretaryModel(
      message: json['Message'] as String,
      secretaryInfo:
      SecretaryInfo.fromJson(json['secretaryInfo'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'Message': message,
    'secretaryInfo': secretaryInfo.toJson(),
  };
}

class SecretaryInfo {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final String birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;

  SecretaryInfo({
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

  factory SecretaryInfo.fromJson(Map<String, dynamic> json) {
    return SecretaryInfo(
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
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'photo': photo,
    'birthday': birthday,
    'gender': gender,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

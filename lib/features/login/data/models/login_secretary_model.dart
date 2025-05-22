class LoginSecretaryModel {
  final String message;
  final Data data;

  LoginSecretaryModel({
    required this.message,
    required this.data,
  });

  factory LoginSecretaryModel.fromJson(Map<String, dynamic> json) => LoginSecretaryModel(
    message: json["Message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "data": data.toJson(),
  };
}

class Data {
  final String accessToken;
  final Admin admin;

  Data({
    required this.accessToken,
    required this.admin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    admin: Admin.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "admin": admin.toJson(),
  };
}

class Admin {
  final int id;
  final String name;
  final String email;
  final String fcmToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    fcmToken: json["fcm_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "fcm_token": fcmToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
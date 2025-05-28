class CreateDepartmentModel {
  final String message;
  final Department department;

  CreateDepartmentModel({
    required this.message,
    required this.department,
  });

  factory CreateDepartmentModel.fromJson(Map<String, dynamic> json) => CreateDepartmentModel(
    message: json["message"],
    department: Department.fromJson(json["department"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "department": department.toJson(),
  };
}

class Department {
  final String name;
  final String photo;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Department({
    required this.name,
    required this.photo,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    name: json["name"],
    photo: json["photo"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "photo": photo,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
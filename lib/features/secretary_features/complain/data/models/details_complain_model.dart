class DetailsComplainModel {
  final String status;
  final String message;
  final Data data;

  DetailsComplainModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DetailsComplainModel.fromJson(Map<String, dynamic> json) => DetailsComplainModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final int studentId;
  final String description;
  final String? filePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Student student;

  Data({
    required this.id,
    required this.studentId,
    required this.description,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    studentId: json["student_id"],
    description: json["description"],
    filePath: json["file_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    student: Student.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentId,
    "description": description,
    "file_path": filePath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "student": student.toJson(),
  };
}

class Student {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final DateTime birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;
  final dynamic referrerId;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.points,
    required this.referrerId,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    points: json["points"],
    referrerId: json["referrer_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "points": points,
    "referrer_id": referrerId,
  };
}
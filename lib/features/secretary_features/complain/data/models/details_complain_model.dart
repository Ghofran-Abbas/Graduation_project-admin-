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
  final String description;
  final String filePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.description,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    description: json["description"],
    filePath: json["file_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "file_path": filePath,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
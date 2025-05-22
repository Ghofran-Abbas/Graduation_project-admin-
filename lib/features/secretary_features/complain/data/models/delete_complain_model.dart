class DeleteComplainModel {
  final String status;
  final String message;

  DeleteComplainModel({
    required this.status,
    required this.message,
  });

  factory DeleteComplainModel.fromJson(Map<String, dynamic> json) => DeleteComplainModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
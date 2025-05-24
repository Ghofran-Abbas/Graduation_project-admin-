class DeleteDepartmentModel {
  final String message;

  DeleteDepartmentModel({
    required this.message,
  });

  factory DeleteDepartmentModel.fromJson(Map<String, dynamic> json) => DeleteDepartmentModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
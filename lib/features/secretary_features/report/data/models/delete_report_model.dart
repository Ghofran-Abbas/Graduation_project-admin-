class DeleteReportModel {
  final String message;

  DeleteReportModel({
    required this.message,
  });

  factory DeleteReportModel.fromJson(Map<String, dynamic> json) => DeleteReportModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
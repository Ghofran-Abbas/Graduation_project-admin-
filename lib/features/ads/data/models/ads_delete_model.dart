// lib/features/ads/data/models/delete_response_model.dart

class DeleteResponseModel {
  final String status;
  final String message;

  DeleteResponseModel({
    required this.status,
    required this.message,
  });

  factory DeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }
}

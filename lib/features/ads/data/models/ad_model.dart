// lib/features/ads/data/models/ad_model.dart

class AdModel {
  final int id;
  final String title;
  final String description;
  final String photo;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.photo,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id:          json['id']           as int,
      title:       json['title']        as String,
      description: json['description']  as String,
      photo:       json['photo']        as String,
      startDate:   DateTime.parse(json['start_date']  as String),
      endDate:     DateTime.parse(json['end_date']    as String),
      createdAt:   DateTime.parse(json['created_at']  as String),
      updatedAt:   DateTime.parse(json['updated_at']  as String),
    );
  }
}

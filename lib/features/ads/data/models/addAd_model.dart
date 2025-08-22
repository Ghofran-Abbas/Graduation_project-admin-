// lib/features/ads/data/models/ad_detail_model.dart

class AdDetailModel {
  final int      id;
  final String   title;
  final String   description;
  final String   photo;
  final DateTime startDate;
  final DateTime endDate;

  AdDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.photo,
    required this.startDate,
    required this.endDate,
  });

  factory AdDetailModel.fromJson(Map<String, dynamic> json) {
    return AdDetailModel(
      id:          json['id']          as int,
      title:       json['title']       as String,
      description: json['description'] as String,
      photo:       json['photo']       as String,
      startDate:   DateTime.parse(json['start_date'] as String),
      endDate:     DateTime.parse(json['end_date']   as String),
    );
  }
}

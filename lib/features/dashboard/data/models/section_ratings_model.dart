import 'package:equatable/equatable.dart';

class SectionRatingStat extends Equatable {
  final int sectionId;
  final String sectionName;
  final double averageRating;
  final int totalRatings;

  const SectionRatingStat({
    required this.sectionId,
    required this.sectionName,
    required this.averageRating,
    required this.totalRatings,
  });

  factory SectionRatingStat.fromJson(Map<String, dynamic> json) {
    return SectionRatingStat(
      sectionId: json['section_id'] as int,
      sectionName: json['section_name'] as String,
      averageRating: (json['average_rating'] as num).toDouble(),
      totalRatings: (json['total_ratings'] as num).toInt(),
    );
  }

  @override
  List<Object?> get props => [sectionId, sectionName, averageRating, totalRatings];
}

class SectionRatingsPayload {
  final String message;
  final List<SectionRatingStat> data;

  SectionRatingsPayload({required this.message, required this.data});

  factory SectionRatingsPayload.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List<dynamic>)
        .map((e) => SectionRatingStat.fromJson(e as Map<String, dynamic>))
        .toList();
    return SectionRatingsPayload(
      message: json['message'] as String? ?? '',
      data: list,
    );
  }
}

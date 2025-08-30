class SectionRatingsPayload {
  final String message;
  final List<SectionRatingStat> data;

  SectionRatingsPayload({
    required this.message,
    required this.data,
  });

  factory SectionRatingsPayload.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List? ?? [])
        .map((e) => SectionRatingStat.fromJson(e as Map<String, dynamic>))
        .toList();
    return SectionRatingsPayload(
      message: (json['message'] ?? '').toString(),
      data: list,
    );
  }
}

class SectionRatingStat {
  final int sectionId;
  final String sectionName;
  final int courseId;
  final String courseName;
  final double averageRating; // 0..5
  final int totalRatings;

  SectionRatingStat({
    required this.sectionId,
    required this.sectionName,
    required this.courseId,
    required this.courseName,
    required this.averageRating,
    required this.totalRatings,
  });

  factory SectionRatingStat.fromJson(Map<String, dynamic> json) {
    return SectionRatingStat(
      sectionId: (json['section_id'] as num?)?.toInt() ?? 0,
      sectionName: (json['section_name'] ?? '').toString(),
      courseId: (json['course_id'] as num?)?.toInt() ?? 0,
      courseName: (json['course_name'] ?? '').toString(),
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['total_ratings'] as num?)?.toInt() ?? 0,
    );
  }
}

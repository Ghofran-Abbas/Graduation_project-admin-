class TrainerRatingsPayload {
  final String message;
  final List<TrainerRatingStat> data;

  TrainerRatingsPayload({required this.message, required this.data});

  factory TrainerRatingsPayload.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List? ?? [])
        .map((e) => TrainerRatingStat.fromJson(e as Map<String, dynamic>))
        .toList();
    return TrainerRatingsPayload(
      message: (json['message'] ?? '').toString(),
      data: list,
    );
  }
}

class TrainerRatingStat {
  final int trainerId;
  final String trainerName;
  final double averageRating; // 0..5
  final int totalRatings;

  TrainerRatingStat({
    required this.trainerId,
    required this.trainerName,
    required this.averageRating,
    required this.totalRatings,
  });

  factory TrainerRatingStat.fromJson(Map<String, dynamic> json) {
    return TrainerRatingStat(
      trainerId: (json['trainer_id'] as num?)?.toInt() ?? 0,
      trainerName: (json['trainer_name'] ?? '').toString(),
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['total_ratings'] as num?)?.toInt() ?? 0,
    );
  }
}

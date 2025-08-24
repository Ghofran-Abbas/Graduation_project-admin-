import 'package:equatable/equatable.dart';

class TopCourseStat extends Equatable {
  final int courseId;
  final String courseName;
  final int totalStudents;

  const TopCourseStat({
    required this.courseId,
    required this.courseName,
    required this.totalStudents,
  });

  factory TopCourseStat.fromJson(Map<String, dynamic> json) {
    return TopCourseStat(
      courseId: json['course_id'] as int,
      courseName: json['course_name'] as String,
      totalStudents: (json['total_students'] as num).toInt(),
    );
  }

  @override
  List<Object?> get props => [courseId, courseName, totalStudents];
}

class TopCoursesPayload {
  final String message;
  final List<TopCourseStat> data;

  TopCoursesPayload({required this.message, required this.data});

  factory TopCoursesPayload.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List<dynamic>)
        .map((e) => TopCourseStat.fromJson(e as Map<String, dynamic>))
        .toList();
    return TopCoursesPayload(
      message: json['message'] as String? ?? '',
      data: list,
    );
  }
}


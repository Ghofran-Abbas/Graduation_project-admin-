import '../models/section_ratings_model.dart';
import '../models/top_courses_model.dart';
import '../models/students_stats_model.dart';
import '../models/trainer_ratings_model.dart';

abstract class DashboardRepo {
  Future<TopCoursesPayload> fetchTopCourses();

  Future<YearlyStudentsPayload> fetchYearlyStudents();

  Future<MonthlyStudentsPayload> fetchMonthlyStudents({required int year});

  Future<SectionRatingsPayload> fetchSectionRatings({
    String? startDate, // YYYY-MM-DD
    String? endDate,   // YYYY-MM-DD
    int?    limit,
    String? order,     // 'asc' | 'desc'
  });
  Future<TrainerRatingsPayload> fetchTrainerRatings({
    String? startDate,
    String? endDate,
    int?    limit,
    String? order,
  });
}

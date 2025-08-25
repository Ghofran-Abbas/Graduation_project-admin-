import 'dart:convert';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/top_courses_model.dart';
import '../models/students_stats_model.dart';
import '../models/section_ratings_model.dart';
import 'dashboard_repo.dart';

class DashboardRepoImpl implements DashboardRepo {
  final DioApiService _api;
  DashboardRepoImpl(this._api);

  @override
  Future<TopCoursesPayload> fetchTopCourses() async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final resp = await _api.get(endPoint: '/admin/courses/statistics/top-courses', token: token);
    return TopCoursesPayload.fromJson(resp as Map<String, dynamic>);
  }

  @override
  Future<YearlyStudentsPayload> fetchYearlyStudents() async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final resp = await _api.get(endPoint: '/admin/students/statistics/yearly', token: token);
    return YearlyStudentsPayload.fromJson(resp as Map<String, dynamic>);
  }

  @override
  Future<MonthlyStudentsPayload> fetchMonthlyStudents({required int year}) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final resp = await _api.get(endPoint: '/admin/students/statistics/monthly?year=$year', token: token);
    return MonthlyStudentsPayload.fromJson(resp as Map<String, dynamic>);
  }

  @override
  Future<SectionRatingsPayload> fetchSectionRatings({
    String? startDate,
    String? endDate,
    int? limit,
    String? order,
  }) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    final qp = <String, String>{};
    if (startDate != null && startDate.isNotEmpty) qp['start_date'] = startDate;
    if (endDate != null && endDate.isNotEmpty) qp['end_date'] = endDate;
    if (limit != null) qp['limit'] = '$limit';
    if (order != null && order.isNotEmpty) qp['order'] = order;

    final query = qp.isEmpty ? '' : '?${Uri(queryParameters: qp).query}';
    final resp = await _api.get(
      endPoint: '/admin/trainer/section-statistics$query',
      token: token,
    );
    return SectionRatingsPayload.fromJson(resp as Map<String, dynamic>);
  }
}

// lib/features/points/data/repos/points_repo_impl.dart

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/secretary_point_model.dart';
import '../models/student_point_model.dart';
import 'points_repo.dart';

class PointsRepoImpl implements PointsRepo {
  final DioApiService _api;
  PointsRepoImpl(this._api);

  @override
  Future<List<StudentPoint>> fetchTopStudents({int limit = 10}) async {
    final resp = await _api.get(
      endPoint: '/admin/points/top-students?limit=$limit',
        token: await SharedPreferencesHelper.getJwtToken()
    );
    final list = (resp['data'] as List)
        .map((e) => StudentPoint.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }

  @override
  Future<StudentPoint> updatePoints({
    required int studentId,
    required int points,
  }) async {
    final resp = await _api.post(
      endPoint: '/admin/points/student/$studentId',
      token: await SharedPreferencesHelper.getJwtToken(),
      data: {'points': points},
    );
    // response.data['data'] holds the updated student
    final updated = resp['data'] as Map<String, dynamic>;
    return StudentPoint.fromJson(updated);
  }

  @override
  Future<List<SecretaryPoint>> fetchTopSecretaries({int limit = 10}) async {
    final resp = await _api.get(
      endPoint: '/admin/points/top-secretaries?limit=$limit',
        token: await SharedPreferencesHelper.getJwtToken()
    );
    return (resp['data'] as List)
        .map((e) => SecretaryPoint.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SecretaryPoint> updateSecretaryPoints({
    required int secretaryId,
    required int points,
  }) async {
    final resp = await _api.post(
      endPoint: '/admin/points/secretary/$secretaryId',
      token: await SharedPreferencesHelper.getJwtToken(),
      data: {'points': points},
    );
    return SecretaryPoint.fromJson(resp['data'] as Map<String, dynamic>);
  }
}
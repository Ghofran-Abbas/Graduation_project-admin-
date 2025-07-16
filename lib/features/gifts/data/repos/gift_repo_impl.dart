// lib/features/gifts/data/repos/gift_repo_impl.dart

import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/gift_model.dart';
import 'gift_repo.dart';

class GiftRepoImpl implements GiftRepo {
  final DioApiService _api;
  GiftRepoImpl(this._api);

  @override
  Future<GiftsPage> fetchAll({
    int? studentId,
    int? secretaryId,
    int page = 1,
  }) async {
    // let the server filter by student_id or secretary_id
    final parts = <String>['page=$page'];
    if (studentId   != null) parts.add('student_id=$studentId');
    if (secretaryId != null) parts.add('secretary_id=$secretaryId');
    final query = parts.join('&');

    final resp = await _api.get(
        endPoint: '/admin/gifts?$query',
        token: await SharedPreferencesHelper.getJwtToken()
    );
    return GiftsPage.fromJson(resp);
  }

  @override
  Future<Gift> fetchById(int id) async {
    final resp = await _api.get(endPoint: '/admin/gifts/$id', token: await SharedPreferencesHelper.getJwtToken());
    return Gift.fromJson(resp['gift'] as Map<String, dynamic>);
  }

  @override
  Future<Either<Failure, Gift>> create({
    required String description,
    required DateTime date,
    int? studentId,
    int? secretaryId,
    Uint8List? photoBytes,
  }) async {
    try {
      // Build the multipart map
      final map = <String, dynamic>{
        'description': description,
        'date': DateFormat('yyyy-MM-dd').format(date),
      };
      if (studentId != null)   map['student_id']   = studentId;
      if (secretaryId != null) map['secretary_id'] = secretaryId;
      if (photoBytes != null) {
        map['photo'] = await MultipartFile.fromBytes(
          photoBytes,
          filename: 'gift.jpg',
        );
      }

      final form = FormData.fromMap(map);
      debugPrint(
          '📡 CREATE (multipart) → /admin/gifts\n'
              '   fields: ${form.fields.map((f) => f.key).toList()}\n'
              '   files:  ${form.files.map((f) => f.key).toList()}'
      );

      final resp = await _api.postWithImage(
        endPoint: '/admin/gifts',
        token: await SharedPreferencesHelper.getJwtToken(),
        data: form,
      );
      debugPrint('✅ CREATE response → $resp');

      final giftJson = (resp['gift'] as Map<String, dynamic>?) ?? resp;
      return right(Gift.fromJson(giftJson));
    } on DioException catch (e, st) {
      debugPrint('❌ CREATE DioException: ${e.message}');
      if (e.response != null) {
        debugPrint('   status: ${e.response?.statusCode}');
        debugPrint('   data:   ${e.response?.data}');
      }
      debugPrint('   stack:  $st');
      return left(ServerFailure.fromDioError(e));
    } catch (e, st) {
      debugPrint('❌ CREATE error: $e');
      debugPrint('   stack: $st');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Gift>> update({
    required int id,
    String? description,
    DateTime? date,
    int? studentId,
    int? secretaryId,
    Uint8List? photoBytes,
  }) async {
    try {
      // Build the multipart map
      final map = <String, dynamic>{};
      if (description != null) map['description'] = description;
      if (date != null)        map['date']        = DateFormat('yyyy-MM-dd').format(date);
      if (studentId != null)   map['student_id']   = studentId;
      if (secretaryId != null) map['secretary_id'] = secretaryId;
      if (photoBytes != null) {
        map['photo'] = await MultipartFile.fromBytes(
          photoBytes,
          filename: 'gift.jpg',
        );
      }

      final form = FormData.fromMap(map);
      debugPrint(
          '📡 UPDATE (multipart) → /admin/gifts/$id\n'
              '   fields: ${form.fields.map((f) => f.key).toList()}\n'
              '   files:  ${form.files.map((f) => f.key).toList()}'
      );

      final resp = await _api.postWithImage(
        endPoint: '/admin/gifts/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
        data: form,
      );
      debugPrint('✅ UPDATE response → $resp');

      final giftJson = (resp['gift'] as Map<String, dynamic>?) ?? resp;
      return right(Gift.fromJson(giftJson));
    } on DioException catch (e, st) {
      debugPrint('❌ UPDATE DioException: ${e.message}');
      if (e.response != null) {
        debugPrint('   status: ${e.response?.statusCode}');
        debugPrint('   data:   ${e.response?.data}');
      }
      debugPrint('   stack:  $st');
      return left(ServerFailure.fromDioError(e));
    } catch (e, st) {
      debugPrint('❌ UPDATE error: $e');
      debugPrint('   stack: $st');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    try {
      debugPrint('📡 DELETE → /admin/gifts/$id');
      await _api.delete(endPoint: '/admin/gifts/$id', token: await SharedPreferencesHelper.getJwtToken(), data: null);
      debugPrint('✅ DELETE succeeded for id=$id');
      return right(unit);
    } on DioException catch (e, st) {
      debugPrint('❌ DELETE DioException: ${e.message}');
      if (e.response != null) {
        debugPrint('   status: ${e.response?.statusCode}');
        debugPrint('   data:   ${e.response?.data}');
      }
      debugPrint('   stack:  $st');
      return left(ServerFailure.fromDioError(e));
    } catch (e, st) {
      debugPrint('❌ DELETE error: $e');
      debugPrint('   stack: $st');
      return left(ServerFailure(e.toString()));
    }
  }
}

// lib/features/ads/data/repos/update_ad_repository_impl.dart

import 'dart:typed_data';

import 'package:admin_alhadara_dashboard/features/ads/data/repos/updateAd_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/ad_detail_model.dart';

class UpdateAdRepositoryImpl implements UpdateAdRepository {
  final DioApiService _api;
  UpdateAdRepositoryImpl(this._api);

  @override
  Future<AdDetailModel> updateAd({
    required int id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    String? photoFilePath,
    Uint8List? photoBytes,
    String? photoFileName,
  }) async {

    final token = await SharedPreferencesHelper.getJwtToken();

    MultipartFile multipart;
    FormData form;


    if ((photoBytes != null && kIsWeb) || photoFilePath != null) {
      if (photoBytes != null && kIsWeb) {
        multipart = MultipartFile.fromBytes(photoBytes, filename: photoFileName);
      } else {
        multipart = await MultipartFile.fromFile(photoFilePath!, filename: photoFileName);
      }
      form = FormData.fromMap({
        'title': title,
        'description': description,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'photo': multipart,
      });
    } else {

      form = FormData.fromMap({
        'title': title,
        'description': description,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
      });
    }

    final root = await _api.postWithImage(
      endPoint: '/admin/ads/$id',
      data: form,
      token: token,
    ) as Map<String, dynamic>;

    final data = root['data'] as Map<String, dynamic>;
    return AdDetailModel.fromJson(data);
  }
}
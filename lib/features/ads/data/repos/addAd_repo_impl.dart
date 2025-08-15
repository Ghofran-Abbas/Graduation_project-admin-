// lib/features/ads/data/repos/ad_repository_impl.dart

import 'package:admin_alhadara_dashboard/features/ads/data/repos/addAd_repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/utils/api_service.dart';
import '../models/ad_detail_model.dart';
import 'package:path/path.dart' as p;
// lib/features/ads/data/repos/ad_repository_impl.dart

import 'package:admin_alhadara_dashboard/core/utils/shared_preferences_helper.dart';
import 'package:admin_alhadara_dashboard/features/ads/data/repos/addAd_repo.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_service.dart';
import '../models/ad_detail_model.dart';
//
// class AdRepositoryImpl implements AdRepository {
//   final DioApiService _api;
//   AdRepositoryImpl(this._api);
//
//   @override
//   Future<AdDetailModel> createAd({
//     required String title,
//     required String description,
//     required String photoFilePath,
//     required DateTime startDate,
//     required DateTime endDate,
//   }) async {
//     final token = await SharedPreferencesHelper.getJwtToken();
//     if (token == null) throw Exception('No JWT token found');
//
//
//     MultipartFile photoPart;
//     if (kIsWeb) {
//
//       final result = await FilePicker.platform.pickFiles(type: FileType.image);
//       if (result == null || result.files.single.bytes == null) {
//         throw Exception('No image picked');
//       }
//       final bytes = result.files.single.bytes!;
//       final filename = result.files.single.name;
//       photoPart = MultipartFile.fromBytes(bytes, filename: filename);
//     } else {
//
//       photoPart = await MultipartFile.fromFile(
//         photoFilePath,
//         filename: p.basename(photoFilePath),
//       );
//     }
//
//     final form = FormData.fromMap({
//       'title':       title,
//       'description': description,
//       'start_date':  startDate.toIso8601String(),
//       'end_date':    endDate.toIso8601String(),
//       'photo':       photoPart,
//     });
//
//     final Map<String, dynamic> root = await _api.postWithImage(
//       endPoint: '/admin/ads',
//       data: form,
//       token: token,
//     ) as Map<String, dynamic>;
//
//     final data = root['data'] as Map<String, dynamic>;
//     return AdDetailModel.fromJson(data);
//   }
// }


import 'dart:typed_data';


class AdRepositoryImpl implements AdRepository {
  final DioApiService _api;
  AdRepositoryImpl(this._api);

  @override
  Future<AdDetailModel> createAd({
    required String title,
    required String description,
    String? photoFilePath,
    Uint8List? photoBytes,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final token = await SharedPreferencesHelper.getJwtToken();
    if (token == null) throw Exception('No JWT token found');

    // Build multipart file from provided data (do NOT call FilePicker here)
    MultipartFile photoPart;
    if (kIsWeb) {
      // On web: expect bytes
      if (photoBytes == null) {
        throw Exception('photoBytes must be provided on web');
      }
      final filename = 'upload.jpg';
      photoPart = MultipartFile.fromBytes(photoBytes, filename: filename);
    } else {
      // On mobile: expect file path
      if (photoFilePath == null) {
        throw Exception('photoFilePath must be provided on mobile');
      }
      photoPart = await MultipartFile.fromFile(
        photoFilePath,
        filename: p.basename(photoFilePath),
      );
    }

    final form = FormData.fromMap({
      'title': title,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'photo': photoPart,
    });

    final Map<String, dynamic> root = await _api.postWithImage(
      endPoint: '/admin/ads',
      data: form,
      token: token,
    ) as Map<String, dynamic>;

    final data = root['data'] as Map<String, dynamic>;
    return AdDetailModel.fromJson(data);
  }
}

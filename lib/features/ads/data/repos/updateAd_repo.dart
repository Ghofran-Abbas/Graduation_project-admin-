// lib/features/ads/data/repos/update_ad_repository.dart

import 'dart:typed_data';

import '../models/ad_detail_model.dart';
abstract class UpdateAdRepository {

  Future<AdDetailModel> updateAd({
    required int id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    String? photoFilePath,
    Uint8List? photoBytes,
    String? photoFileName,
  });
}
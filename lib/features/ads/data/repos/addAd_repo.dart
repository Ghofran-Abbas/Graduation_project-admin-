// lib/features/ads/data/repos/ad_repository.dart

import '../models/ad_detail_model.dart';

// abstract class AdRepository {
//
//   Future<AdDetailModel> createAd({
//     required String title,
//     required String description,
//     required String photoFilePath,
//     required DateTime startDate,
//     required DateTime endDate,
//   });
// }


// lib/features/ads/data/repos/ad_repository.dart
import 'dart:typed_data';
import '../models/ad_detail_model.dart';

abstract class AdRepository {
  Future<AdDetailModel> createAd({
    required String title,
    required String description,
    String? photoFilePath,   // path for mobile (android/ios)
    Uint8List? photoBytes,   // bytes for web
    required DateTime startDate,
    required DateTime endDate,
  });
}

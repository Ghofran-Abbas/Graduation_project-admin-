// lib/features/ads/data/repositories/ads_repository.dart

import '../models/ads_page_model.dart';

abstract class AdsRepository {
  Future<AdsPage> getAllAds({
    required String token,
    int page = 1,
  });
}

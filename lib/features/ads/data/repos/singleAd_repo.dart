// lib/features/ads/data/repos/single_ad_repository.dart

import '../models/ad_detail_model.dart';

abstract class SingleAdRepository {
  Future<AdDetailModel> fetchAdById(int id);
}
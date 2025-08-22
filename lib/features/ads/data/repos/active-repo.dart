// lib/features/ads/data/repos/active_ads_repository.dart



import '../models/ads_page_model.dart';

abstract class ActiveAdsRepository {
  /// يجلب صفحة من الإعلانات الفعّالة (active ads)
  Future<AdsPage> fetchActiveAds({ required int page });
}

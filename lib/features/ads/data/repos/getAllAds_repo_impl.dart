// lib/features/ads/data/repositories/ads_repository_impl.dart

import 'package:admin_alhadara_dashboard/features/ads/data/repos/getAllAds_repo.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/go_router_path.dart';
import '../models/ads_page_model.dart';


class AdsRepositoryImpl implements AdsRepository {
  final DioApiService _api;
  AdsRepositoryImpl(this._api);

  @override
  Future<AdsPage> getAllAds({
    required String token,
    int page = 1,
  }) async {
    try {
      final raw = await _api.get(
        endPoint: '/admin/ads?page=$page',
        token: token,
      );
      return AdsPage.fromJson(raw as Map<String, dynamic>);
    } catch (e) {
      debugPrint('🛑 AdsRepositoryImpl.getAllAds error → $e');
      rethrow;
    }
  }
}

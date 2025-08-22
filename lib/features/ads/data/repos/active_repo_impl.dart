// lib/features/ads/data/repos/active_ads_repository_impl.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/ads_page_model.dart';
import 'active-repo.dart';


class ActiveAdsRepositoryImpl implements ActiveAdsRepository {
  final DioApiService _api;

  ActiveAdsRepositoryImpl(this._api);

  @override
  Future<AdsPage> fetchActiveAds({required int page}) async {
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      if (token == null) {
        throw Exception('No JWT token found');
      }

      final raw = await _api.get(endPoint: '/admin/ads/active?page=$page', token: token);

      if (raw is Map<String, dynamic>) {
        // AdsPage.fromJson expects the root that contains 'data' map (matches API response)
        return AdsPage.fromJson(raw);
      }

      throw Exception('Unexpected response format when fetching active ads');
    } on DioError catch (e) {
      // إعادة رمي الخطأ لكي يعالجه الـ Cubit (أو يمكنك تحويله لرسالة خاصة)
      debugPrint('DioError ActiveAdsRepositoryImpl: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error ActiveAdsRepositoryImpl: $e');
      rethrow;
    }
  }
}

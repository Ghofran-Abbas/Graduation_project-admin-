// lib/features/ads/data/repos/single_ad_repository_impl.dart

import 'package:admin_alhadara_dashboard/features/ads/data/repos/singleAd_repo.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/ad_detail_model.dart';

class SingleAdRepositoryImpl implements SingleAdRepository {
  final DioApiService _api;
  SingleAdRepositoryImpl(this._api);

  @override
  Future<AdDetailModel> fetchAdById(int id) async {

    final token = await SharedPreferencesHelper.getJwtToken();
    if (token == null) {
      throw Exception('No JWT token found');
    }


    final raw = await _api.get(
      endPoint: '/admin/ads/$id',
      token: token,
    ) as Map<String, dynamic>;

    final data = raw['data'] as Map<String, dynamic>;
    return AdDetailModel.fromJson(data);
  }
}
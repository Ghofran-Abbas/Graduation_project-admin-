// lib/features/ads/data/repos/delete_ad_repository_impl.dart

import 'package:admin_alhadara_dashboard/core/utils/api_service.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../models/ads_delete_model.dart';
import 'add-delete_model_repo.dart';


class DeleteAdRepositoryImpl implements DeleteAdRepository {
  final DioApiService _api;
  DeleteAdRepositoryImpl(this._api);

  @override
  Future<String> deleteAd(int id) async {

    final token = await SharedPreferencesHelper.getJwtToken();
    if (token == null) {
      throw Exception('No JWT token found');
    }


    final result = await _api.delete(
      endPoint: '/admin/ads/$id',
      token: token, data: {},
    );


    final Map<String, dynamic> root = result as Map<String, dynamic>;


    final DeleteResponseModel resp = DeleteResponseModel.fromJson(root);
    return resp.message;
  }
}

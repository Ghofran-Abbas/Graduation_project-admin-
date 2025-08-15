// lib/features/ads/presentation/cubit/ads_cubit.dart

import 'package:admin_alhadara_dashboard/features/ads/presentation/manager/getAllAdsCubit/getAllAdsState.dart';
import 'package:bloc/bloc.dart';

import '../../../../../core/utils/shared_preferences_helper.dart';
import '../../../data/repos/getAllAds_repo.dart';



class AdsCubit extends Cubit<AdsState> {
  final AdsRepository _repo;
  AdsCubit(this._repo) : super(AdsInitial());

  Future<void> fetchAds({int page = 1}) async {
    emit(AdsLoading());
    try {
      final token = await SharedPreferencesHelper.getJwtToken();
      if (token == null) throw 'No JWT token found';
      final pageData = await _repo.getAllAds(token: token, page: page);
      emit(AdsLoaded(pageData));
    } catch (e) {
      emit(AdsError(e.toString()));
    }
  }
}

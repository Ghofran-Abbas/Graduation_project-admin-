// lib/features/ads/presentation/manager/active_ads_cubit/active_ads_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repos/active-repo.dart';
import 'active_state.dart';

class ActiveAdsCubit extends Cubit<ActiveAdsState> {
  final ActiveAdsRepository _repo;

  ActiveAdsCubit(this._repo) : super(ActiveAdsInitial());

  /// page: 1-based
  Future<void> fetchActiveAds({int page = 1}) async {
    emit(ActiveAdsLoading());
    try {
      final result = await _repo.fetchActiveAds(page: page);
      emit(ActiveAdsLoaded(result));
    } on DioError catch (e) {
      final msg = (e.response?.data['message'] as String?) ?? e.message ?? 'Network error';
      emit(ActiveAdsError(msg));
    } catch (e) {
      emit(ActiveAdsError(e.toString()));
    }
  }
}

// lib/features/ads/presentation/manager/single_ad_cubit/single_ad_cubit.dart

import 'package:admin_alhadara_dashboard/features/ads/presentation/manager/getAllAdsCubit/singleAdState.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repos/singleAd_repo.dart';

class SingleAdCubit extends Cubit<SingleAdState> {
  final SingleAdRepository _repo;
  SingleAdCubit(this._repo) : super(SingleAdInitial());

  Future<void> fetchAd(int id) async {
    try {
      emit(SingleAdLoading());
      final ad = await _repo.fetchAdById(id);
      emit(SingleAdLoaded(ad));
    } on DioError catch (e) {

      final msg = e.response?.data['message'] as String? ?? '';
      emit(SingleAdError(msg));
    } catch (e) {
      emit(SingleAdError(e.toString()));
    }
  }
}
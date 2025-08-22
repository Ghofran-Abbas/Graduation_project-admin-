// lib/features/ads/presentation/manager/update_ad_cubit/update_ad_cubit.dart

import 'dart:typed_data';

import 'package:admin_alhadara_dashboard/features/ads/presentation/manager/getAllAdsCubit/updateAd_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repos/updateAd_repo.dart';

class UpdateAdCubit extends Cubit<UpdateAdState> {
  final UpdateAdRepository _repo;
  UpdateAdCubit(this._repo) : super(UpdateAdInitial());

  Future<void> updateAd({
    required int id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    String? photoFilePath,
    Uint8List? photoBytes,
    String? photoFileName,
  }) async {
    try {
      emit(UpdateAdLoading());
      final ad = await _repo.updateAd(
        id: id,
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        photoFilePath: photoFilePath,
        photoBytes: photoBytes,
        photoFileName: photoFileName,
      );
      emit(UpdateAdSuccess(ad));
    } on DioError catch (e) {
      final msg = (e.response?.data['message'] as String?) ?? 'error';
      emit(UpdateAdFailure(msg));
    } catch (e) {
      emit(UpdateAdFailure(e.toString()));
    }
  }
}
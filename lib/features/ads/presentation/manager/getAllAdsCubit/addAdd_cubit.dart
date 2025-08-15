// lib/features/ads/presentation/manager/create_ad_cubit/create_ad_cubit.dart

import 'dart:typed_data';

import 'package:admin_alhadara_dashboard/features/ads/presentation/manager/getAllAdsCubit/addAd_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repos/addAd_repo.dart';

//
// class CreateAdCubit extends Cubit<CreateAdState> {
//   final AdRepository _repo;
//   CreateAdCubit(this._repo) : super(CreateAdInitial());
//
//   Future<void> createAd({
//     required String title,
//     required String description,
//     required String photoFilePath,
//     required DateTime startDate,
//     required DateTime endDate, Uint8List? photoBytes,
//   }) async {
//     try {
//       emit(CreateAdLoading());
//       final ad = await _repo.createAd(
//         title: title,
//         description: description,
//         photoFilePath: photoFilePath,
//         startDate: startDate,
//         endDate: endDate,
//       );
//       emit(CreateAdSuccess(ad));
//     } on DioError catch (e) {
//
//       final msg = (e.response?.data['message'] as String?) ?? '';
//       emit(CreateAdFailure(msg));
//     } catch (e) {
//       emit(CreateAdFailure(e.toString()));
//     }
//   }
// }


class CreateAdCubit extends Cubit<CreateAdState> {
  final AdRepository _repo;
  CreateAdCubit(this._repo) : super(CreateAdInitial());

  Future<void> createAd({
    required String title,
    required String description,
    String? photoFilePath,
    Uint8List? photoBytes,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      emit(CreateAdLoading());
      final ad = await _repo.createAd(
        title: title,
        description: description,
        photoFilePath: photoFilePath,
        photoBytes: photoBytes,
        startDate: startDate,
        endDate: endDate,
      );
      emit(CreateAdSuccess(ad));
    } on DioError catch (e) {
      final msg = (e.response?.data['message'] as String?) ?? 'Network error';
      emit(CreateAdFailure(msg));
    } catch (e) {
      emit(CreateAdFailure(e.toString()));
    }
  }
}

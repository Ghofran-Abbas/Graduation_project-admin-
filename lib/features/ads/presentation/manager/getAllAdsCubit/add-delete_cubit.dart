// lib/features/ads/presentation/manager/delete_ad_cubit/delete_ad_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../data/repos/add-delete_model_repo.dart';
import 'add-delete_state.dart';


class DeleteAdCubit extends Cubit<DeleteAdState> {
  final DeleteAdRepository _repo;
  DeleteAdCubit(this._repo) : super(DeleteAdInitial());

  Future<void> deleteAd(int id) async {
    try {
      emit(DeleteAdLoading());
      final message = await _repo.deleteAd(id);
      emit(DeleteAdSuccess(message));
    } on DioError catch (e) {

      final msg = (e.response?.data['message'] as String?) ?? 'server error';
      emit(DeleteAdFailure(msg));
    } catch (e) {
      emit(DeleteAdFailure(e.toString()));
    }
  }
}

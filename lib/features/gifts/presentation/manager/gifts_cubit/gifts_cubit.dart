// lib/features/gifts/presentation/manager/gifts_cubit/gifts_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/gift_model.dart';
import '../../../data/repos/gift_repo.dart';
import '../../../../../core/errors/failure.dart';
import 'gifts_state.dart';

class GiftsCubit extends Cubit<GiftsState> {
  final GiftRepo _repo;
  GiftsCubit(this._repo) : super(GiftsInitial());

  /// Load a specific page for a student, appending if page>1
  Future<void> fetchForStudent(int studentId, {int page = 1}) async {
    if (page == 1) emit(GiftsLoading());
    try {
      final p = await _repo.fetchAll(studentId: studentId, page: page);
      final combined = page == 1
          ? p.gifts
          : [
        if (state is GiftsSuccess) ...((state as GiftsSuccess).gifts),
        ...p.gifts
      ];

      emit(GiftsSuccess(
        gifts: combined,
        currentPage: p.currentPage,
        lastPage: p.lastPage,
      ));
    } catch (e) {
      emit(GiftsFailure(e.toString()));
    }
  }

  /// Same for secretary
  Future<void> fetchForSecretary(int secretaryId, {int page = 1}) async {
    if (page == 1) emit(GiftsLoading());
    try {
      final p = await _repo.fetchAll(secretaryId: secretaryId, page: page);
      final combined = page == 1
          ? p.gifts
          : [
        if (state is GiftsSuccess) ...((state as GiftsSuccess).gifts),
        ...p.gifts
      ];

      emit(GiftsSuccess(
        gifts: combined,
        currentPage: p.currentPage,
        lastPage: p.lastPage,
      ));
    } catch (e) {
      emit(GiftsFailure(e.toString()));
    }
  }
}

// lib/features/gifts/presentation/manager/gifts_cubit/gifts_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/gift_model.dart';
import '../../../data/repos/gift_repo.dart';
import '../../../../../core/errors/failure.dart';
import 'gifts_state.dart';

class GiftsCubit extends Cubit<GiftsState> {
  final GiftRepo _repo;

  GiftsCubit(this._repo) : super(GiftsInitial());

// lib/features/gifts/presentation/manager/gifts_cubit/gifts_cubit.dart

  Future<void> fetchForStudent(int studentId, {int page = 1}) async {
    if (page == 1) emit(GiftsLoading());
    try {
      final p = await _repo.fetchAll(studentId: studentId, page: page);

      // ⬇️ defensive filter (adjust field names to your model)
      final current = p.gifts.where((g) => g.studentId == studentId).toList();

      final combined = page == 1
          ? current
          : [
        if (state is GiftsSuccess) ...((state as GiftsSuccess).gifts),
        ...current,
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

  Future<void> fetchForSecretary(int secretaryId, {int page = 1}) async {
    if (page == 1) emit(GiftsLoading());
    try {
      final p = await _repo.fetchAll(secretaryId: secretaryId, page: page);

      // ⬇️ defensive filter (adjust field names to your model)
      final current = p.gifts.where((g) => g.secretaryId == secretaryId)
          .toList();

      final combined = page == 1
          ? current
          : [
        if (state is GiftsSuccess) ...((state as GiftsSuccess).gifts),
        ...current,
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
// lib/features/gifts/presentation/manager/delete_gift_cubit/delete_gift_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../data/repos/gift_repo.dart';
import '../../../../../core/errors/failure.dart';
import 'delete_gift_state.dart';

class DeleteGiftCubit extends Cubit<DeleteGiftState> {
  final GiftRepo _repo;
  DeleteGiftCubit(this._repo) : super(DeleteGiftInitial());

  Future<void> deleteGift(int id) async {
    emit(DeleteGiftLoading());
    final Either<Failure, Unit> res = await _repo.delete(id);
    res.fold(
          (f) => emit(DeleteGiftFailure(f.errorMessage)),
          (_) => emit(DeleteGiftSuccess()),
    );
  }
}

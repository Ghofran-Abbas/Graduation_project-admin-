// lib/features/gifts/presentation/manager/update_gift_cubit/update_gift_cubit.dart

import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/gift_model.dart';
import '../../../data/repos/gift_repo.dart';
import '../../../../../core/errors/failure.dart';
import 'update_gift_state.dart';

class UpdateGiftCubit extends Cubit<UpdateGiftState> {
  final GiftRepo _repo;
  UpdateGiftCubit(this._repo) : super(UpdateGiftInitial());

  Future<void> updateGift({
    required int id,
    String? description,
    DateTime? date,
    Uint8List? photoBytes,
  }) async {
    emit(UpdateGiftLoading());
    final Either<Failure, Gift> result = await _repo.update(
      id: id,
      description: description,
      date: date,
      photoBytes: photoBytes,
    );
    result.fold(
          (f) => emit(UpdateGiftFailure(f.errorMessage)),
          (g) => emit(UpdateGiftSuccess(g)),
    );
  }
}

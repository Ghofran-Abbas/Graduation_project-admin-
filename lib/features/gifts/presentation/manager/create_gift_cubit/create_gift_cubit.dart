// lib/features/gifts/presentation/manager/create_gift_cubit/create_gift_cubit.dart

import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/gift_model.dart';
import '../../../data/repos/gift_repo.dart';
import '../../../../../core/errors/failure.dart';
import 'create_gift_state.dart';

class CreateGiftCubit extends Cubit<CreateGiftState> {
  final GiftRepo _repo;
  CreateGiftCubit(this._repo) : super(CreateGiftInitial());

  /// Either [studentId] or [secretaryId] must be non-null.
  Future<void> createGift({
    required String description,
    required DateTime date,
    int? studentId,
    int? secretaryId,
    Uint8List? photoBytes,
  }) async {
    emit(CreateGiftLoading());

    // ensure we have one and only one target
    if ((studentId == null && secretaryId == null) ||
        (studentId != null && secretaryId != null)) {
      emit(const CreateGiftFailure(
          'Must provide exactly one of studentId or secretaryId'));
      return;
    }

    final Either<Failure, Gift> result = await _repo.create(
      description: description,
      date: date,
      studentId: studentId,
      secretaryId: secretaryId,
      photoBytes: photoBytes,
    );

    result.fold(
          (failure) => emit(CreateGiftFailure(failure.errorMessage)),
          (gift) => emit(CreateGiftSuccess(gift)),
    );
  }
}

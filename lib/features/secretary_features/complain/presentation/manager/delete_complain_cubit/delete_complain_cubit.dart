import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/complain_repo.dart';
import 'delete_complain_state.dart';

class DeleteComplainCubit extends Cubit<DeleteComplainState>{
  static DeleteComplainState get(context) => BlocProvider.of(context);

  DeleteComplainCubit(this.complainRepo,) : super(DeleteComplainInitial());

  final ComplainRepo complainRepo;

  Future<void> fetchDeleteComplain({
    required int id,
  }) async {
    emit(DeleteComplainLoading());
    var result = await complainRepo.fetchDeleteComplain(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteComplainFailure(failure.errorMessage));
    }, (updateResult) {
      emit(DeleteComplainSuccess(updateResult));
    });
  }
}
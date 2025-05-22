import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/complain_repo.dart';
import 'details_complain_state.dart';

class DetailsComplainCubit extends Cubit<DetailsComplainState>{
  static DetailsComplainCubit get(context) => BlocProvider.of(context);

  final ComplainRepo complainRepo;

  DetailsComplainCubit(this.complainRepo) : super(DetailsComplainInitial());

  Future<void> fetchDetailsComplain({
    required int id,
  }) async {
    emit(DetailsComplainLoading());
    var result = await complainRepo.fetchDetailsComplain(id: id,);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsComplainFailure(failure.errorMessage));
    }, (complain) {
      emit(DetailsComplainSuccess(complain));
    });
  }
}
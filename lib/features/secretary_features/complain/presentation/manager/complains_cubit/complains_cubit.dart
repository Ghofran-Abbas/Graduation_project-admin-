import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/complain_repo.dart';
import 'complains_state.dart';

class ComplainsCubit extends Cubit<ComplainsState>{
  static ComplainsCubit get(context) => BlocProvider.of(context);

  final ComplainRepo complainRepo;

  ComplainsCubit(this.complainRepo) : super(ComplainsInitial());

  Future<void> fetchComplains({required int page}) async {
    emit(ComplainsLoading());
    var result = await complainRepo.fetchComplains(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ComplainsFailure(failure.errorMessage));
    }, (complains) {
      emit(ComplainsSuccess(complains));
    });
  }
}
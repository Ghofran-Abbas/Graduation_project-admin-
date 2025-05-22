import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/trainer_repo.dart';
import 'trainers_state.dart';

class TrainersCubit extends Cubit<TrainersState> {

  static TrainersCubit get(context) => BlocProvider.of(context);

  TrainersCubit(this.trainerRepo) : super (TrainersInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchTrainers({required int page}) async {
    emit(TrainersLoading());
    var result = await trainerRepo.fetchTrainers(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(TrainersFailure(failure.errorMessage));
    }, (trainers) {
      emit(TrainersSuccess(trainers));
    },
    );
  }
}
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/trainer_repo.dart';
import 'create_trainer_state.dart';

class CreateTrainerCubit extends Cubit<CreateTrainerState> {

  static CreateTrainerCubit get(context) => BlocProvider.of(context);

  CreateTrainerCubit(this.trainerRepo) : super (CreateTrainerInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchCreateTrainer({
    required String name,
    required String email,
    required String phone,
    required String password,
    required Uint8List photo,
    required String birthday,
    required String gender,
    required String specialization,
    required String experience,
  }) async {
    emit(CreateTrainerLoading());
    var result = await trainerRepo.fetchCreateTrainer(
      name: name,
      email: email,
      password: password,
      phone: phone,
      photo: photo,
      birthday: birthday,
      gender: gender,
      specialization: specialization,
      experience: experience,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateTrainerFailure(failure.errorMessage));
    }, (createTrainer) {
      emit(CreateTrainerSuccess(createTrainer));
    },
    );
  }
}
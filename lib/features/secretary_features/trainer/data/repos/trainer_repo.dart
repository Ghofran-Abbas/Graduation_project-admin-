import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/create_trainer_model.dart';
import '../models/delete_trainer_model.dart';
import '../models/details_trainer_model.dart';
import '../models/search_trainer_model.dart';
import '../models/trainers_model.dart';
import '../models/update_trainer_model.dart';

abstract class TrainerRepo {
  Future<Either<Failure, TrainersModel>> fetchTrainers({required int page});

  Future<Either<Failure, CreateTrainerModel>> fetchCreateTrainer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required Uint8List photo,
    required String gender,
    required String specialization,
    required String experience,
  });

  Future<Either<Failure, UpdateTrainerModel>> fetchUpdateTrainer({
    required int id,
    String? name,
    String? phone,
    String? birthday,
    String? gender,
    Uint8List? photo,
  });

  Future<Either<Failure, DeleteTrainerModel>> fetchDeleteTrainer({
    required int id,
  });

  Future<Either<Failure, DetailsTrainerModel>> fetchDetailsTrainer({
    required int id,
  });

  Future<Either<Failure, SearchTrainerModel>> fetchSearchTrainer({required String querySearch, required int page});
}
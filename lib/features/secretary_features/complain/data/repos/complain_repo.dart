import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/complains_model.dart';
import '../models/delete_complain_model.dart';
import '../models/details_complain_model.dart';
import '../models/search_complain_model.dart';

abstract class ComplainRepo {
  Future<Either<Failure, ComplainsModel>> fetchComplains({required int page});

  Future<Either<Failure, DetailsComplainModel>> fetchDetailsComplain({required int id});

  Future<Either<Failure, DeleteComplainModel>> fetchDeleteComplain({required int id,});

  Future<Either<Failure, SearchComplainModel>> fetchSearchComplain({required String querySearch, required int page});
}
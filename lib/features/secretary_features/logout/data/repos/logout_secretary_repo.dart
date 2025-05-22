import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/logout_secretary_model.dart';

abstract class LogoutSecretaryRepo {
  Future<Either<Failure, LogoutSecretaryModel>> fetchLogoutSecretary();
}
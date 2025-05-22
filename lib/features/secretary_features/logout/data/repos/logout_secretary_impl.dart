import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/logout_secretary_model.dart';
import 'logout_secretary_repo.dart';

class LogoutSecretaryRepoImpl extends LogoutSecretaryRepo{

  final DioApiService dioApiService;

  LogoutSecretaryRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, LogoutSecretaryModel>> fetchLogoutSecretary() async {
    try{
      var data = await (dioApiService.post(
        endPoint: '/auth/admin/logout',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      LogoutSecretaryModel logoutSecretaryModel;
      logoutSecretaryModel = LogoutSecretaryModel.fromJson(data);

      return right(logoutSecretaryModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
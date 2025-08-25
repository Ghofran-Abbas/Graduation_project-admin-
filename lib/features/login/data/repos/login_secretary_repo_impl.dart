import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_service.dart';
import '../models/login_secretary_model.dart';
import 'login_secretary_repo.dart';

class LoginRepoImpl extends LoginRepo{

  final DioApiService dioApiService;

  LoginRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, LoginSecretaryModel>> fetchLoginSecretary({
    required String email,
    required String password,
    required String fcm_token,
  }) async {
    try{
      var data = await (dioApiService.post(
        endPoint: '/auth/admin/login',
        data: {
          "email": email,
          "password": password,
          "fcm_token": fcm_token,
        },
        token: '',
      ));
      log(data.toString());
      LoginSecretaryModel loginSecretaryModel;
      loginSecretaryModel = LoginSecretaryModel.fromJson(data);

      return right(loginSecretaryModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../models/verification_model.dart';
import 'verification_repo.dart';

class VerificationRepoImpl extends VerificationRepo{

  final DioApiService dioApiService;
  static var dio = Dio();

  VerificationRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, VerificationModel>> fetchVerification({
    required String token,
    required String password,
    required String password_confirmation,
  }) async {
    try{
      var data = await (dioApiService.post(
        endPoint: '/auth/secretary/passwordReset',
        data: {
          "token": token,
          "password": password,
          "password_confirmation": password_confirmation,
        },
        token: '',
      ));
      log(data.toString());
      VerificationModel verificationModel;
      verificationModel = VerificationModel.fromJson(data);

      return right(verificationModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
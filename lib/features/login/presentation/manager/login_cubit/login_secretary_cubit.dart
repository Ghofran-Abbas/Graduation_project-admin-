import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared_preferences_helper.dart';
import '../../../data/repos/login_secretary_repo.dart';
import 'login_secretary_state.dart';

class LoginCubit extends Cubit<LoginState>{
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginCubit(this.loginRepo) : super (LoginInitial());

  final LoginRepo loginRepo;

  Future<void> fetchCreateTrainer({
    required String email,
    required String password,
    required String fcm_token,
  }) async {
    emit(LoginLoading());
    var result = await loginRepo.fetchLoginSecretary(
      email: email,
      password: password,
      fcm_token: fcm_token,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(LoginFailure(failure.errorMessage));
    }, (loginResult) async {
      await SharedPreferencesHelper.saveJwtToken(loginResult.data.accessToken);
      await SharedPreferencesHelper.saveUserID(loginResult.data.admin.id);
      await SharedPreferencesHelper.saveLoginModel(loginResult);
      emit(LoginSuccess(loginResult));
    },
    );
  }
}
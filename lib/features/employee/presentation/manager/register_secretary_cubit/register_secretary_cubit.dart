import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../data/models/register_secretary_model.dart';
import '../../../data/repos/employee_repo.dart';
import 'register_secretary_state.dart';

class RegisterSecretaryCubit extends Cubit<RegisterSecretaryState> {
  final EmployeeRepo _repo;
  RegisterSecretaryCubit(this._repo) : super(RegisterSecretaryInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required String gender,
    Uint8List? photoBytes,
  }) async {
    emit(RegisterSecretaryLoading());
    final Either<Failure, RegisterSecretaryModel> result =
    await _repo.registerSecretary(
      name: name,
      email: email,
      password: password,
      phone: phone,
      birthday: birthday,
      gender: gender,
      photoBytes: photoBytes,
    );
    result.fold(
          (f) => emit(RegisterSecretaryFailure(f.errorMessage)),
          (m) => emit(RegisterSecretarySuccess(m)),
    );
  }
}
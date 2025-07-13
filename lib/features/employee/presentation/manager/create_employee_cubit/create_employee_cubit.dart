// lib/features/employee/presentation/manager/create_employee_cubit/create_employee_cubit.dart

import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/create_employee_model.dart';
import '../../../data/repos/employee_repo.dart';
import 'create_employee_state.dart';

class CreateEmployeeCubit extends Cubit<CreateEmployeeState> {
  final EmployeeRepo _repo;

  CreateEmployeeCubit(this._repo) : super(CreateEmployeeInitial());

  Future<void> createEmployee({
    required String name,
    required String email,
    required String phone,
    required String birthday,
    required String gender,
    required String role,
    Uint8List? photoBytes,
  }) async {
    emit(CreateEmployeeLoading());

    final Either<Failure, CreateEmployeeModel> result =
    await _repo.fetchCreateEmployee(
      name:       name,
      email:      email,
      phone:      phone,
      birthday:   birthday,
      gender:     gender,
      role:       role,
      photoBytes: photoBytes,
    );

    result.fold(
          (failure) => emit(CreateEmployeeFailure(failure.errorMessage)),
          (model)   => emit(CreateEmployeeSuccess(model)),
    );
  }
}

// lib/features/employee/presentation/manager/update_employee_cubit/update_employee_cubit.dart

import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/update_employee_model.dart';
import '../../../data/repos/employee_repo.dart';
import 'update_employee_state.dart';

class UpdateEmployeeCubit extends Cubit<UpdateEmployeeState> {
  final EmployeeRepo _repo;

  UpdateEmployeeCubit(this._repo) : super(UpdateEmployeeInitial());

  Future<void> fetchUpdateEmployee({
    required int      id,
    String?           name,

    Uint8List?        photoBytes,
  }) async {
    emit(UpdateEmployeeLoading());
    final Either<Failure, UpdateEmployeeModel> result =
    await _repo.fetchUpdateEmployee(
      id:         id,
      name:       name,

      photoBytes: photoBytes,
    );

    result.fold(
          (failure) => emit(UpdateEmployeeFailure(failure.errorMessage)),
          (model)   => emit(UpdateEmployeeSuccess(model)),
    );
  }
}

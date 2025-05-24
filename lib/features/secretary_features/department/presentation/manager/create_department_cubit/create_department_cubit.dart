import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/department_repo.dart';
import 'create_department_state.dart';

class CreateDepartmentCubit extends Cubit<CreateDepartmentState>{

  static CreateDepartmentCubit get(context) => BlocProvider.of(context);

  final DepartmentRepo departmentRepo;

  CreateDepartmentCubit(this.departmentRepo) : super(CreateDepartmentInitial());

  Future<void> fetchCreateDepartment({
    required String name,
    required Uint8List photo,
  }) async {
    emit(CreateDepartmentLoading());
    var result = await departmentRepo.fetchCreateDepartment(
      name: name,
      photo: photo,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateDepartmentFailure(failure.errorMessage));
    }, (createResult) {
      emit(CreateDepartmentSuccess(createResult));
    });
  }
}
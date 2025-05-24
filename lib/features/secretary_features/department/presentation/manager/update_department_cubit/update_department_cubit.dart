import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/department_repo.dart';
import 'update_department_state.dart';

class UpdateDepartmentCubit extends Cubit<UpdateDepartmentState>{

  static UpdateDepartmentCubit get(context) => BlocProvider.of(context);

  final DepartmentRepo departmentRepo;

  UpdateDepartmentCubit(this.departmentRepo) : super(UpdateDepartmentInitial());

  Future<void> fetchUpdateDepartment({
    required int departmentId,
    String? name,
    Uint8List? photo,
  }) async {
    emit(UpdateDepartmentLoading());
    var result = await departmentRepo.fetchUpdateDepartment(
      id: departmentId,
      name: name,
      photo: photo,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateDepartmentFailure(failure.errorMessage));
    }, (updateResult) {
      emit(UpdateDepartmentSuccess(updateResult));
    });
  }
}
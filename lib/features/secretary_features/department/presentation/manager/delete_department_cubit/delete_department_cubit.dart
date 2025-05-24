import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/department_repo.dart';
import 'delete_department_state.dart';

class DeleteDepartmentCubit extends Cubit<DeleteDepartmentState>{

  static DeleteDepartmentCubit get(context) => BlocProvider.of(context);

  final DepartmentRepo departmentRepo;

  DeleteDepartmentCubit(this.departmentRepo) : super(DeleteDepartmentInitial());

  Future<void> fetchDeleteDepartment({required int departmentId,}) async {
    emit(DeleteDepartmentLoading());
    var result = await departmentRepo.fetchDeleteDepartment(id: departmentId,);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteDepartmentFailure(failure.errorMessage));
    }, (deleteResult) {
      emit(DeleteDepartmentSuccess(deleteResult));
    });
  }
}
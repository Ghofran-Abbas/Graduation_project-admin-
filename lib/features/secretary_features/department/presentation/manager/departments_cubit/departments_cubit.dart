import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/department_repo.dart';
import 'departments_state.dart';

class DepartmentsCubit extends Cubit<DepartmentsState>{

  static DepartmentsCubit get(context) => BlocProvider.of(context);

  DepartmentsCubit(this.departmentsRepo) : super(DepartmentsInitial());

  final DepartmentRepo departmentsRepo;

  Future<void> fetchDepartments({required int page}) async {
    emit(DepartmentsLoading());
    var result = await departmentsRepo.fetchDepartments(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DepartmentsFailure(failure.errorMessage));
    }, (departments) {
      emit(DepartmentsSuccess(departments));
    });
  }
}
// lib/features/employee/presentation/manager/search_employee_cubit/search_employee_cubit.dart

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/search_employee_model.dart';
import '../../../data/repos/employee_repo.dart';
import 'search_employee_state.dart';

class SearchEmployeeCubit extends Cubit<SearchEmployeeState> {
  static SearchEmployeeCubit of(context) => BlocProvider.of(context);

  final EmployeeRepo repo;

  SearchEmployeeCubit(this.repo) : super(SearchEmployeeInitial());

  Future<void> fetchSearchEmployee({
    required String querySearch,
    required int page,
  }) async {
    emit(SearchEmployeeLoading());
    final result = await repo.fetchSearchEmployee(querySearch: querySearch, page: page);
    result.fold(
          (Failure f) {
        log(f.errorMessage);
        emit(SearchEmployeeFailure(f.errorMessage));
      },
          (SearchEmployeeModel m) {
        emit(SearchEmployeeSuccess(m));
      },
    );
  }
}

import 'dart:developer';

import 'package:admin_alhadara_dashboard/core/utils/shared_preferences_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../models/departments_model.dart';
import '../models/details_department_model.dart';
import 'department_repo.dart';

class DepartmentRepoImpl extends DepartmentRepo{
  final DioApiService dioApiService;

  DepartmentRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, DepartmentsModel>> fetchDepartments({required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/admin/departments?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DepartmentsModel departmentsModel;
      departmentsModel = DepartmentsModel.fromJson(data);

      return right(departmentsModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsDepartmentModel>> fetchDetailsDepartment({required int id}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/admin/departments/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DetailsDepartmentModel detailsDepartmentModel;
      detailsDepartmentModel = DetailsDepartmentModel.fromJson(data);

      return right(detailsDepartmentModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
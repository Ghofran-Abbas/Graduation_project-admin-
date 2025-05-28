import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_alhadara_dashboard/core/utils/shared_preferences_helper.dart';
import 'package:admin_alhadara_dashboard/features/secretary_features/department/data/models/create_department_model.dart';
import 'package:admin_alhadara_dashboard/features/secretary_features/department/data/models/update_department_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../models/delete_department_model.dart';
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

  @override
  Future<Either<Failure, CreateDepartmentModel>> fetchCreateDepartment({required String name, required Uint8List photo}) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "photo": MultipartFile.fromBytes(
        photo,
        filename: 'upload.png',
      ),
    });

    try {
      var data = await (dioApiService.postWithImage(
        endPoint: '/admin/departments',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      CreateDepartmentModel createDepartmentModel;
      createDepartmentModel = CreateDepartmentModel.fromJson(data);

      return right(createDepartmentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateDepartmentModel>> fetchUpdateDepartment({required int id, String? name, Uint8List? photo}) async {
    final Map<String, dynamic> dataMap = {};

    if (name != null && name.trim().isNotEmpty) {
      dataMap['name'] = name;
    }

    if (photo != null) {
      dataMap['photo'] = MultipartFile.fromBytes(
        photo,
        filename: 'upload.png',
      );
    }

    if (dataMap.isEmpty) {
      return left(ServerFailure('يجب تعديل حقل واحد على الأقل قبل الإرسال.'));
    }

    final formData = FormData.fromMap(dataMap);

    try {
      var data = await (dioApiService.postWithImage(
        endPoint: '/admin/departments/$id',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      UpdateDepartmentModel updateDepartmentModel;
      updateDepartmentModel = UpdateDepartmentModel.fromJson(data);

      return right(updateDepartmentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteDepartmentModel>> fetchDeleteDepartment({required int id}) async {
    try {
      var data = await (dioApiService.delete(
        endPoint: '/admin/departments/$id',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteDepartmentModel deleteDepartmentModel;
      deleteDepartmentModel = DeleteDepartmentModel.fromJson(data);

      return right(deleteDepartmentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
// lib/features/employee/data/repos/employee_repo_impl.dart

import 'dart:typed_data' show Uint8List;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_service.dart';
import '../models/create_employee_model.dart';
import '../models/details_employee_model.dart';
import '../models/employees_model.dart';
import '../models/register_secretary_model.dart';
import '../models/search_employee_model.dart';
import '../models/update_employee_model.dart';
import 'employee_repo.dart';

class EmployeeRepoImpl implements EmployeeRepo {
  final DioApiService _api;

  EmployeeRepoImpl(this._api);


  @override
  Future<EmployeesPage> fetchAll({int page = 1}) async {
    // include the page query
    final resp = await _api.get(
      endPoint: '/admin/employee/showAllEmployees?page=$page',
    );
    // parse into your new wrapper
    return EmployeesPage.fromJson(resp);
  }


  @override
  Future<EmployeeDetail> fetchById(int id) async {
    final resp = await _api.get(endPoint: '/admin/employee/showEmployeeById/$id');
    // parse with our new model:
    final details = DetailsEmployeeModel.fromJson(resp);
    return details.employee;
  }
  @override
  Future<List<Employee>> search(String query) async {
    final resp =
    await _api.get(endPoint: '/admin/employee/searchEmployee/$query');
    final items = resp['Employees']['data'] as List;
    return items.map((e) => Employee.fromJson(e)).toList();
  }

  @override
  Future<void> delete(int id) async {
    await _api.post(endPoint: '/admin/employee/deleteEmployee/$id', data: null);
  }

  @override
  Future<Either<Failure, UpdateEmployeeModel>> fetchUpdateEmployee({
    required int id,
    String? name,

    Uint8List? photoBytes,
  }) async {
    final dataMap = <String, dynamic>{};
    if (name
        ?.trim()
        .isNotEmpty ?? false) dataMap['name'] = name;


    if (dataMap.isEmpty && photoBytes == null) {
      return left(ServerFailure(
        'Please change at least one field or choose a new image.',
      ));
    }

    try {
      if (photoBytes != null) {
        dataMap['photo'] = MultipartFile.fromBytes(
          photoBytes,
          filename: 'photo.jpg',
        );
      }

      final form = FormData.fromMap(dataMap);
      debugPrint(
          '📡 UPDATE (multipart) → /admin/employee/updateEmployee/$id\n'
              '   fields: ${form.fields.map((e) => e.key).toList()}'
      );

      final respData = await _api.postWithImage(
        endPoint: '/admin/employee/updateEmployee/$id',
        data: form,
      );
      debugPrint('✅ UPDATE response → $respData');
      return right(UpdateEmployeeModel.fromJson(respData));
    }
    on DioException catch (e, st) {
      debugPrint('❌ UPDATE DioException: ${e.message}');
      if (e.response != null) {
        debugPrint('   status: ${e.response?.statusCode}');
        debugPrint('   data:   ${e.response?.data}');
      }
      debugPrint('   stack:  $st');
      return left(ServerFailure.fromDioError(e));
    }
    catch (e, st) {
      debugPrint('❌ UPDATE error (other): $e');
      debugPrint('   stack:  $st');
      return left(ServerFailure(e.toString()));
    }
  }

  ///////////////////////
  @override
  Future<Either<Failure, CreateEmployeeModel>> fetchCreateEmployee({
    required String name,
    required String email,
    required String phone,
    required String birthday,
    required String gender,
    required String role,
    Uint8List? photoBytes,
  }) async {


    // Build the multipart form
    final dataMap = {
      'name': name,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'role': role,
      if (photoBytes != null)
      'photo': MultipartFile.fromBytes(
        photoBytes,
        filename: 'photo.jpg',
      ),
    };

    try {
      final form = FormData.fromMap(dataMap);
      debugPrint(
          '📡 CREATE (multipart) → /admin/employee/addEmployee\n'
              '   fields: ${form.fields.map((e) => e.key).toList()}'
      );

      final respData = await _api.postWithImage(
        endPoint: '/admin/employee/addEmployee',
        data: form,
      );

      debugPrint('✅ CREATE response → $respData');
      return right(CreateEmployeeModel.fromJson(respData));
    } on DioException catch (e, st) {
      debugPrint('❌ CREATE DioException: ${e.message}');
      if (e.response != null) {
        debugPrint('   status: ${e.response?.statusCode}');
        debugPrint('   data:   ${e.response?.data}');
      }
      debugPrint('   stack:  $st');
      return left(ServerFailure.fromDioError(e));
    } catch (e, st) {
      debugPrint('❌ CREATE error (other): $e');
      debugPrint('   stack:  $st');
      return left(ServerFailure(e.toString()));
    }
  }






  @override
  Future<Either<Failure, RegisterSecretaryModel>> registerSecretary({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required String gender,
    Uint8List? photoBytes,
  }) async {


    // Build the multipart form
    final dataMap = {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      if (photoBytes != null)
        'photo': MultipartFile.fromBytes(photoBytes, filename: 'photo.jpg'),
    };

    try {
      final form = FormData.fromMap(dataMap);
      debugPrint(
          '📡 CREATE (multipart) → /admin/secretary/registrationSecretary\n'
              '   fields: ${form.fields.map((e) => e.key).toList()}'
      );

      final respData = await _api.postWithImage(
        endPoint: '/admin/secretary/registrationSecretary',
        data: form,
      );

      debugPrint('✅ CREATE response → $respData');
      return right(RegisterSecretaryModel.fromJson(respData));
    } on DioException catch (e, st) {
      debugPrint('❌ CREATE DioException: ${e.message}');
      if (e.response != null) {
        debugPrint('   status: ${e.response?.statusCode}');
        debugPrint('   data:   ${e.response?.data}');
      }
      debugPrint('   stack:  $st');
      return left(ServerFailure.fromDioError(e));
    } catch (e, st) {
      debugPrint('❌ CREATE error (other): $e');
      debugPrint('   stack:  $st');
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, SearchEmployeeModel>> fetchSearchEmployee({
    required String querySearch,
    required int page,
  }) async {
    try {
      final data = await _api.get(
        endPoint: '/admin/employee/searchEmployee/$querySearch?page=$page',
      );
      final model = SearchEmployeeModel.fromJson(data);
      return right(model);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
import 'dart:typed_data';

import 'package:admin_alhadara_dashboard/features/secretary_features/department/data/models/create_department_model.dart';
import 'package:admin_alhadara_dashboard/features/secretary_features/department/data/models/delete_department_model.dart';
import 'package:admin_alhadara_dashboard/features/secretary_features/department/data/models/update_department_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/departments_model.dart';
import '../models/details_department_model.dart';

abstract class DepartmentRepo {

  Future<Either<Failure, DepartmentsModel>> fetchDepartments({required int page});

  Future<Either<Failure, CreateDepartmentModel>> fetchCreateDepartment({
    required String name,
    required Uint8List photo,
  });

  Future<Either<Failure, DetailsDepartmentModel>> fetchDetailsDepartment({required int id,});

  Future<Either<Failure, UpdateDepartmentModel>> fetchUpdateDepartment({
    required int id,
    String? name,
    Uint8List? photo,
  });

  Future<Either<Failure, DeleteDepartmentModel>> fetchDeleteDepartment({required int id,});
}
// lib/features/employee/data/repos/employee_repo.dart

import 'dart:typed_data' show Uint8List;
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/create_employee_model.dart';
import '../models/details_employee_model.dart';
import '../models/employees_model.dart';
import '../models/register_secretary_model.dart';
import '../models/search_employee_model.dart';
import '../models/update_employee_model.dart';

abstract class EmployeeRepo {
  Future<EmployeesPage> fetchAll({int page = 1});
  Future<List<Employee>> search(String query);
  Future<EmployeeDetail> fetchById(int id);
  Future<Either<Failure, CreateEmployeeModel>> fetchCreateEmployee({
    required String name,
    required String email,
    required String phone,
    required String birthday,
    required String gender,
    required String role,
    Uint8List? photoBytes,
  });

  Future<void> delete(int id);

  Future<Either<Failure, UpdateEmployeeModel>> fetchUpdateEmployee({
    required int      id,
    String?           name,
    Uint8List?        photoBytes,
  });
  Future<Either<Failure, RegisterSecretaryModel>> registerSecretary({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required String gender,
    Uint8List? photoBytes,
  });
  Future<Either<Failure, SearchEmployeeModel>> fetchSearchEmployee({
    required String querySearch,
    required int page,
  });
}

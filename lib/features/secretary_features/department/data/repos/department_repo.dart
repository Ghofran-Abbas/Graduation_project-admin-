import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/departments_model.dart';
import '../models/details_department_model.dart';

abstract class DepartmentRepo {

  Future<Either<Failure, DepartmentsModel>> fetchDepartments({required int page});

  Future<Either<Failure, DetailsDepartmentModel>> fetchDetailsDepartment({
    required int id,
  });
}
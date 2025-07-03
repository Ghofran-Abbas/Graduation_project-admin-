
import '../models/secretary_point_model.dart';
import '../models/student_point_model.dart';

abstract class PointsRepo {
  /// Fetch the top [limit] students by points
  Future<List<StudentPoint>> fetchTopStudents({int limit = 10});

  /// Update a single student's points
  Future<StudentPoint> updatePoints({
    required int studentId,
    required int points,
  });

  /// Fetch the top [limit] secretaries by points
  Future<List<SecretaryPoint>> fetchTopSecretaries({int limit = 10});

  /// Update a single secretary's points
  Future<SecretaryPoint> updateSecretaryPoints({
    required int secretaryId,
    required int points,
  });

}

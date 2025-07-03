// lib/features/gifts/data/repos/gift_repo.dart

import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/gift_model.dart';

abstract class GiftRepo {
  Future<GiftsPage> fetchAll({
    int? studentId,
    int? secretaryId,
    int page = 1,
  });
  Future<Gift> fetchById(int id);
  Future<Either<Failure, Gift>> create({
    required String description,
    required DateTime date,
    int? studentId,
    int? secretaryId,
    Uint8List? photoBytes,
  });
  /// Added studentId & secretaryId here as well
  Future<Either<Failure, Gift>> update({
    required int id,
    String? description,
    DateTime? date,
    int? studentId,
    int? secretaryId,
    Uint8List? photoBytes,
  });
  Future<Either<Failure, Unit>> delete(int id);
}

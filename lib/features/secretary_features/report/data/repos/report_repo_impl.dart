import 'dart:developer';
import 'dart:typed_data';

import 'package:admin_alhadara_dashboard/features/secretary_features/report/data/models/delete_report_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/create_report_model.dart';
import '../models/details_report_model.dart';
import '../models/reports_model.dart';
import '../models/update_report_model.dart';
import 'report_repo.dart';

class ReportRepoImpl extends ReportRepo {
  final DioApiService dioApiService;

  ReportRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, ReportsModel>> fetchReports({required int page}) async {
    try {
      var data = await dioApiService.get(
        endPoint: '/admin/reports/?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      ReportsModel reportsModel;
      reportsModel = ReportsModel.fromJson(data);

      return right(reportsModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateReportModel>> fetchCreateReport({
    required String name,
    required String description,
    required String fileName,
    required Uint8List file,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "description": description,
        "file": MultipartFile.fromBytes(
          file,
          filename: fileName,
        ),
      });

      var data = await dioApiService.postWithImage(
          endPoint: '/secretary/reports',
          data: formData,
          token: await SharedPreferencesHelper.getJwtToken(),
    );
    log(data.toString());
    CreateReportModel createReportModel;
    createReportModel = CreateReportModel.fromJson(data);

    return right(createReportModel);

    } catch(e) {
    if (e is DioException){
    return left(ServerFailure.fromDioError(e),);
    }
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsReportModel>> fetchDetailsReport({required int id}) async {
    try {
      var data = await dioApiService.get(
        endPoint: '/admin/reports/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      DetailsReportModel detailsReportModel;
      detailsReportModel = DetailsReportModel.fromJson(data);

      return right(detailsReportModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateReportModel>> fetchUpdateReport({
    required int id,
    String? name,
    String? description,
    String? fileName,
    Uint8List? file,
  }) async {
    try {
      final Map<String, dynamic> dataMap = {};

      if (name != null && name.trim().isNotEmpty) {
        dataMap['name'] = name;
      }

      if (description != null && description.trim().isNotEmpty) {
        dataMap['description'] = description;
      }

      if (file != null) {
        dataMap['file'] = MultipartFile.fromBytes(
          file,
          filename: fileName,
        );
      }

      if (dataMap.isEmpty) {
        return left(ServerFailure('يجب تعديل حقل واحد على الأقل قبل الإرسال.'));
      }

      final formData = FormData.fromMap(dataMap);

      var data = await dioApiService.postWithImage(
        endPoint: '/secretary/reports/$id',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      UpdateReportModel updateReportModel;
      updateReportModel = UpdateReportModel.fromJson(data);

      return right(updateReportModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteReportModel>> fetchDeleteReport({required int id}) async {
    try {
      var data = await (dioApiService.delete(
        endPoint: '/admin/reports/$id',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteReportModel deleteReportModel;
      deleteReportModel = DeleteReportModel.fromJson(data);

      return right(deleteReportModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
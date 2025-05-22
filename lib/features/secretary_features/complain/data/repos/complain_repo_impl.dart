import 'dart:developer';

import 'package:admin_alhadara_dashboard/features/secretary_features/complain/data/models/search_complain_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../constants.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/complains_model.dart';
import '../models/delete_complain_model.dart';
import '../models/details_complain_model.dart';
import 'complain_repo.dart';

class ComplainRepoImpl extends ComplainRepo {
  final DioApiService dioApiService;

  ComplainRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, ComplainsModel>> fetchComplains({required int page}) async {
    try {
      var data = await dioApiService.get(
        endPoint: '/admin/complaints/?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      ComplainsModel complainsModel;
      complainsModel = ComplainsModel.fromJson(data);

      return right(complainsModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsComplainModel>> fetchDetailsComplain({required int id}) async {
    try {
      var data = await dioApiService.get(
        endPoint: '/admin/complaints/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      DetailsComplainModel detailsComplainModel;
      detailsComplainModel = DetailsComplainModel.fromJson(data);

      return right(detailsComplainModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteComplainModel>> fetchDeleteComplain({required int id}) async {
    try {
      var data = await (dioApiService.delete(
        endPoint: '/admin/complaints/$id',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteComplainModel deleteComplainModel;
      deleteComplainModel = DeleteComplainModel.fromJson(data);

      return right(deleteComplainModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchComplainModel>> fetchSearchComplain({required String querySearch, required int page}) async {
    try {
      log(querySearch);
      var data = await (dioApiService.get(
        endPoint: '/admin/complaints?$querySearch?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SearchComplainModel searchComplainModel;
      searchComplainModel = SearchComplainModel.fromJson(data);

      return right(searchComplainModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
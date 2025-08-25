import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../constants.dart';

class DioApiService
{
  final _baseUrl = "http://127.0.0.1:8000/api";
  final Dio _dio;

  DioApiService(this._dio);

  Future<dynamic> get({
  required String endPoint,
  String? token=Constants.adminToken,
}) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.get(
        '$_baseUrl$endPoint',
    );

    return response.data;
}

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token=Constants.adminToken,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
    );

    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token=Constants.adminToken,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: data,
    );

    return response.data;
  }

  Future<dynamic> delete({
    required String endPoint,
    required Map<String, dynamic>? data,
    String? token=Constants.adminToken,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
    );

    return response.data;
  }


  Future<dynamic> postWithImage({
    required String endPoint,
    required FormData data,
    String? token = Constants.adminToken,
  }) async {
    final url = '$_baseUrl$endPoint';
    debugPrint(
        '📡 POST (image) → $url\n'
            '   fields: ${data.fields.map((e) => e.key).toList()}\n'
            '   files:  ${data.files.map((e)  => e.key).toList()}'
    );
    _dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'multipart/form-data',
      'Accept': 'application/json',


    };
    final response = await _dio.post(url, data: data);
    debugPrint('✅ POST (image) [${response.statusCode}] → ${response.data}');
    return response.data;
  }

  Future<Response> getFile({
    required String endPoint,
  }) async {
    return await _dio.get(
      endPoint,
      options: Options(responseType: ResponseType.bytes),
    );
  }

}


import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_leap_request/implementation/utils.dart';
import 'package:flutter_leap_request/interface/dio_client_interface.dart';
import 'package:flutter_leap_request/model/api_failure_model.dart';
import 'package:flutter_leap_request/model/request_model.dart';
import 'package:flutter_leap_request/model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_leap_request/utils/enums.dart';

class DioClientImpl implements DioClientInterface {
  @override
  String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Dio? _dioClient;

  @override
  Future<Either<ApiFailure, HttpResponse>> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    List<int> retryStatusCodes = const [],
    int maxRetryAttempts = 0,
  }) async {
    log("Calling mehod DELETE =>$path");
    var request = mountRequest(
      HttpMethods.delete,
      baseUrl,
      path,
      queryParams: queryParams,
      headers: headers,
      maxRetryAttempts: maxRetryAttempts,
    );
    return await makeRequest(request, maxRetryAttempts);
  }

  @override
  Future<Either<ApiFailure, HttpResponse>> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    int maxRetryAttempts = 0,
  }) async {
    log("Calling mehod GET =>$path");
    var request = mountRequest(
      HttpMethods.get,
      baseUrl,
      path,
      queryParams: queryParams,
      headers: headers,
      maxRetryAttempts: maxRetryAttempts,
    );
    return await makeRequest(request, maxRetryAttempts);
  }

  @override
  Future<Either<ApiFailure, HttpResponse>> patch(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      int maxRetryAttempts = 0}) async {
    log("Calling mehod PATCH =>$path");
    var request = mountRequest(
      HttpMethods.patch,
      baseUrl,
      path,
      queryParams: queryParams,
      headers: headers,
      maxRetryAttempts: maxRetryAttempts,
      body: body,
    );
    return await makeRequest(request, maxRetryAttempts);
  }

  @override
  Future<Either<ApiFailure, HttpResponse>> post(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      int maxRetryAttempts = 0}) async {
    log("Calling mehod POST =>$path");
    var request = mountRequest(
      HttpMethods.post,
      baseUrl,
      path,
      queryParams: queryParams,
      headers: headers,
      maxRetryAttempts: maxRetryAttempts,
      body: body,
    );
    return await makeRequest(request, maxRetryAttempts);
  }

  @override
  Future<Either<ApiFailure, HttpResponse>> put(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      int maxRetryAttempts = 0}) async {
    log("Calling mehod PUT =>$path");
    var request = mountRequest(
      HttpMethods.put,
      baseUrl,
      path,
      queryParams: queryParams,
      headers: headers,
      maxRetryAttempts: maxRetryAttempts,
      body: body,
    );
    return await makeRequest(request, maxRetryAttempts);
  }

  Future<Either<ApiFailure, HttpResponse>> makeRequest(
    Request request,
    int maxAttempts,
  ) async {
    logRequest(
      baseUrl,
      request.path,
      request.queryParameters,
      request.body,
      request.headers,
    );

    final client = _dioClient ?? await _getDioClient();
    int retryAttempts = 0;
    Response response;
    do {
      response = await client.fetch(
        RequestOptions(
          method: request.method,
          baseUrl: baseUrl,
          path: request.path,
          queryParameters: request.queryParameters,
          headers: request.headers,
          data: request.body,
        ),
      );
    } while (retryAttempts <= maxAttempts);

    if (!validStatusCodes.contains(response.statusCode)) {
      var error = ApiFailure(
        code: response.statusCode ?? 0,
        response: response,
        message: response.statusMessage,
      );
      log(error.toString());
      return Left(error);
    } else {
      var success = HttpResponse(
        response.statusCode ?? 0,
        response.data,
      );
      log(success.toString());
      return Right(success);
    }
  }

  Future<Dio> _getDioClient() async {
    var dioInterface = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ));

    return dioInterface;
  }
}

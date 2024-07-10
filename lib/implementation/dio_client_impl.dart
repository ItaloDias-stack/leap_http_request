import 'dart:developer';

//import 'package:dartz/dartz.dart';
import 'package:leap_http_request/data/result.dart';
import 'package:leap_http_request/implementation/utils.dart';
import 'package:leap_http_request/interface/dio_client_interface.dart';
import 'package:leap_http_request/model/api_failure_model.dart';
import 'package:leap_http_request/model/request_model.dart';
import 'package:leap_http_request/model/response_model.dart';
import 'package:dio/dio.dart';
import 'package:leap_http_request/utils/enums.dart';

class DioClientImpl implements DioClientInterface {
  @override
  String baseUrl;

  Dio? _dioClient;
  DioClientImpl(this.baseUrl);
  @override
  ApiResult<ApiFailure, HttpResponse> delete(
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
  ApiResult<ApiFailure, HttpResponse> get(
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
  ApiResult<ApiFailure, HttpResponse> patch(String path,
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
  ApiResult<ApiFailure, HttpResponse> post(String path,
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
  ApiResult<ApiFailure, HttpResponse> put(String path,
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

  ApiResult<ApiFailure, HttpResponse> makeRequest(
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
    try {
      Response response;
      //do {
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
      //} while (retryAttempts <= maxAttempts);

      if (!validStatusCodes.contains(response.statusCode)) {
        var error = ApiFailure(
          code: response.statusCode ?? 0,
          response: response,
          message: response.statusMessage,
        );
        log(error.toString());
        return Result.failure(error);
      } else {
        var success = HttpResponse(
          response.statusCode ?? 0,
          response.data,
        );
        log(success.toString());
        return Result.success(success);
      }
    } on DioException catch (e) {
      var error = ApiFailure(
        code: e.response?.statusCode ?? 0,
        response: e.response,
        message: e.message,
      );
      log(error.toString());
      return Result.failure(error);
    } catch (e, s) {
      var error = ApiFailure(
        code: 0,
        message: e.toString(),
      );
      log("${error.toString()} $s");
      return Result.failure(error);
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

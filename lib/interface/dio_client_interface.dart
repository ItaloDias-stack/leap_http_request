import 'package:dartz/dartz.dart';
import 'package:leap_http_request/model/api_failure_model.dart';
import 'package:leap_http_request/model/response_model.dart';

abstract class DioClientInterface {
  final String baseUrl;
  DioClientInterface(this.baseUrl);

  Future<Either<ApiFailure, HttpResponse>> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    int maxRetryAttempts = 0,
  });

  Future<Either<ApiFailure, HttpResponse>> post(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    int maxRetryAttempts = 0,
  });

  Future<Either<ApiFailure, HttpResponse>> put(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    int maxRetryAttempts = 0,
  });

  Future<Either<ApiFailure, HttpResponse>> patch(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    int maxRetryAttempts = 0,
  });

  Future<Either<ApiFailure, HttpResponse>> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    int maxRetryAttempts = 0,
  });
}

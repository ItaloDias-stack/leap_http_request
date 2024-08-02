//import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:leap_http_request/data/result.dart';
import 'package:leap_http_request/model/api_failure_model.dart';
import 'package:leap_http_request/model/response_model.dart';

abstract class HttpClientInterface {
  final String baseUrl;
  final Function(
    RequestOptions,
    RequestInterceptorHandler,
  )? onRequest;

  final Function(
    DioException,
    ErrorInterceptorHandler,
  )? onError;

  HttpClientInterface(
    this.baseUrl, {
    this.onError,
    this.onRequest,
  });

  ApiResult<ApiFailure, HttpResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    int maxRetryAttempts = 0,
  });

  ApiResult<ApiFailure, HttpResponse> post(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    int maxRetryAttempts = 0,
  });

  ApiResult<ApiFailure, HttpResponse> put(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    int maxRetryAttempts = 0,
  });

  ApiResult<ApiFailure, HttpResponse> patch(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    int maxRetryAttempts = 0,
  });

  ApiResult<ApiFailure, HttpResponse> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    int maxRetryAttempts = 0,
  });
}

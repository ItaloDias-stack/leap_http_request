import 'dart:developer';

import 'package:leap_http_request/model/request_model.dart';
import 'package:leap_http_request/utils/enums.dart';

const validStatusCodes = [200, 201];
Request mountRequest(
  HttpMethods httpMethod,
  String baseUrl,
  String path, {
  Map<String, dynamic>? queryParams,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
  int maxRetryAttempts = 0,
}) {
  final uri = Uri.parse('$baseUrl$path').replace(queryParameters: queryParams);
  final finalHeaders = headers ?? {};
  return Request(
    method: httpMethod.method,
    path: path,
    uri: uri,
    date: DateTime.now(),
    headers: finalHeaders,
    body: body,
    queryParameters: queryParams,
  );
}

void logRequest(
  baseUrl,
  path,
  queryParams,
  body,
  headers,
) {
  final request = {
    'baseUrl': baseUrl,
    'path': path,
    'query': queryParams,
    'body': body,
    'headers': headers,
  };
  log('Request: $request');
}

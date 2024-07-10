import 'package:leap_http_request/model/api_failure_model.dart';

class Result<ApiFailure, T> {
  final ApiFailure? _error;
  final T? _data;
  const Result._(this._error, this._data);

  T? get data => _data;
  ApiFailure? get failure => _error;
  bool get isSuccess => _data != null;
  bool get isFailure => _error != null;
  factory Result.failure(ApiFailure error) {
    return Result._(error, null);
  }

  factory Result.success(T data) {
    return Result._(null, data);
  }
}

typedef ApiResult<E extends ApiFailure, T> = Future<Result<E, T>>;

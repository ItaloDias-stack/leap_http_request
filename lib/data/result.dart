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

  dynamic when({
    required Function(ApiFailure error) failure,
    required Function(T) success,
  }) {
    if (isFailure && _error != null) {
      return failure(_error);
    } else if (isSuccess && _data != null) {
      return success(_data);
    } else {
      return null;
    }
  }
}

typedef ApiResult<E extends ApiFailure, T> = Future<Result<E, T>>;

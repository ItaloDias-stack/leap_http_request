// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:leap_http_request/utils/api_failure.dart';
// import 'package:leap_http_request/utils/authentication.dart';

// class DioConfig {
//   static final DioConfig _instance = DioConfig.internal();

//   factory DioConfig() => _instance;

//   DioConfig.internal();

//   final String _baseUrl = dotenv.env['BASE_URL'] ?? "";

//   Dio? _dio;

//   CustomInterceptors? _customInterceptors;
// }

// class CustomInterceptors extends InterceptorsWrapper {
//   final Dio? dio;

//   CustomInterceptors(this.dio);

//   @override
//   Future onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final auth = await Authentication.authenticated();
//     if (auth) {
//       final token = await Authentication.getToken();
//       options.headers["Authorization"] = "Bearer $token";
//     }
//     options.headers["Accept"] = "application/json";
//     return super.onRequest(options, handler);
//   }

//   @override
//   Future<ApiFailure> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     switch (err.response?.statusCode) {
//       case 401:
//         return DioErrorHelper.on401(dio: dio, err: err, handler: handler);
//       default:
//         return ApiFailure(
//           code: err.response?.statusCode ?? 0,
//           response: err.response?.data,
//         );
//     }
//   }
// }

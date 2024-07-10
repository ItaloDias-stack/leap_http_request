import 'package:get_it/get_it.dart';
import 'package:leap_http_request/implementation/dio_client_impl.dart';
import 'package:leap_http_request/interface/dio_client_interface.dart';

class FlutterLeapRequestInjection {
  DioClientInterface setup(String baseUrl) {
    return GetIt.I.registerSingleton<DioClientInterface>(
      DioClientImpl(baseUrl),
    );
  }
}

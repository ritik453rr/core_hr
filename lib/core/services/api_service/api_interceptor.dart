import 'package:dio/dio.dart';
import '../../global/global.dart';
import '../../storage/app_storage.dart';

/// Interceptor that handles authorization headers and console logging for API calls.
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = AppStorage.getAuthToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    Global.logger.i(
      'REQUEST'
      '\nMETHOD:${options.method.toUpperCase()}'
      '\nURL:${options.uri}'
      '\nHEADERS:${options.headers}'
      '\nBODY: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Global.logger.i(
      'RESPONSE'
      '\nSTATUS CODE:${response.statusCode}'
      '\nURL:${response.requestOptions.uri}'
      '\nRESPONSE DATA:${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Global.logger.e(
      'ERROR'
      '\nSTATUS CODE:${err.response?.statusCode}'
      '\nURL:${err.requestOptions.uri}'
      '${err.response != null ? '\nError Data: ${err.response?.data}' : ''}',
    );
    handler.next(err);
  }
}

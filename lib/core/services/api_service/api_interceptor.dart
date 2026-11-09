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
    Global.logger.i('''
      REQUEST
      METHOD:${options.method.toUpperCase()}
      URL:${options.uri}
      HEADERS:${options.headers}
      BODY: ${options.data}''');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Global.logger.i('''
      RESPONSE
      STATUS CODE:${response.statusCode}
      URL:${response.requestOptions.uri}
      RESPONSE DATA:${response.data}
       ''');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Global.logger.e(
      '<-- ERROR ${err.response?.statusCode} ${err.requestOptions.uri}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    if (err.response != null) {
      Global.logger.e('Error Data: ${err.response?.data}');
    }
    handler.next(err);
  }
}

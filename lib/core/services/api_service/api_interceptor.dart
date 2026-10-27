import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
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
    Global.logger.i('--> ${options.method.toUpperCase()} ${options.uri}');
    Global.logger.d('Headers: ${options.headers}');
    if (options.data != null) {
      Global.logger.d('Body: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Global.logger.i(
      '<-- ${response.statusCode} ${response.requestOptions.uri}',
    );
    Global.logger.d('Response Data: ${response.data}');
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

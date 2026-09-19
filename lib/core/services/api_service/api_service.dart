import 'dart:io';
import 'package:core_hr/core/constants/app_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import '../../global/global.dart';
import '../../language/string_constants.dart';
import '../../storage/app_storage.dart';
import 'api_constants.dart';
import '../../common_model/response_model.dart';

/// A Singleton onboarding_service class that handles API requests using Dio.
class ApiService {
  // ---- Singleton Setup ----
  ApiService._internal() {
    _addAuthInterceptor();
  }

  static final ApiService _instance = ApiService._internal();

  // Public factory -> always same instance
  factory ApiService() => _instance;

  // ---- Single Dio Instance ----
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(minutes: 10),
      receiveTimeout: const Duration(minutes: 10),
      baseUrl: dotenv.env[AppKeys.apiBaseUrl] ?? "",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  /// Adds authorization token to request headers if available in local storage.
  void _addAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = AppStorage.getAuthToken();
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
        onError: (options, handler) {
          handler.next(options);
        },
      ),
    );
  }

  /// Helper to handle response status consistently
  ResponseModel _handleResponse(Response response, dynamic model) {
    // If API provides a "success" or "status" field, use it, otherwise rely on statusCode
    final dynamic responseData = response.data;
    bool isSuccess = (response.statusCode == 200 || response.statusCode == 201);
    
    if (responseData is Map && responseData.containsKey('success')) {
       isSuccess = isSuccess && (responseData['success'] == true);
    }

    return ResponseModel(
      status: isSuccess,
      data: model != null && isSuccess ? model(responseData) : responseData,
      message: responseData is Map ? (responseData['message'] ?? "") : "",
    );
  }

  /// Sends a POST request using Dio and returns a standardized ResponseModel with success, data, and error handling.
  Future<ResponseModel> postRequest({
    required String url,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic model,
    CancelToken? cancelToken,
  }) async {
    if (!await Global.checkInternet()) {
      return ResponseModel();
    }
    try {
      final response = await dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _handleResponse(response, model);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ResponseModel(status: false, message: e.toString());
    }
  }

  /// Sends a DELETE request using Dio and returns a standardized ResponseModel with success, data, and error handling.
  Future<ResponseModel> deleteRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    if (!await Global.checkInternet()) {
      return ResponseModel();
    }
    try {
      final response = await dio.delete(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response, null);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ResponseModel(status: false, message: e.toString());
    }
  }

  /// Sends a PUT request using Dio and returns a standardized ResponseModel
  Future<ResponseModel> putRequest({
    required String url,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    File? file,
    String? fileKey = 'file',
    dynamic model,
    CancelToken? cancelToken,
  }) async {
    if (!await Global.checkInternet()) {
      return ResponseModel();
    }
    try {
      dynamic payload = body;
      if (file != null) {
        final fileName = file.path.split('/').last;
        payload = FormData.fromMap({
          ...?body,
          fileKey!: await MultipartFile.fromFile(file.path, filename: fileName),
        });
      }

      final response = await dio.put(
        url,
        data: payload,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options:
            options ??
            Options(
              headers: {
                'Content-Type': file != null
                    ? 'multipart/form-data'
                    : 'application/json',
              },
            ),
      );
      return _handleResponse(response, model);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ResponseModel(status: false, message: e.toString());
    }
  }

  // ----  GET Request ----
  Future<ResponseModel> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    bool showInternetMsg = false,
    dynamic model,
  }) async {
    if (!await Global.checkInternet(showMsg: showInternetMsg)) {
      return ResponseModel();
    }
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return _handleResponse(response, model);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ResponseModel(status: false, message: e.toString());
    }
  }

  ResponseModel _handleDioError(DioException e) {
    if (CancelToken.isCancel(e)) {
      return ResponseModel();
    }
    if (e.response != null) {
      final data = e.response!.data;
      final defaultMsg = ApiConstants.getApiErrorMsg(e.response!.statusCode);
      return ResponseModel(
        status: false,
        message: data is Map ? (data["message"] ?? defaultMsg) : defaultMsg,
        data: data,
      );
    } else {
      return ResponseModel(
        status: false,
        message: StringConstants.kServerNotFound.tr,
      );
    }
  }
}

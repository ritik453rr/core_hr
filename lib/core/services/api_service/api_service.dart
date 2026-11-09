import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../constants/app_keys.dart';
import 'api_interceptor.dart';
import '../../global/global.dart';
import 'api_response_model.dart';

/// A Singleton onboarding_service class that handles API requests using Dio.
class ApiService {
  // ---- Singleton Setup ----
  ApiService._internal() {
    dio.interceptors.add(ApiInterceptor());
  }

  static final ApiService _instance = ApiService._internal();

  // Public factory -> always same instance
  factory ApiService() => _instance;

  // ---- Single Dio Instance ----
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppKeys.apiBaseUrl,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  /// Helper to handle response status consistently
  ApiResponseModel _handleResponse(Response response, dynamic model) {
    final dynamic responseData = response.data;
    final bool isSuccess =
        (response.statusCode == 200 || response.statusCode == 201);

    if (isSuccess) {
      final successMsg = responseData is Map
          ? (responseData['message'] ?? "")
          : "";
      return ApiResponseModel(
        status: true,
        data: model != null ? model(jsonEncode(responseData)) : responseData,
        message: successMsg,
      );
    } else {
      final errorMsg = responseData is Map
          ? (responseData['message'] ?? "Something went wrong")
          : "Something went wrong";
      return ApiResponseModel(message: errorMsg);
    }
  }

  ApiResponseModel _handleDioError(DioException e) {
    if (CancelToken.isCancel(e)) {
      return ApiResponseModel();
    }
    if (e.response != null) {
      final data = e.response!.data;
      final errorMsg = data is Map
          ? (data["message"] ?? "Something went wrong")
          : "Something went wrong";
      return ApiResponseModel(message: errorMsg);
    } else {
      return ApiResponseModel(message: "Something went wrong");
    }
  }

  /// Sends a POST request using Dio and returns a standardized ResponseModel with success, data, and error handling.
  Future<ApiResponseModel> postRequest({
    required String endpoint,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    File? file,
    String? fileKey = 'file',
    dynamic model,
  }) async {
    if (!await Global.checkInternet()) {
      return ApiResponseModel();
    }
    try {
      dynamic payload = body;
      if (file != null) {
        final fileName = file.path.split('/').last;
        final Map<String, dynamic> mapData = {
          ...?body,
          fileKey ?? 'file': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        };
        payload = FormData.fromMap(mapData);
      }
      final response = await dio.post(
        endpoint,
        data: payload,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response, model);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponseModel(message: e.toString());
    }
  }

  // ----  GET Request ----
  Future<ApiResponseModel> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    dynamic model,
  }) async {
    if (!await Global.checkInternet()) {
      return ApiResponseModel();
    }
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, model);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponseModel(message: e.toString());
    }
  }
}

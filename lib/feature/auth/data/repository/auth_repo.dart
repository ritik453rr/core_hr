import 'package:core_hr/core/common_model/user_profile_model.dart';
import 'package:core_hr/core/services/api_service/api_service.dart';
import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/services/api_service/api_endpoints.dart';
import 'package:core_hr/feature/auth/data/model/login_model.dart';

/// Repository class for handling authentication-related data operations.
class AuthRepo {
  var apiService = ApiService();

  /// Sends a login request to the server with the provided credentials.
  Future<ResponseModel> login({dynamic body}) async {
    final ResponseModel responseModel = await apiService.postRequest(
      endpoint: ApiEndPoints.login,
      body: body,
      model: loginModelFromJson,
    );
    return responseModel;
  }

  /// Sends a logout request to the server.
  Future<ResponseModel> logout() async {
    final ResponseModel resModel = await apiService.postRequest(
      endpoint: ApiEndPoints.logout,
    );
    return resModel;
  }

  /// Fetches the user profile from the server.
  Future<ResponseModel> getUserProfile() async {
    final ResponseModel resModel = await apiService.getRequest(
      url: ApiEndPoints.profile,
      model: userProfileModelFromJson,
      showInternetMsg: true
    );
    return resModel;
  }
}

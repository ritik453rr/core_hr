import 'package:core_hr/core/services/api_service/api_service.dart';
import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/services/api_service/api_urls.dart';
import 'package:core_hr/feature/auth/data/model/login_model.dart';

/// Repository class for handling authentication-related data operations.
class AuthRepo {
  var apiService = ApiService();

  /// Sends a login request to the server with the provided credentials.
  Future<ResponseModel> login({dynamic body}) async {
    final ResponseModel responseModel = await apiService.postRequest(
      url: ApiEndPoints.login,
      body: body,
      model: loginModelFromJson,
    );
    return responseModel;
  }
}

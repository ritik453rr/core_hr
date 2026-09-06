import 'package:core_hr/core/services/api_service/api_service.dart';
import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/services/api_service/api_urls.dart';
import 'package:core_hr/feature/auth/data/model/login_model.dart';

class AuthRepo {
  var apiService = ApiService();

  Future<ResponseModel> login({dynamic body}) async {
    final ResponseModel responseModel = await apiService.postRequest(
      url: ApiEndPoints.login,
      body: body,
      model: loginModelFromJson,
    );
    return responseModel;
  }
}

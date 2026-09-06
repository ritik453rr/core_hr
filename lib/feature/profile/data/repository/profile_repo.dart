import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/services/api_service/api_service.dart';
import 'package:core_hr/core/services/api_service/api_urls.dart';

class ProfileRepo {
  var apiService = ApiService();

  Future<ResponseModel> logoutRequest() async {
    final ResponseModel resModel = await apiService.postRequest(
      url: ApiEndPoints.logout,
    );
    return resModel;
  }
}

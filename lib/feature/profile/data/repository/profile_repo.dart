import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/common_model/user_profile_model.dart';
import 'package:core_hr/core/services/api_service/api_endpoints.dart';
import 'package:core_hr/core/services/api_service/api_service.dart';
import '../entity/update_profile_entity.dart';

/// Repository for managing user profile API operations.
class ProfileRepo {
  var apiService = ApiService();

  /// Updates user profile details via POST request.
  Future<ApiResponseModel> updateProfile(UpdateProfileEntity entity) async {
    final ApiResponseModel responseModel = await apiService.postRequest(
      endpoint: ApiEndPoints.profileUpdate,
      body: entity.toJson(),
      file: entity.profilePhoto,
      fileKey: 'profile_photo',
      model: userProfileModelFromJson,
    );
    return responseModel;
  }
}

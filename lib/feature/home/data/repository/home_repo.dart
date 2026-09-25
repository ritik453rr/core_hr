import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/services/api_service/api_service.dart';
import 'package:core_hr/core/services/api_service/api_endpoints.dart';
import 'package:core_hr/feature/home/data/entity/check_in_entity.dart';

/// Repository for handling home and attendance-related API operations.
class HomeRepo {
  var apiService = ApiService();

  /// Sends a check-in or check-out request with the user's location details.
  Future<ResponseModel> checkInCheckOut({
    required CheckInEntity entity,
    required bool checkIn,
  }) async {
    final ResponseModel responseModel = await apiService.postRequest(
      endpoint: checkIn ? ApiEndPoints.checkIn : ApiEndPoints.checkOut,
      body: entity.toJson(),
    );
    return responseModel;
  }
}

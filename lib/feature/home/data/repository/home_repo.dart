import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/services/api_service/api_service.dart';
import 'package:core_hr/core/services/api_service/api_urls.dart';
import 'package:core_hr/feature/home/data/entity/check_in_entity.dart';

/// Repository for handling home and attendance-related API operations.
class HomeRepo {
  var apiService = ApiService();

  /// Sends a check-in or check-out request with the user's location details.
  Future<ResponseModel> checkInCheckOut({
    required CheckInEntity entity,
    bool isCheckIn = true,
  }) async {
    final ResponseModel responseModel = await apiService.postRequest(
      endpoint: isCheckIn ? ApiEndPoints.checkOut : ApiEndPoints.checkIn,
      body: entity.toJson(),
    );
    return responseModel;
  }
}

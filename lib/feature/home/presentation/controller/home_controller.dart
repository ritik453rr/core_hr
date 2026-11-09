import 'package:core_hr/core/services/location_service/location_tracking_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:core_hr/core/services/location_service/location_service.dart';
import 'package:core_hr/feature/home/data/entity/check_in_entity.dart';
import 'package:core_hr/feature/home/data/repository/home_repo.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/services/api_service/api_response_model.dart';
import '../../../../core/common_widgets/app_toast.dart';

enum HomeBuilderIds { clockInCard, homeAppBar }

/// Controller for managing home page state and consolidated attendance logic.
class HomeController extends GetxController {
  // Instances.......
  final _homeRepo = HomeRepo();

  // Variables
  bool isCheckIn = false;
  bool isClockInLoading = false;

  /// Performs the check-in or check-out operation via the repository.
  Future<void> toggleClockIn() async {
    if(isClockInLoading) return;
    isClockInLoading = true;
    update([HomeBuilderIds.clockInCard]);
    final position = await LocationService.getCurrentPosition();
    if (position == null) {
      AppToast.showToast(message: 'Unable to fetch your current location.');
      return;
    }
    final checkInEntity = CheckInEntity(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    final ApiResponseModel responseModel = await _homeRepo.checkInCheckOut(
      entity: checkInEntity,
      checkIn: !isCheckIn,
    );
    if (responseModel.status) {
      isCheckIn = !isCheckIn;
      if(isCheckIn){
        LocationTrackingService.instance.startTracking();
      }else{
        LocationTrackingService.instance.stopTracking();

      }
    } else {
      AppToast.showToast(message: responseModel.message);
    }
    isClockInLoading = false;
    update([HomeBuilderIds.clockInCard]);
  }

  /// Handles tap on HR service modules.
  void onTapService(String serviceName) {
    AppToast.showToast(
      message: '$serviceName module integration coming soon.',
      isSuccess: true,
    );
  }
}

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:core_hr/core/services/location_service/location_service.dart';
import 'package:core_hr/feature/home/data/entity/check_in_entity.dart';
import 'package:core_hr/feature/home/data/repository/home_repo.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/common_model/response_model.dart';
import '../../../../core/common_widgets/app_toast.dart';

enum HomeBuilderIds { clockInCard, homeAppBar }

/// Controller for managing home page state and consolidated attendance logic.
class HomeController extends GetxController {
  // Instances.......
  final _homeRepo = HomeRepo();
  Position? _position;

  // Variables
  bool isCheckIn = false;
  bool isLoadingLatLong = false;
  bool isClockInLoading = false;
  String currentAddress = '';

  @override
  void onInit() {
    super.onInit();
    getUserAddress();
  }

  /// Fetches the current latitude, longitude, and address.
  Future<void> getUserAddress() async {
    isLoadingLatLong = true;
    update([HomeBuilderIds.clockInCard]);

    _position = await LocationService.getCurrentPosition();

    if (_position == null) {
      isLoadingLatLong = false;
      update([HomeBuilderIds.clockInCard]);
      return;
    }

    final latitude = _position!.latitude;
    final longitude = _position!.longitude;

    final Placemark? place = await LocationService.getPlacemark(
      latitude: latitude,
      longitude: longitude,
    );

    if (place != null) {
      currentAddress =
          [place.street, place.subLocality, place.postalCode, place.country]
              .where((value) {
                return value != null && value.trim().isNotEmpty;
              })
              .join(', ');
    }

    isLoadingLatLong = false;
    update([HomeBuilderIds.clockInCard]);
  }

  void onTapProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  /// Toggles the clock-in status.
  Future<void> toggleClockIn() async {
    if (_position == null) {
      AppToast.showToast(message: 'Unable to fetch your current location.');
      return;
    }

    checkIn();
  }

  /// Performs the check-in or check-out operation via the repository.
  Future<void> checkIn() async {
    isClockInLoading = true;
    update([HomeBuilderIds.clockInCard]);
    final checkInEntity = CheckInEntity(
      latitude: _position!.latitude,
      longitude: _position!.longitude,
      address: currentAddress,
    );
    final ResponseModel responseModel = await _homeRepo.checkInCheckOut(
      entity: checkInEntity,
      checkIn: !isCheckIn,
    );
    if (responseModel.status) {
      isCheckIn = !isCheckIn;
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

  Future<void> refreshHomePage() async {
    await Future.delayed(const Duration(seconds: 5));
  }
}

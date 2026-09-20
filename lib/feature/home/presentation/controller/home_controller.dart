import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:core_hr/core/services/location_service/location_service.dart';
import 'package:core_hr/feature/home/data/entity/check_in_entity.dart';
import 'package:core_hr/feature/home/data/repository/home_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/common_model/response_model.dart';
import '../../../../core/common_widgets/app_toast.dart';

enum HomeBuilderIds { clockIn }

/// Controller for managing home page state and consolidated attendance logic.
class HomeController extends GetxController {
  // Instances.......
  final _geocoding = Geocoding();
  final _homeRepo = HomeRepo();
  Position? _position;

  // Consolidated Attendance State
  bool isCheckIn = false;
  bool isLoadingLatLong = false;
  bool isClockInLoading = false;

  String currentLatLong = 'Unknown';
  String currentAddress = 'Unknown';

  @override
  void onInit() {
    super.onInit();
    getLatLang();
  }

  /// Fetches the current latitude, longitude, and address.
  Future<void> getLatLang() async {
    isLoadingLatLong = true;
    update([HomeBuilderIds.clockIn]);

    try {
      _position = await LocationService.getCurrentPosition();

      if (_position == null) {
        return;
      }

      final latitude = _position!.latitude;
      final longitude = _position!.longitude;

      // Convert fetched coordinates into address.
      final List<Placemark> placemarks = await _geocoding
          .placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        currentAddress = [
          place.street,
          place.subLocality,
          place.postalCode,
          place.country,
        ].where((value) => value != null && value.trim().isNotEmpty).join(', ');
      }
    } catch (e) {
      debugPrint('Location error: $e');
      AppToast.showToast(message: e.toString());
    } finally {
      isLoadingLatLong = false;
      update([HomeBuilderIds.clockIn]);
    }
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

    checkInCheckOut();
  }

  /// Performs the check-in or check-out operation via the repository.
  Future<void> checkInCheckOut() async {
    isClockInLoading = true;
    update([HomeBuilderIds.clockIn]);
    final checkInEntity = CheckInEntity(
      latitude: _position!.latitude,
      longitude: _position!.longitude,
      address: currentAddress,
    );
    final ResponseModel responseModel = await _homeRepo.checkInCheckOut(
      entity: checkInEntity,
      isCheckIn: isCheckIn,
    );
    if (responseModel.status) {
      isCheckIn = !isCheckIn;
    } else {
      AppToast.showToast(message: responseModel.message);
    }
    isClockInLoading = false;
    update([HomeBuilderIds.clockIn]);
  }

  /// Handles tap on HR service modules.
  void onTapService(String serviceName) {
    AppToast.showToast(
      message: '$serviceName module integration coming soon.',
      isSuccess: true,
    );
  }

  Future<void> refreshHomePage() async{
    await Future.delayed(const Duration(seconds: 5));
  }
}

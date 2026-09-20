import 'package:get/get.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'dart:async';
import 'package:core_hr/core/storage/app_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigation();
  }

  void navigation() {
    Future.delayed(const Duration(seconds: 2), () {
      final isLoggedIn = AppStorage.getLoginStatus();
      Get.offAllNamed(isLoggedIn ? AppRoutes.dashboard : AppRoutes.login);
    });
  }
}

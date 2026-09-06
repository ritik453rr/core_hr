import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/core/storage/app_storage.dart';

class SplashController extends GetxController { 
  @override
  void onInit() {
    super.onInit();
    navigation();
  }

  void navigation() {
    Future.delayed(const Duration(seconds: 2), () {
      final loginStatus = AppStorage.getLoginStatus();
      Get.offAllNamed(loginStatus ? AppRoutes.dashboard : AppRoutes.login);
    });
  }
}

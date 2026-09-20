import 'package:core_hr/core/common_model/response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:core_hr/core/storage/app_storage.dart';
import 'package:core_hr/feature/auth/data/entity/login_entity.dart';
import 'package:core_hr/feature/auth/data/model/login_model.dart';
import 'package:core_hr/feature/auth/data/repository/auth_repo.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/common_widgets/app_toast.dart';

/// IDs used for selective GetBuilder updates in Auth flow.
enum AuthBuilderIds { passwordVisibility, loginLoadingOverlay }

/// Unified AuthController managing Login and Forgot Password flows.
class AuthController extends GetxController {
  // Controllers.............
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Instances
  var authRepo = AuthRepo();
  final loginFormKey = GlobalKey<FormState>();

  // Variables
  var obscurePassword = true;
  var isLogging = false;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      loginEmailController.text = "Ashishyadav@shreebhargavifoundation.com";
      // loginPasswordController.text = "Test@12345";
    }
  }



  // --- LOGIN METHODS ---
  void togglePasswordVisibility() {
    AppConstants.hapticFeedBack();
    obscurePassword = !obscurePassword;
    update([AuthBuilderIds.passwordVisibility]);
  }

  /// Validates the login form and returns whether all fields are valid.
  bool isLoginPageValid() {
    if (loginFormKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  /// Authenticates the user with current credentials and redirects to the dashboard on success.
  Future<void> onTapLogin() async {
    if (isLoginPageValid()) {
      isLogging = true;
      update([AuthBuilderIds.loginLoadingOverlay]);
      final loginEntity = LoginEntity(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim(),
      );
      final ResponseModel resModel = await authRepo.login(
        body: loginEntity.toJson(),
      );
      if (resModel.status) {
        final LoginModel loginModel = resModel.data;
        AppStorage.saveAuthToken(loginModel.token ?? "");
        AppStorage.saveUserProfile(loginModel.user);
        AppStorage.saveLoginStatus(true);
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        AppToast.showToast(message: resModel.message);
      }
      isLogging = false;
      update([AuthBuilderIds.loginLoadingOverlay]);
    }
  }
}

import 'package:core_hr/core/common_model/response_model.dart';
import 'package:core_hr/core/constants/shared_imports.dart';
import 'package:core_hr/core/storage/app_storage.dart';
import 'package:core_hr/feature/auth/data/entity/login_entity.dart';
import 'package:core_hr/feature/auth/data/model/login_model.dart';
import 'package:core_hr/feature/auth/data/repository/auth_repo.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/app_validator/app_validator.dart';

/// IDs used for selective GetBuilder updates in Auth flow.
enum AuthBuilderIds { passwordVisibility, loginLoadingOverlay }

/// Unified AuthController managing Login and Forgot Password flows.
class AuthController extends GetxController {
  // Controllers.............
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Instances
  var authRepo = AuthRepo();

  // Variables
  var obscurePassword = true;
  var isLogging = false;
  var isLoginValid = false;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      loginEmailController.text = "Ashishyadav@shreebhargavifoundation.com";
      loginPasswordController.text = "Test@12345";
    }
    loginEmailController.addListener(validateLoginForm);
    loginPasswordController.addListener(validateLoginForm);
  }

  /// Validates the login form and updates the login button state.
  void validateLoginForm() {
    final email = loginEmailController.text.trim();
    final password = loginPasswordController.text;
    isLoginValid =
        AppValidator.validateEmail(email) == null &&
        AppValidator.validateRequired(password, 'Password') == null;
    update([AuthBuilderIds.loginLoadingOverlay]);
  }

  // --- LOGIN METHODS ---
  void togglePasswordVisibility() {
    AppConstants.hapticFeedBack();
    obscurePassword = !obscurePassword;
    update([AuthBuilderIds.passwordVisibility]);
  }

  /// Authenticates the user with current credentials and redirects to the dashboard on success.
  Future<void> onTapLogin() async {
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

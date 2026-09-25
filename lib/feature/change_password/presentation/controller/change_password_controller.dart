import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/api_service/api_service.dart';
import '../../../../core/services/api_service/api_endpoints.dart';
import '../../../../core/common_widgets/app_toast.dart';
import '../../data/entity/change_password_entity.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isCurrentPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void toggleCurrentPasswordVisibility() => isCurrentPasswordVisible.toggle();
  void toggleNewPasswordVisibility() => isNewPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      // Using Entity for Request
      final requestEntity = ChangePasswordEntity(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      final response = await ApiService().postRequest(
        endpoint: ApiEndPoints.changePassword,
        body: requestEntity.toJson(),
      );

      if (response.status) {
        AppToast.showToast(isSuccess: true, message: response.message);
        Get.back();
      } else {
        AppToast.showToast(isSuccess: false, message: response.message);
      }
    } catch (e) {
      AppToast.showToast(isSuccess: false, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

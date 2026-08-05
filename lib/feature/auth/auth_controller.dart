import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routing/app_routes.dart';

/// Unified AuthController managing Login and Forgot Password flows.
class AuthController extends GetxController {
  // --- LOGIN STATE & CONTROLLERS ---
  final loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final obscurePassword = true.obs;
  final isLoginLoading = false.obs;

  // --- FORGOT PASSWORD STATE & CONTROLLERS ---
  var forgotStep = 0.obs; // 0: Enter Email, 1: Verify OTP, 2: New Password
  final forgotEmailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isForgotLoading = false.obs;
  final obscureNewPassword = true.obs;
  final obscureConfirmPassword = true.obs;

  // --- LOGIN METHODS ---
  void togglePasswordVisibility() {
    AppConstants.hapticFeedBack();
    obscurePassword.value = !obscurePassword.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  Future<void> login() async {
    AppConstants.hideKeyboard();
    AppConstants.hapticFeedBack();

    isLoginLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isLoginLoading.value = false;

    Get.offAllNamed(AppRoutes.dashboard);
  }

  // --- FORGOT PASSWORD METHODS ---
  void sendOtp() async {
    final email = forgotEmailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar('Invalid Email', 'Please enter a valid work email address.', snackPosition: SnackPosition.TOP);
      return;
    }

    isForgotLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isForgotLoading.value = false;

    forgotStep.value = 1;
    Get.snackbar('OTP Sent', 'A 4-digit verification code was sent to $email.', snackPosition: SnackPosition.TOP);
  }

  void verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.length < 4) {
      Get.snackbar('Invalid OTP', 'Please enter the 4-digit verification code.', snackPosition: SnackPosition.TOP);
      return;
    }

    isForgotLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isForgotLoading.value = false;

    forgotStep.value = 2;
    Get.snackbar('OTP Verified', 'Please enter your new password.', snackPosition: SnackPosition.TOP);
  }

  void resetPassword() async {
    final pass = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    if (pass.length < 6) {
      Get.snackbar('Weak Password', 'Password must be at least 6 characters long.', snackPosition: SnackPosition.TOP);
      return;
    }

    if (pass != confirm) {
      Get.snackbar('Password Mismatch', 'New password and confirmation do not match.', snackPosition: SnackPosition.TOP);
      return;
    }

    isForgotLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isForgotLoading.value = false;

    forgotStep.value = 0;
    forgotEmailController.clear();
    otpController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

    Get.snackbar('Password Updated', 'Your password has been reset successfully. Please login.', snackPosition: SnackPosition.TOP);
    Get.offAllNamed(AppRoutes.login);
  }
}

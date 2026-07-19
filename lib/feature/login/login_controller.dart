import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/common/common_ui.dart';
import '../../core/constants/app_constants.dart';

/// Controller for managing the state and business logic of the Login page.
class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggles password visibility between obscured and visible.
  void togglePasswordVisibility() {
    AppConstants.hapticFeedBack();
    obscurePassword.value = !obscurePassword.value;
  }

  /// Validates the email format.
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

  /// Validates the password.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  /// Performs simulated login validation and request execution.
  Future<void> login() async {
    AppConstants.hideKeyboard();
    AppConstants.hapticFeedBack();

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    // Simulate API request delay
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    // Show feedback snackbar (simulating success)
    CommonUI.showApiSnackBar(
      isSuccess: true,
      message: "Welcome back! Login successful.",
    );
  }
}

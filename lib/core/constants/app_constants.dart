import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Provides const utility across the application.
class AppConstants {

  // Horizontal space used frequently in the application
  static const double hzSpace = 24.0;

  // Vertical space used frequently in the application
  static const double vtSpace = 60.0;

  // Hides the keyboard when focus is outside the text field.
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Haptic feedback for the device
  static Future<void> hapticFeedBack() {
    if (GetPlatform.isIOS) {
      return HapticFeedback.lightImpact();
    } else {
      return HapticFeedback.vibrate();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Provides const utility across the application.
class AppConstants {
  static const double hzSpace = 20.0;

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

  /// Configures the system navigation and status bar appearance based on the theme.
  static void setSafeArea({bool isDark = false}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: isDark ? Colors.black : Colors.white,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}

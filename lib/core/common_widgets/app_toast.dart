import 'package:core_hr/core/constants/app_font_size.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'app_text.dart';

/// Provides centralized toast and notification utilities.
class AppToast {
  /// Shows a styled success or error toast notification.
  static ToastificationItem? showToast({
    required String message,
    bool isSuccess = false,
  }) {
    if (message.trim().isEmpty) {
      return null;
    }

    toastification.dismissAll();

    final Color primaryColor = isSuccess ? Colors.green : Colors.red;

    return toastification.show(
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      dragToClose: true,
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      icon: Icon(
        isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
        color: primaryColor,
        size: 26,
      ),
      title: AppText(
        isSuccess ? StringConstants.kSuccess : StringConstants.kError,
        style: const TextStyle(
          fontSize: AppFontSize.font14,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: AppText(
        message,
        style: const TextStyle(
          fontSize: AppFontSize.font12,
          color: Colors.black87,
        ),
      ),
    );
  }
}

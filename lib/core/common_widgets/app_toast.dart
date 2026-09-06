import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Provides centralized toast and notification utilities.
class AppToast {
  /// Shows a success or error toast notification.
  static ToastificationItem? showToast({
    required String message,
    bool isSuccess = false,
    Alignment alignment = Alignment.topCenter,
  }) {
    if (message.trim().isEmpty) {
      return null;
    }

    toastification.dismissAll();

    return toastification.show(
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.flatColored,
      primaryColor: isSuccess ? Colors.green : Colors.red,
      autoCloseDuration: const Duration(seconds: 4),
      alignment: alignment,
      title: Text(
        isSuccess ? 'Success' : 'Error',
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
      ),
      description: Text(message, style: const TextStyle(fontSize: 12)),
      borderRadius: BorderRadius.circular(12),
      dragToClose: true,
    );
  }
}

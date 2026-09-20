import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import '../common_widgets/app_button.dart';
import '../common_widgets/app_text.dart';
import '../common_widgets/app_text_button.dart';

/// A confirmation dialog shown when a user attempts to log out.
class LogoutDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const LogoutDialog({super.key, this.onCancel, this.onConfirm});

  static Future<T?> show<T>({VoidCallback? onCancel, VoidCallback? onConfirm}) {
    return Get.dialog<T>(
      LogoutDialog(onCancel: onCancel, onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const AppText(
        StringConstants.kConfirmLogout,
        style: AppTextStyle.bold18,
      ),
      content: const AppText(
        StringConstants.kLogoutConfirmationMessage,
        style: AppTextStyle.regular14,
      ),
      actions: [
        AppTextButton(
          onPressed: onCancel ?? () => Get.back(),
          title: StringConstants.kCancel,
          style: AppTextStyle.regular14Grey,
        ),
        10.w,
        AppButton(title: StringConstants.kLogout, onPressed: onConfirm),
      ],
    );
  }
}

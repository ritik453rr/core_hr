import 'package:core_hr/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/app_text.dart';
import '../common_widgets/app_text_button.dart';
import '../constants/app_text_style.dart';
import '../extension/sized_box_extension.dart';
import '../language/string_constants.dart';

/// Displays the adaptive logout confirmation dialog.
Future<dynamic> showLogoutDialog({void Function()? onConfirm}) {
  return Get.dialog(
    AlertDialog.adaptive(
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
          title: StringConstants.kCancel,
          style: AppTextStyle.semiBold14Grey,
          onPressed: () {
            AppConstants.hapticFeedBack();
            Get.back();
          },
        ),
        10.w,
        AppTextButton(
          title: StringConstants.kLogout,
          style: AppTextStyle.semiBold14Red,
          onPressed: () {
            AppConstants.hapticFeedBack();
            Get.back();
            onConfirm?.call();
          },
        ),
      ],
    ),
  );
}

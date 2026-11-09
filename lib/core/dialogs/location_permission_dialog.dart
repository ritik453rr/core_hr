import 'package:core_hr/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../common_widgets/app_text.dart';
import '../common_widgets/app_text_button.dart';
import '../constants/app_text_style.dart';
import '../language/string_constants.dart';

/// Displays the adaptive location permission dialog prompting users to enable permanent location access in Settings.
Future<dynamic> showLocationPermissionDialog({void Function()? onOpenSettings}) {
  return Get.dialog(
    barrierDismissible: false,
    PopScope(
      canPop: false,
      child: AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const AppText(
          StringConstants.kLocationPermissionTitle,
          style: AppTextStyle.bold18,
        ),
        content: const AppText(
          StringConstants.kLocationPermissionMessage,
          style: AppTextStyle.regular14,
        ),
        actions: [
          AppTextButton(
            title: StringConstants.kOpenSettings,
            style: AppTextStyle.semiBold14Blue,
            onPressed: () async {
              AppConstants.hapticFeedBack();
              Get.back();
              openAppSettings();
              onOpenSettings?.call();
            },
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import '../common_widgets/app_text.dart';

/// Reusable bottom sheet for picking avatar image from gallery or camera.
void showAvatarPickerBottomSheet({
  required BuildContext context,
  required Function(ImageSource source) onSourceSelected,
}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppText(
            StringConstants.kSelectProfilePhoto,
            style: AppTextStyle.bold18,
          ),
          16.h,
          ListTile(
            leading: const Icon(
              Icons.photo_library_rounded,
              color: AppColors.c2563EB,
            ),
            title: const AppText(
              StringConstants.kChooseFromGallery,
              style: AppTextStyle.semiBold14,
            ),
            onTap: () {
              Get.back();
              onSourceSelected(ImageSource.gallery);
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(
              Icons.camera_alt_rounded,
              color: AppColors.c2563EB,
            ),
            title: const AppText(
              StringConstants.kTakeAPhoto,
              style: AppTextStyle.semiBold14,
            ),
            onTap: () {
              Get.back();
              onSourceSelected(ImageSource.camera);
            },
          ),
        ],
      ),
    ),
  );
}

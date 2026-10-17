import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import '../../../../core/common_widgets/app_network_image.dart';
import '../controller/profile_controller.dart';

/// Reusable avatar picker widget with camera overlay button for EditProfilePage.
class AvatarPickerWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const AvatarPickerWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: ProfileBuilderIds.editProfileAvatar,
      builder: (ctrl) {
        final selectedFile = ctrl.selectedImage.value;
        final currentPhoto = ctrl.userProfileData?.profilePhoto;
        final currentPhotoUrl = (currentPhoto != null && currentPhoto is String)
            ? currentPhoto
            : '';

        Widget avatarChild;
        if (selectedFile != null) {
          avatarChild = ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.file(
              selectedFile,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        } else {
          avatarChild = AppNetworkImage(
            imgUrl: currentPhotoUrl,
            width: 100,
            height: 100,
            borderRadius: 50,
          );
        }

        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.c2563EB, width: 2),
              ),
              child: avatarChild,
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.c2563EB,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

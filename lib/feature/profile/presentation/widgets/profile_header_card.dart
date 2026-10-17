import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import '../../../../core/common_widgets/app_network_image.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../controller/profile_controller.dart';

/// Header card widget displaying employee photo, name, role, code, and edit profile action.
class ProfileHeaderCard extends StatelessWidget {
  final ProfileController controller;

  const ProfileHeaderCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final profile = controller.userProfileData;
    final String photo = profile?.profilePhoto ?? "";

    final name =
        profile?.fullName ??
        '${profile?.firstName ?? ''} ${profile?.lastName ?? ''}'.trim();
    final displayName = name.isNotEmpty ? name : StringConstants.kNA;
    final role =
        profile?.role ??
        profile?.designation?.toString() ??
        StringConstants.kNA;
    final code = profile?.employeeCode ?? StringConstants.kNA;

    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.c0F172A, AppColors.c1E3A8A],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.c1E3A8A.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: AppNetworkImage(
              imgUrl: photo,
              width: 56,
              height: 56,
              borderRadius: 28,
            ),
          ),
          12.w,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppText(
                        displayName,
                        style: AppTextStyle.bold18White,
                      ),
                    ),
                    8.w,
                    InkWell(
                      onTap: () => Get.toNamed(AppRoutes.editProfile),
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                6.h,
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        role,
                        style: AppTextStyle.medium13Blue.copyWith(
                          color: AppColors.c93C5FD,
                        ),
                      ),
                    ),
                    if (code != StringConstants.kNA && code.isNotEmpty) ...[
                      8.w,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: AppText(code, style: AppTextStyle.bold11White),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

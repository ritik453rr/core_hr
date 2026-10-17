import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../controller/profile_controller.dart';

/// Card widget displaying security and account action ListTiles (Change Password, Sign Out).
class ProfileActionsCard extends StatelessWidget {
  final ProfileController controller;

  const ProfileActionsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.cE2E8F0),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.lock_reset_rounded,
              color: AppColors.c0284C7,
            ),
            title: const AppText(
              StringConstants.kChangePassword,
              style: AppTextStyle.semiBold14,
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.c94A3B8,
              size: 20,
            ),
            onTap: () => Get.toNamed(AppRoutes.changePassword),
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.cDC2626),
            title: const AppText(
              StringConstants.kSignOutOfAccount,
              style: AppTextStyle.semiBold14Grey,
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.cDC2626,
            ),
            onTap: controller.onTapLogout,
          ),
        ],
      ),
    );
  }
}

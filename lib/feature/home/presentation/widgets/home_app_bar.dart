import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/feature/profile/presentation/controller/profile_controller.dart';

import '../../../../core/common_widgets/app_network_image.dart';
import '../../../../core/common_widgets/app_text.dart';

/// Custom app bar for the Home screen featuring user profile and notifications.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapProfile;

  const HomeAppBar({super.key, this.onTapProfile});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final profileCtrl = Get.find<ProfileController>();

    return AppBar(
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
      toolbarHeight: 70,
      title: InkWell(
        onTap: onTapProfile,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppNetworkImage(
              imgUrl: StringConstants.kDefaultProfileImageUrl,
            ),
            12.w,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  profileCtrl.employeeName,
                  style: AppTextStyle.bold16.copyWith(color: Colors.white),
                ),
                AppText(
                  profileCtrl.employeeSubtitle,
                  style: AppTextStyle.regular11White60.copyWith(
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

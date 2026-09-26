import 'package:core_hr/core/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/feature/profile/presentation/controller/profile_controller.dart';
import '../../../../core/common_widgets/app_network_image.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../controller/home_controller.dart';

/// Custom app bar for the Home screen featuring user profile and notifications.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTapProfile;

  const HomeAppBar({super.key, this.onTapProfile});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0F172A),
      elevation: 0,
      toolbarHeight: 70,

      title: GetBuilder<ProfileController>(
        id: HomeBuilderIds.homeAppBar,
        builder: (profileCtrl) {
          final profile = profileCtrl.userProfileData;
          final name =
              profile?.fullName ?? profile?.firstName ?? StringConstants.kNA;
          final role =
              profile?.role ??
              profile?.designation?.toString() ??
              StringConstants.kNA;
          final code = profile?.employeeCode ?? StringConstants.kNA;
          final subtitle = '$role${StringConstants.kBulletSeparator}$code';
          final String photo = profile?.profilePhoto ?? "";
          return InkWell(
            onTap: onTapProfile,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppNetworkImage(imgUrl: photo),
                12.w,
                AppShimmer(
                  enable: profileCtrl.isLoadingProfile,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        name,
                        style: AppTextStyle.bold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      AppText(
                        subtitle,
                        style: AppTextStyle.regular11White60.copyWith(
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

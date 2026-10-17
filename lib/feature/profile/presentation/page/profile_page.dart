import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/common_widgets/app_loading_overlay.dart';
import 'package:core_hr/core/common_widgets/app_safe_area.dart';
import 'package:core_hr/core/common_widgets/app_text.dart';
import 'package:core_hr/core/common_widgets/custom_app_bar.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import '../controller/profile_controller.dart';
import '../widgets/profile_actions_card.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_info_card.dart';

/// User profile page displaying detailed employee information and account settings.
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: StringConstants.kMyProfile),
      body: Stack(
        children: [
          _buildBody(),

          GetBuilder<ProfileController>(
            id: ProfileBuilderIds.loadingOverlay,
            builder: (ctrl) {
              return AppLoadingOverlay(
                enable: ctrl.showLoadingOverlay,
                showLoader: true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return GetBuilder<ProfileController>(
      id: ProfileBuilderIds.profilePage,
      builder: (controller) {
        return AppSafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Employee Header Card ---
                ProfileHeaderCard(controller: controller),
                20.h,

                // --- Personal & Employment Details ---
                const AppText(
                  StringConstants.kPersonalAndEmploymentDetails,
                  style: AppTextStyle.bold16,
                ),
                12.h,
                ProfileInfoCard(controller: controller),
                24.h,

                // --- Account Actions ---
                const AppText(
                  StringConstants.kAccountAndSecurityActions,
                  style: AppTextStyle.bold16,
                ),
                12.h,
                ProfileActionsCard(controller: controller),
                24.h,
              ],
            ),
          ),
        );
      },
    );
  }
}

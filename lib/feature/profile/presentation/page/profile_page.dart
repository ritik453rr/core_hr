import 'package:core_hr/core/common_widgets/app_loading_overlay.dart';
import 'package:core_hr/core/common_widgets/app_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/language/string_constants.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import '../../../../core/common_widgets/app_network_image.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../../../../core/common_widgets/custom_app_bar.dart';
import '../controller/profile_controller.dart';

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
            builder: (logic) {
              return AppLoadingOverlay(
                enable: controller.showLoadingOverlay,
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
                _buildProfileHeaderCard(controller),
                20.h,

                // --- Personal & Employment Details ---
                const AppText(
                  StringConstants.kPersonalAndEmploymentDetails,
                  style: AppTextStyle.bold16,
                ),
                12.h,
                _buildInfoCard(controller),
                24.h,

                // --- Account Actions ---
                const AppText(
                  StringConstants.kAccountAndSecurityActions,
                  style: AppTextStyle.bold16,
                ),
                12.h,
                _buildActionsCard(controller),
                24.h,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeaderCard(ProfileController controller) {
    final profile = controller.userProfileData;
    final String photo = profile?.profilePhoto??"";

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
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: AppNetworkImage(
                  imgUrl: photo,
                  width: 72,
                  height: 72,
                  borderRadius: 36,
                ),
              ),
              16.w,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(displayName, style: AppTextStyle.bold18White),
                    4.h,
                    AppText(
                      role,
                      style: AppTextStyle.medium13Blue.copyWith(
                        color: AppColors.c93C5FD,
                      ),
                    ),
                    if (code != StringConstants.kNA && code.isNotEmpty) ...[
                      8.h,
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: AppText(code, style: AppTextStyle.bold11White),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ProfileController controller) {
    final profile = controller.userProfileData;
    final department = profile?.department ?? StringConstants.kNA;
    final email = profile?.email ?? StringConstants.kNA;
    final phoneCode = profile?.phoneCode ?? '';
    final rawPhone = profile?.phone ?? '';
    final phone = '$phoneCode $rawPhone'.trim();
    final displayPhone = phone.isNotEmpty ? phone : StringConstants.kNA;

    final shift = profile?.shift;
    final workShift =
        (shift != null && (shift.name != null || shift.startTime != null))
        ? '${shift.name ?? ''} (${shift.startTime ?? ''} - ${shift.endTime ?? ''})'
              .trim()
        : StringConstants.kNA;
    final manager = profile?.manager ?? StringConstants.kNA;
    final location = profile?.branch ?? StringConstants.kNA;

    final infoTiles = <Widget>[];

    if (department != StringConstants.kNA && department.isNotEmpty) {
      infoTiles.add(
        _infoTile(
          Icons.business_rounded,
          StringConstants.kDepartment,
          department,
        ),
      );
    }

    if (email != StringConstants.kNA && email.isNotEmpty) {
      if (infoTiles.isNotEmpty) {
        infoTiles.add(const Divider(height: 1, indent: 50, endIndent: 16));
      }
      infoTiles.add(
        _infoTile(
          Icons.mail_outline_rounded,
          StringConstants.kEmailAddress,
          email,
        ),
      );
    }

    if (displayPhone != StringConstants.kNA && displayPhone.isNotEmpty) {
      if (infoTiles.isNotEmpty) {
        infoTiles.add(const Divider(height: 1, indent: 50, endIndent: 16));
      }
      infoTiles.add(
        _infoTile(
          Icons.phone_iphone_rounded,
          StringConstants.kPhoneNumber,
          displayPhone,
        ),
      );
    }

    if (workShift != StringConstants.kNA && workShift.isNotEmpty) {
      if (infoTiles.isNotEmpty) {
        infoTiles.add(const Divider(height: 1, indent: 50, endIndent: 16));
      }
      infoTiles.add(
        _infoTile(
          Icons.schedule_rounded,
          StringConstants.kWorkShift,
          workShift,
        ),
      );
    }

    if (manager != StringConstants.kNA && manager.isNotEmpty) {
      if (infoTiles.isNotEmpty) {
        infoTiles.add(const Divider(height: 1, indent: 50, endIndent: 16));
      }
      infoTiles.add(
        _infoTile(
          Icons.supervisor_account_rounded,
          StringConstants.kReportingManager,
          manager,
        ),
      );
    }

    if (location != StringConstants.kNA && location.isNotEmpty) {
      if (infoTiles.isNotEmpty) {
        infoTiles.add(const Divider(height: 1, indent: 50, endIndent: 16));
      }
      infoTiles.add(
        _infoTile(
          Icons.location_on_outlined,
          StringConstants.kOfficeLocation,
          location,
        ),
      );
    }

    if (infoTiles.isEmpty) {
      return Container(
        width: Get.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cE2E8F0),
        ),
        child: const AppText(
          'No details available.',
          style: AppTextStyle.regular14Grey,
        ),
      );
    }

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cE2E8F0),
      ),
      child: Column(children: infoTiles),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.c2563EB, size: 22),
          14.w,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(label, style: AppTextStyle.semiBold11Grey),
                2.h,
                AppText(value, style: AppTextStyle.semiBold14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard(ProfileController controller) {
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

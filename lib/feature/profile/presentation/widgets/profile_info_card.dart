import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/language/string_constants.dart';
import '../../../../core/common_widgets/app_text.dart';
import '../controller/profile_controller.dart';

/// Card widget displaying personal and employment info tiles.
class ProfileInfoCard extends StatelessWidget {
  final ProfileController controller;

  const ProfileInfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
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
          StringConstants.kNoDetailsAvailable,
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
}

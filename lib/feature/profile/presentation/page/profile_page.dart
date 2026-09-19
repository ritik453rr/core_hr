import 'package:core_hr/core/constants/shared_imports.dart';
import '../controller/profile_controller.dart';

/// User profile page displaying detailed employee information and account settings.
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.kMyProfile,
          style: AppTextStyle.bold18White,
        ),
        backgroundColor: AppColors.c0F172A,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.badge_outlined, color: Colors.white),
            tooltip: StringConstants.kDownloadIdCard,
            onPressed: controller.downloadIdCard,
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            tooltip: StringConstants.kEditProfileInfo,
            onPressed: controller.editProfileInfo,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: GetBuilder<ProfileController>(
        id: ProfileController.profileId,
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Employee Header Card ---
                _buildProfileHeaderCard(controller),
                const SizedBox(height: 20),

                // --- Stats Summary Row ---
                _buildStatsRow(controller),
                const SizedBox(height: 20),

                // --- Work & Personal Details ---
                const Text(
                  StringConstants.kPersonalAndEmploymentDetails,
                  style: AppTextStyle.bold16,
                ),
                const SizedBox(height: 12),
                _buildInfoCard(controller),
                const SizedBox(height: 24),

                // --- Account Actions ---
                const Text(
                  StringConstants.kAccountAndSecurityActions,
                  style: AppTextStyle.bold16,
                ),
                const SizedBox(height: 12),
                _buildActionsCard(controller),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeaderCard(ProfileController controller) {
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
                  imgUrl: controller.profileImageUrl,
                  width: 72,
                  height: 72,
                  borderRadius: 36,
                  placeholder: (context, url) => Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: AppColors.c2563EB,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        controller.employeeInitials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: AppColors.c2563EB,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        controller.employeeInitials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.employeeName,
                      style: AppTextStyle.bold18White,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.employeeRole,
                      style: AppTextStyle.medium13Blue
                          .copyWith(color: AppColors.c93C5FD),
                    ),
                    const SizedBox(height: 8),
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
                      child: Text(
                        controller.employeeId,
                        style: AppTextStyle.bold11White,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(ProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: _statTile(
            StringConstants.kExperience,
            controller.totalExperience,
            Icons.work_history_rounded,
            AppColors.c2563EB,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statTile(
            StringConstants.kLeaveBal,
            controller.leaveBalance,
            Icons.event_available_rounded,
            AppColors.c10B981,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statTile(
            StringConstants.kActiveLoan,
            controller.activeLoan,
            Icons.account_balance_rounded,
            AppColors.cD97706,
          ),
        ),
      ],
    );
  }

  Widget _statTile(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cE2E8F0),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTextStyle.semiBold11Grey,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyle.bold14,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(ProfileController controller) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cE2E8F0),
      ),
      child: Column(
        children: [
          _infoTile(
            Icons.business_rounded,
            StringConstants.kDepartment,
            controller.department,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.mail_outline_rounded,
            StringConstants.kEmailAddress,
            controller.email,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.phone_iphone_rounded,
            StringConstants.kPhoneNumber,
            controller.phone,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.calendar_today_rounded,
            StringConstants.kDateOfJoining,
            controller.joiningDate,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(Icons.schedule_rounded, StringConstants.kWorkShift,
              controller.workShift),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.supervisor_account_rounded,
            StringConstants.kReportingManager,
            controller.manager,
          ),
          const Divider(height: 1, indent: 50, endIndent: 16),
          _infoTile(
            Icons.location_on_outlined,
            StringConstants.kOfficeLocation,
            controller.location,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String label,
    String value, {
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.c2563EB, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyle.semiBold11Grey,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyle.semiBold14,
                ),
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
            leading:
                const Icon(Icons.lock_reset_rounded, color: AppColors.c0284C7),
            title: const Text(
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
            title: const Text(
              StringConstants.kSignOutOfAccount,
              style: AppTextStyle.semiBold14Grey,
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.cDC2626,
            ),
            onTap: controller.logout,
          ),
        ],
      ),
    );
  }
}
